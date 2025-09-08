variable "region" {
  default = "us-east-1"
}

variable "name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of AZs to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"] # adjust per region
}

variable "app_name" {
  default = "django-app"
}

variable "instance_type" {
  description = "EC2 instance type for app servers"
  type        = string
  default     = "t3.micro"
}

variable "desired_capacity" {
  type        = number
  description = "Number of EC2 instances to start with in the ASG"
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Minimum number of EC2 instances in the ASG"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of EC2 instances in the ASG"
  default     = 4
}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2
}

variable "db_username" {
  default = "django"
  type        = string
}

variable "db_password" {
  description = "Set a secure password here"
  type        = string
}

variable "db_name" {
  default = "djangodb"
  type        = string
}

variable "s3_bucket_name" {
  default = "django-app-static-logs"
}
