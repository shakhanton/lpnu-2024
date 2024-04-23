module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = var.context
}

module "label_get_all_authours" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name    = "get-all-authors"
}

module "label_get_all_courses" {
  source  = "cloudposse/label/null"
  version = "0.25.0"
  context = module.label.context
  name    = "get-all-courses"
}

module "lambda_function_authors" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.3"
  publish = true

  function_name = module.label_get_all_authours.id
  description   = "Get all authors"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  create_role   = false


  lambda_role = var.role_get_all_authours_arn

  source_path = "${path.module}/src/get_all_authors"

  environment_variables = {
    TABLE_NAME = var.table_authors_name
  }

  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "${var.aws_api_gateway_rest_api_execution_arn}/*/*/*"
    }
  }

  use_existing_cloudwatch_log_group = true
  logging_log_group                 = var.logging_log_group_authors

  tags = module.label_get_all_authours.tags
}

module "lambda_function_courses" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.3"
  publish = true

  function_name = module.label_get_all_courses.id
  description   = "Get all courses"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  create_role   = false


  lambda_role = var.role_get_all_courses_arn

  source_path = "${path.module}/src/get_all_courses"

  environment_variables = {
    TABLE_NAME = var.table_courses_name
  }

  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "${var.aws_api_gateway_rest_api_execution_arn}/*/*/*"
    }
  }
  tags = module.label_get_all_courses.tags
}