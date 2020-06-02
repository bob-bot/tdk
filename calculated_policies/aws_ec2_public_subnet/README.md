# AWS EC2 - Instance Not Approved if Public Subnet

## Use case

There is an organizational requirement that in specific accounts, no EC2 instance can be booted within a subnet with 
an associated route table which has routes pointing to an Internet Gateway (IGW).

## Implementation Details

This script provides a Terraform configuration for creating a smart folder and applying a calculated policy using 
`AWS > EC2 > Instance > Approved > Usage` policy and then setting `AWS > EC2 > Instance > Approved` to check.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

This query is two-fold. First, it finds the subnet ID contained within the EC2 instance metadata. 
Second, all route tables in the account are found, and the associated subnet ID as well as the collection of routes.

```graphql
{
  resource {
    subnetId: get(path: "SubnetId")
  }
  resources(filter:"resourceType:'tmod:@turbot/aws-vpc-core#/resource/types/routeTable'") {
    items {
      associations: get(path: "Associations.[0].SubnetId")
      routes: get(path: "Routes")
    }
  }
}
```

### Template (Nunjucks)

```nunjucks
{%- set hasIGW = false -%}
{%- for item in $.resources.items -%}
  {%- if item.associations == $.resource.subnetId -%}
    {%- for gateway in item.routes -%}
      {%- if 'igw' in gateway.GatewayId -%}
        {%- if hasIGW == false -%}
          "Not approved"
          {%- set hasIGW = true -%}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}
  {%- endif -%}
{%- endfor -%}
{%- if hasIGW == false -%}
  "Approved if AWS > EC2 > Enabled"
{%- endif -%}
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

- smart_folder_title (Optional)

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