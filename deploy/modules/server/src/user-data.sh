#!/bin/bash
sudo yum update -y
sudo yum install git pip aws-kinesis-agent -y
sudo pip install pytz
sudo pip install numpy
sudo pip install faker
sudo pip install tzlocal;
git clone https://github.com/kiritbasu/Fake-Apache-Log-Generator.git
cd Fake-Apache-Log-Generator
git reset --hard 06c38c589100358df7cad380128ea53bc79d2acc
sudo mkdir /tmp/logs;
sudo cp ./apache-fake-log-gen.py /tmp/logs
cd /tmp/logs
sudo python /tmp/logs/apache-fake-log-gen.py -n 0 -o LOG &
sudo python /tmp/logs/apache-fake-log-gen.py -n 0 -o LOG &
sudo python /tmp/logs/apache-fake-log-gen.py -n 0 -o LOG &

sudo cat > /etc/aws-kinesis/agent.json << EOF
{
  "firehose.endpoint": "firehose.${REGION}.amazonaws.com",
  "flows": [
    {
      "filePattern": "/tmp/logs/access_log*",
      "deliveryStream": "${DELIVERY_STREAM}",
      "dataProcessingOptions": [
        {
          "optionName": "LOGTOJSON",
          "logFormat": "COMMONAPACHELOG"
      }]
    }
  ]}
}
EOF
sudo service aws-kinesis-agent start
