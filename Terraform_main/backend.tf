terraform {
  backend "s3" {
    bucket         = "jovals_Bucket_for_capstone16_08_1960"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lockfile-for-capstone"
    encrypt = true
  }
}