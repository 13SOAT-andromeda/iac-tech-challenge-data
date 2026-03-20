terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "tech-challenge-bucket-andromeda-local"
    key    = "tech-challenge-data-local/terraform.tfstate"
    region = "us-east-1"
    
    # LocalStack specific backend settings
    endpoints = {
      s3  = "http://localhost:4566"
      iam = "http://localhost:4566"
      sts = "http://localhost:4566"
    }
    
    access_key                  = "test"
    secret_key                  = "test"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = false
    use_path_style              = true
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"
  
  # Optimization for LocalStack
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = false
  s3_use_path_style           = true

  # Only necessary endpoints for the data layer
  endpoints {
    ec2      = "http://localhost:4566"
    rds      = "http://localhost:4566"
    s3       = "http://localhost:4566"
    iam      = "http://localhost:4566"
    sts      = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
  }

  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "localstack"
      Project     = "tech-challenge"
    }
  }
}

module "rds" {
  source                = "../modules/rds"
  db_password           = var.db_password
  vpc_id                = data.aws_vpc.selected.id
  subnet_ids            = data.aws_subnets.private.ids
  eks_security_group_id = data.aws_security_group.eks_cluster.id
}

module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = "user-authentication-token"
  hash_key   = "token_id"
}
