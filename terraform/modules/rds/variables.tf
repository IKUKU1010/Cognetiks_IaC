variable "db_name" {
  description = "The name of the RDS database instance"
  type        = string
}

variable "username" {
  description = "Master username for RDS"
  type        = string
}

variable "subnets" {
  description = "Subnets for RDS subnet group"
  type        = list(string)
}

variable "sg_ids" {
  description = "Security group IDs for the RDS instance"
  type        = list(string)
}
