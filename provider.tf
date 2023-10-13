terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.0"
    }
  }

  backend "s3" {
    bucket         = "ecs-terraform-manifests"
    key            = "production/k8sengineers/ecs/app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-visualpathtech"
  }
}

provider "aws" {
  # Configuration options
  region = var.region_code
}