output "table_arn" {
  description = "The ARN of the orders DynamoDB table"
  value       = aws_dynamodb_table.orders.arn
}

output "table_name" {
  description = "The name of the orders DynamoDB table"
  value       = aws_dynamodb_table.orders.name
}
