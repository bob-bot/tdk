# Check if Lambda Functions are not in VPC
# Set policy to check unapproved Functions

# AWS > Lambda > Function > Approved
# https://turbot.com/v5/mods/turbot/aws-lambda/inspect#/policy/types/functionApproved
resource "turbot_policy_setting" "aws_lambda_function_approved" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApproved"
  value    = "Check: Approved"
}

# Calculated policy to check if VpcConfig details are defined on the Function
# If there are no VpcConfig details, the Function is not within a VPC
# AWS > Lambda > Function > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-lambda/inspect#/policy/types/functionApprovedUsage
resource "turbot_policy_setting" "aws_lambda_function_approved_usage" {
  resource       = turbot_smart_folder.aws_public_access.id
  type           = "tmod:@turbot/aws-lambda#/policy/types/functionApprovedUsage"
  template_input = <<-QUERY
        {
            resource{
                object
            }
        }
        QUERY

  # Nunjucks template evaluate metadata.
  template = <<-TEMPLATE
        {% if 'VpcConfig' in $.resource.object %}
            Approved
        {% else %}
            Not approved
        {% endif %}
        TEMPLATE
}
