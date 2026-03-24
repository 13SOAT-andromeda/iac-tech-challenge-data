terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    key     = "tech-challenge-data/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = "dev"
      Project     = "tech-challenge"
    }
  }
}

module "rds" {
  source                = "../modules/rds"
  db_password           = var.db_password
  vpc_id                = data.aws_vpc.selected.id
  subnet_ids            = data.aws_subnets.public.ids
  eks_security_group_id = data.aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = "user-authentication-token"
  hash_key   = "token_id"
}
