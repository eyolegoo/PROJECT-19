#-----------root/backend.tf----------------
terraform {
  backend "s3" {
    bucket         = "lego-18-bucket"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

