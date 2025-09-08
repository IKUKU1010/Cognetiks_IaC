variable "name" {
  description = "Name prefix for ELB"
  type        = string
}

variable "subnets" {
  description = "Public subnets to place the ELB"
  type        = list(string)
}

variable "elb_sg_id" {
  description = "Security group for the ELB"
  type        = string
}

variable "target_sg_id" {
  description = "Security group of EC2 instances behind the ELB"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ELB is created"
  type        = string
}
