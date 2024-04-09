locals {
  tag_name = var.use_locals ? "forum" : var.bucket_name
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "${data.aws_caller_identity.current.account_id}-my-tf-test-bucket-new-module-${data.aws_caller_identity.current.account_id}"
}

module "table_authors" {
  source = "./modules/dynamodb"
  context = module.label.context
  name = "authors"
}

module "table_courses" {
  source = "./modules/dynamodb"
  context = module.label.context
  name = "courses"
}

module "lambdas" {
  source = "./modules/lambda"
  context = module.label.context
  table_authors_name = module.table_authors.id
  role_get_all_authours_arn = module.iam.role_get_all_authours_arn
  table_courses_name = module.table_courses.id
  role_get_all_courses_arn = module.iam.role_get_all_courses_arn
}

module "iam" {
  source = "./modules/iam"
  context = module.label.context
  table_authors_arn = module.table_authors.arn
  cloudwatch_log_group_get_all_authours_arn = module.cloudwatch.cloudwatch_log_group_get_all_authours_arn
  table_courses_arn = module.table_courses.arn
  cloudwatch_log_group_get_all_courses_arn = module.cloudwatch.cloudwatch_log_group_get_all_courses_arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  context = module.label.context
}
