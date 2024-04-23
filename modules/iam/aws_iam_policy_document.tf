module "iam_policy" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version     = "v5.37.2"
  name        = module.label_get_all_authors.id
  path        = "/"
  description = "My example policy"

  policy = data.aws_iam_policy_document.get_all_authours.json
}

module "iam_policy_courses" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version     = "v5.37.2"
  name        = module.label_get_all_courses.id
  path        = "/"
  description = "My example policy"

  policy = data.aws_iam_policy_document.get_all_courses.json
}

data "aws_iam_policy_document" "get_all_authours" {
  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:UpdateItem"
    ]
    resources = [var.table_authors_arn]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${var.cloudwatch_log_group_get_all_authours_arn}:*:*",
      "${var.cloudwatch_log_group_get_all_authours_arn}:*"
    ]
  }

}

data "aws_iam_policy_document" "get_all_courses" {
  statement {
    actions = [
      "dynamodb:Scan",
    ]
    resources = [var.table_courses_arn]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${var.cloudwatch_log_group_get_all_courses_arn}:*:*",
      "${var.cloudwatch_log_group_get_all_courses_arn}:*"
    ]
  }

}