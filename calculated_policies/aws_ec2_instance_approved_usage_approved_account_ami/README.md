# AWS EC2 Instance - Restrict Instance images to trusted AWS accounts AMIs

## Use case

Use this policy if you would like to restrict the usage of EC2 Instance images to AMIs owned by AWS accounts that are trusted.

## Implementation Details

Calculated policy for policy `AWS > EC2 > Instance > Approved > Usage`.
If a EC2 Instance Image is not owned by an account in the approved accounts list, then the approved usage
policy will be set to `Not approved` otherwise it will be set to `Approved`.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

GraphQL query that will get the Instance Image.

```graphql
- {
  item: resource {
    imageId: get(path: "ImageId")
    turbot {
      custom
    }
  }
}
- {
  resources (filter: "resourceType:'tmod:@turbot/aws-ec2#/resource/types/Ami' $.ImageId:'{{$.item.imageId}}'") {
    items {
      ownerId: get(path:"OwnerId")
    }
  }
}
```

### Template (Nunjucks)

Approval logic for EC2 Instance trusted AWS accounts AMIs.
If Instance Image ownerId is not in `approvedAccounts` list, then it will return `Not approved`.

```nunjucks
{% set approvedAccounts = [
    "${join("\",\n      \"", var.approved_account_ami_list)}"
  ]
%}
{% if $.resources.items and $.resources.items[0].ownerId in approvedAccounts %}
  "Approved"
{% else %}
  "Not approved"
{% endif %}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To create the smart folder, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- smart_folder_title
- target_resource
- approved_account_ami_list

Open the file [variables.tf](variables.tf) for further details.

### Initialize Terraform

If not previously run then initialize Terraform to get all necessary providers.

Command: `terraform init`

### Apply using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform apply -var-file=default.tfvars`

### Apply using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform apply -var-file=<custom_filename>.tfvars`

### Destroy using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform destroy -var-file=default.tfvars`

### Destroy using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform destroy -var-file=<custom_filename>.tfvars`