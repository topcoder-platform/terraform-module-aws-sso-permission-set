
output "permission_set_arn" {
  description = "ARN of the created AWS SSO permission set"
  value       = aws_ssoadmin_permission_set.sso_permission_set.arn
}

output "group_arn" {
  description = "ARN of the created/assigned group for the permission set"
  value       = var.create_new_group ? aws_iam_group.sso_group[0].arn : var.existing_group
}