data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "minwook-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "ap-northeast-2"
  }
}