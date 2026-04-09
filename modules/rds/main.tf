resource "aws_db_subnet_group" "main" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds" {
  name        = "${var.db_name}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.db_name}-rds-sg"
  }
}

resource "aws_security_group_rule" "eks_ingress" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = var.eks_security_group_id
  description              = "Allow PostgreSQL traffic from EKS Cluster"
}

resource "aws_security_group_rule" "lambda_ingress" {
  count                    = var.lambda_security_group_id != "" ? 1 : 0
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = var.lambda_security_group_id
  description              = "Allow PostgreSQL traffic from Lambda"
}

data "aws_vpc" "this" {
  id = var.vpc_id
}

resource "aws_security_group_rule" "vpc_ingress" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.rds.id
  cidr_blocks       = [data.aws_vpc.this.cidr_block]
  description       = "Allow internal VPC traffic to RDS (Required for EKS Nodes and Lambda)"
}

resource "aws_db_instance" "main" {
  identifier        = var.db_name
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_user
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  publicly_accessible = false
}
