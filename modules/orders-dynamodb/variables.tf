variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default     = "orders"
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput"
  type        = string
  default     = "PAY_PER_REQUEST"
}
