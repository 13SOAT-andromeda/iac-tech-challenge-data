data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["eks-tech-challenge-vpc"]
  }
}

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

data "aws_security_group" "eks_cluster" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "group-name"
    values = ["eks-tech-challenge-cluster-sg"]
  }
}
