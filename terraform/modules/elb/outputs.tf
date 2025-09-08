output "name" {
  description = "ELB name to attach to ASG"
  value       = aws_elb.this.name
}

output "dns_name" {
  description = "DNS name of the ELB"
  value       = aws_elb.this.dns_name
}
