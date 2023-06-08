resource "aws_ssoadmin_permission_set" "sso_permission_set" {
  name        = var.permission_set_name
  description = "AWS SSO Permission Set"

  inline_policy {
    permission_set_arn = aws_ssoadmin_permission_set.sso_permission_set.arn
    policy_document   = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": var.iam_permissions,
          "Resource": "*"
        }
      ]
    })
  }
}

resource "aws_ssoadmin_account_assignment" "sso_account_assignment" {
  count = var.create_new_group ? 1 : 0

  target_id      = aws_iam_group.sso_group.id
  target_type    = "AWS::IAM::Group"
  permission_set = aws_ssoadmin_permission_set.sso_permission_set.id
}

resource "aws_iam_group" "sso_group" {
  count       = var.create_new_group ? 1 : 0
  name_prefix = "sso_group_"
}

resource "aws_ssoadmin_managed_policy_attachment" "sso_managed_policy_attachment" {
  count        = var.create_new_group ? 1 : 0
  managed_policy_arn = aws_iam_policy.sso_managed_policy.arn
  permission_set_arn = aws_ssoadmin_permission_set.sso_permission_set.arn
}

resource "aws_iam_policy" "sso_managed_policy" {
  count       = var.create_new_group ? 1 : 0
  name        = "sso_managed_policy"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": var.iam_permissions,
        "Resource": "*"
      }
    ]
  })
}

resource "aws_ssoadmin_account_assignment" "sso_existing_group_assignment" {
  count = var.existing_group != "" ? 1 : 0

  target_id      = var.existing_group
  target_type    = "AWS::IAM::Group"
  permission_set = aws_ssoadmin_permission_set.sso_permission_set.id
}
