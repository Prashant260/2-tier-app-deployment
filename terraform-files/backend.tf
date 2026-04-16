terraform {
  backend "s3" {
    bucket         = "prashant-terraform-state-bucket-12345"
    key            = "two-tier-app/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}