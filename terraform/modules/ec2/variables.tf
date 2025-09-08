
variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnets" {
  description = "Subnets for the Auto Scaling Group"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired capacity for ASG"
  type        = number
}

variable "max_size" {
  description = "Max size of ASG"
  type        = number
}

variable "min_size" {
  description = "Min size of ASG"
  type        = number
}

variable "ec2_sg_id" {
  description = "EC2 security group ID"
  type        = string
}

variable "elb_name" {
  description = "Classic ELB name to attach to ASG"
  type        = string
}

# -----------------------------
# New variables for userdata.sh
# -----------------------------
variable "db_endpoint" {
  description = "RDS endpoint for Django database connection"
  type        = string
}

variable "db_password" {
  description = "RDS master password for Django database connection"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "S3 bucket name for Django app media/static files"
  type        = string
}
