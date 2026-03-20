# Find the VPC by its Name tag in LocalStack
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["eks-tech-challenge-local-vpc"]
  }
}

# Find all Private Subnets for the DB Subnet Group
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*-private-*"]
  }
}

# Find the EKS Security Group
data "aws_security_group" "eks_cluster" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "tag:Name"
    values = ["eks-tech-challenge-local-cluster-sg"]
  }
}
