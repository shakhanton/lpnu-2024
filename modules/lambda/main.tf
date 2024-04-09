module "label" {
  source   = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
}

module "label_get_all_authours" {
  source   = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name = "get-all-authors"
}

module "label_get_all_courses" {
  source   = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name = "get-all-courses"
}

module "lambda_function_authors" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.2.3"

  function_name = module.label_get_all_authours.id
  description   = "Get all authors"
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

module "lambda_function_courses" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.2.3"

  function_name = module.label_get_all_courses.id
  description   = "Get all courses"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  create_role     = false


  lambda_role = var.role_get_all_courses_arn

  source_path = "${path.module}/src/get_all_courses"

  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  tags = module.label_get_all_courses.tags
}