variable "permission_set_name" {
  description = "Name of the AWS SSO permission set"
  type        = string
}

variable "iam_permissions" {
  description = "List of IAM permissions to associate with the permission set"
  type        = list(string)
}

variable "existing_group" {
  description = "Existing group ARN to which the permission set will be assigned"
  type        = string
  default     = ""
}

variable "create_new_group" {
  description = "Whether to create a new group for the permission set"
  type        = bool
  default     = false
}