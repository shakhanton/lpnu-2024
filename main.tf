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
}



resource "aws_s3_bucket" "this" {
#   bucket  = "657694663228-my-tf-test-bucket-new"
  bucket  = module.label_s3.id

tags = module.label_s3.tags
}


