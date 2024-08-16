terraform {
  backend "s3" {
    bucket         = "jovals_Bucket_capstone_93"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lockfile-for-capstone_93"
    encrypt = true
  }
}