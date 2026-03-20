# IaC Tech Challenge - Data Layer

Infrastructure as Code (IaC) for setting up the data layer, including RDS (PostgreSQL) and DynamoDB, supporting both standard AWS environments and local development via LocalStack.

## Project Structure

- `modules/`: Reusable Terraform modules.
  - `rds/`: PostgreSQL database instance configuration.
  - `dynamodb/`: DynamoDB table configuration for user authentication tokens.
- `aws/`: Root configuration for deploying to a real AWS environment (configured for AWS Academy/Lab roles).
- `localstack/`: Root configuration for local testing using LocalStack.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0+)
- [LocalStack](https://localstack.cloud/) (for local development)
- [AWS CLI](https://aws.amazon.com/cli/)

## Getting Started

### Local Development (LocalStack)

1. Start LocalStack:
   ```bash
   localstack start -d
   ```

2. Initialize and apply:
   ```bash
   cd localstack
   terraform init
   terraform apply
   ```

### AWS Deployment

1. Ensure your AWS credentials are configured.
2. Initialize and apply:
   ```bash
   cd aws
   terraform init
   terraform apply
   ```

## Configuration

The data layer depends on an existing network infrastructure (VPC and Subnets).
- **RDS:** Deployed in private subnets with access restricted to the EKS cluster security group.
- **DynamoDB:** Configured with a Global Secondary Index for efficient user-based lookups.

### State Management
Terraform state is stored in S3 with the following prefixes to avoid conflicts:
- **AWS:** `tech-challenge-data/terraform.tfstate`
- **LocalStack:** `tech-challenge-data-local/terraform.tfstate`
