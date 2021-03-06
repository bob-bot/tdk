# AWS S3 encryption policies

Provides a Terraform configuration for creating a smart folder and creating policies that check S3 bucket encryption settings - encryption at rest and object encryption in transit. 


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the S3 encryption example:
- Navigate to the directory on the command line `cd aws_s3_encryption`.
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied.
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings.
