terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70"
    }
  }
}
provider "aws" {
  region = "us-west-2" # Change this to your desired region
}
