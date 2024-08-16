terraform {
  backend "s3" {
    bucket         = "sock-bucket-98"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lockfile"
    encrypt = true
  }
}