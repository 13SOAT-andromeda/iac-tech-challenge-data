output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "catalog_database_endpoint" {
  description = "The endpoint of the catalog RDS instance"
  value       = module.catalog_database.db_instance_endpoint
}

output "payments_database_endpoint" {
  description = "The endpoint of the payments RDS instance"
  value       = module.payments_database.db_instance_endpoint
}

output "users_database_endpoint" {
  description = "The endpoint of the users RDS instance"
  value       = module.users_database.db_instance_endpoint
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = module.dynamodb.table_arn
}

output "orders_dynamodb_table_arn" {
  description = "The ARN of the orders DynamoDB table"
  value       = module.orders_dynamodb.table_arn
}
