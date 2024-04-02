module "label" {
  source   = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
}

module "label_get_all_authours" {
  source   = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name = "get-all-authours"
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.2.3"

  function_name = module.label_get_all_authours.id
  description   = "My awesome lambda function"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  create_role     = false


  lambda_role = var.role_get_all_authours_arn

  source_path = "${path.module}/src/get_all_authors"

  environment_variables = {
    TABLE_NAME = var.table_authors_name
  }

  tags = module.label_get_all_authours.tags
}