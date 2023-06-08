# AWS SSO Permission Set Terraform Module

This Terraform module creates an AWS SSO permission set and allows you to define IAM permissions to associate with the permission set. It provides the option to assign the permission set to an existing group or create a new group in AWS.

## Usage

```hcl
provider "aws" {
  region = "us-west-2"  # Replace with your desired region
}

module "aws_sso_permission_set" {
  source              = "./aws_sso_permission_set"
  permission_set_name = "MyPermissionSet"
  iam_permissions     = local.permissions_data.iam_permissions
  existing_group      = "arn:aws:iam::123456789012:group/ExistingGroup"  # Replace with the ARN of your existing group
}

output "permission_set_id" {
  description = "The ID of the AWS SSO permission set"
  value       = module.aws_sso_permission_set.permission_set_id
}

output "group_arn" {
  description = "The ARN of the IAM group associated with the permission set"
  value       = module.aws_sso_permission_set.group_arn
}
```

## Input Variables

permission_set_name: (Required) The name of the AWS SSO permission set.
iam_permissions: (Required) List of IAM permissions to associate with the permission set.
existing_group: (Optional) Existing group ARN to which the permission set will be assigned. If not provided, a new group will be created.
create_new_group: (Optional) Whether to create a new group for the permission set. Default is false.

## Example Permissions JSON File

Create a permissions.json file with the following content:

```hcl

{
  "iam_permissions": [
    "iam:CreateUser",
    "iam:DeleteUser",
    "iam:ListUsers",
    "s3:GetObject",
    "s3:PutObject",
    "s3:ListBucket",
    "ec2:DescribeInstances",
    "ec2:RunInstances",
    "ec2:TerminateInstances",
    "rds:CreateDBInstance",
    "rds:DeleteDBInstance",
    "rds:DescribeDBInstances",
    "dynamodb:CreateTable",
    "dynamodb:DeleteTable",
    "dynamodb:DescribeTable"
  ]
}
```


Update the module usage in main.tf to include the path to the permissions.json file:


```hcl
locals {
  permissions_data = jsondecode(file("permissions.json"))
}

module "aws_sso_permission_set" {
  source              = "./aws_sso_permission_set"
  permission_set_name = "MyPermissionSet"
  iam_permissions     = local.permissions_data.iam_permissions
  existing_group      = "arn:aws:iam::123456789012:group/ExistingGroup"  # Replace with the ARN of your existing group
}
```


Make sure the permissions.json file is in the same directory as the main.tf file.

## Outputs

permission_set_id: The ID of the AWS SSO permission set.
group_arn: The ARN of the IAM group associated with the permission set.

Please note that the AWS provider configuration is not included in the example above. Make sure to configure the AWS provider block appropriately before using the module.