#!/bin/bash
sudo yum update -y
sudo yum install git pip aws-kinesis-agent -y
sudo pip install pytz
sudo pip install numpy
sudo pip install faker
sudo pip install tzlocal;
git clone https://github.com/kiritbasu/Fake-Apache-Log-Generator.git
sudo mkdir /tmp/logs;
sudo cp ./Fake-Apache-Log-Generator/apache-fake-log-gen.py /tmp/logs
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
