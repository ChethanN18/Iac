provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "my-terrastate-bucket"
    key    = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "my-terra-lock"
  }
}

