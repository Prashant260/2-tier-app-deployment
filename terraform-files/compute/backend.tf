terraform {
  backend "s3" {
    bucket         = "prashant-terraform-state-bucket-12345"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}