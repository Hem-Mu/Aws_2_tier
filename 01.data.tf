terraform {
  backend "s3" {
    bucket         = "minwook-terraform-state-bucket" # bucket name
    key            = "3tier/terraform.tfstate" # tfstate file save path
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock" # DDB name.
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "minwook-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "ap-northeast-2"
  }
}