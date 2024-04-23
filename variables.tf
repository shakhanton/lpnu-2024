variable "bucket_name" {
  type    = string
  default = "657694663228-my-tf-test-bucket-new"
}

variable "slack_webhook_url" {
  type = string
}

variable "use_locals" {
  type    = bool
  default = true
}