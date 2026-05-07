terraform {
  backend "s3" {
    bucket         = "aide-terraform-state-us-east-1"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aide-terraform-state-lock"
    encrypt        = true
  }
}
