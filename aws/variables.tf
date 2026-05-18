variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
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

variable "catalog_db_name" {
  description = "Database name for Catalog API"
  type        = string
  default     = "catalog_db"
}

variable "payments_db_name" {
  description = "Database name for Payments API"
  type        = string
  default     = "payments_db"
}
