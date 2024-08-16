terraform {
  backend "s3" {
    bucket         = "jovals-bucket-capstone-93"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    # dynamodb_table = "terraform-lockfile-for-capstone-93"
    encrypt = true
  }
}