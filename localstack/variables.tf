variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "postgreslocal"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "garagedb"
}

variable "db_user" {
  description = "Database master username"
  type        = string
  default     = "postgres"
}
