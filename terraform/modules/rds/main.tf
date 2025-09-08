# ------------------------
# Generate Secure Password
# ------------------------
resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()-_=+"
}


# ------------------------
# Subnet Group
# ------------------------
resource "aws_db_subnet_group" "main" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}

# ------------------------
# RDS Instance
# ------------------------
resource "aws_db_instance" "postgres" {
  identifier              = var.db_name
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.username
  password                = random_password.rds_password.result
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = var.sg_ids
  multi_az                = true
  skip_final_snapshot     = true
}
