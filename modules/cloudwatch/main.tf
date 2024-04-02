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

resource "aws_cloudwatch_log_group" "get_all_authours" {
  name = module.label_get_all_authours.id
  tags = module.label_get_all_authours.tags
  retention_in_days = 90
}