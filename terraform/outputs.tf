output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.db_endpoint
}

output "rds_password" {
  description = "RDS master password"
  value       = module.rds.db_password
  sensitive   = true
}

output "elb_dns_name" {
  description = "DNS name of the classic ELB"
  value       = module.elb.dns_name
}

output "ec2_iam_profile" {
  value = module.ec2.ec2_iam_profile
}