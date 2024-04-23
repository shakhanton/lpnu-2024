module "front_application" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v4.1.1"

  bucket = module.label_front_app.id
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.front_application.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [module.cdn.cloudfront_origin_access_identity_ids[0]]
    }
  }
}

# resource "aws_s3_bucket_policy" "this" {
#   bucket = module.front_application.s3_bucket_id
#   policy = data.aws_iam_policy_document.s3_policy.json
# }