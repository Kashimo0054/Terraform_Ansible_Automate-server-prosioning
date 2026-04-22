terraform {
  backend "s3" {
    bucket  = "sumeet-terraform-state-bucket"
    key     = "ansible-project/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
