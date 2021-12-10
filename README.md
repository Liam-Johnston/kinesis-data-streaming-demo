# Kinesis Workshop

Testing with AWS Kinesis.

## Usage

1. Update values for `project`, `owner`, `initials` and `ssh_key_name` in [`config/terraform.tfvars`](config/terraform.tfvars).

`Initials` value is used with Elasticsearch domain as `owner` may be too long for the domain value.

2. Update `TF_STATE_BUCKET` and `TF_STATE_KEY` in Makefile.

3. Execute Terraform using Makefile commands:
```
make init
make plan
make apply
```

