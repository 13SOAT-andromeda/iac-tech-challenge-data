# Find the VPC by its Name tag
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["eks-tech-challenge-vpc"]
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

# Find the EKS cluster to get the security group attached to the worker nodes
data "aws_eks_cluster" "main" {
  name = "eks-tech-challenge"
}
