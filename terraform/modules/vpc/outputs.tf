output "vpc_id" { value = aws_vpc.main.id }
output "public_subnets" { value = aws_subnet.public[*].id }
output "private_subnets" { value = aws_subnet.private[*].id }
output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
output "elb_sg_id" {
  description = "Security group ID for ELB"
  value       = aws_security_group.elb_sg.id
}

output "ec2_sg_id" {
  description = "Security group ID for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}
