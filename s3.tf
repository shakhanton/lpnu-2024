module "front_application" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "v4.1.1"

  bucket = module.label_front_app.id
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

}