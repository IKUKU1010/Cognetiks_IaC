# -----------------------------
# IAM Role + Policy for EC2
# -----------------------------
resource "aws_iam_role" "ec2_role" {
  name = "${var.name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "${var.name}-ec2-policy"
  description = "Policy for EC2 instances to access S3, RDS, CloudWatch, ELB, etc."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject", "s3:PutObject", "s3:ListBucket",
          "rds:DescribeDBInstances",
          "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents",
          "cloudwatch:PutMetricData",
          "elasticloadbalancing:RegisterTargets", "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:Describe*",
          "ec2:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# -----------------------------
# Launch Template
# -----------------------------
resource "aws_launch_template" "django" {
  name          = "${var.name}-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(templatefile("${path.module}/userdata.sh.tpl", {
    db_endpoint    = var.db_endpoint
    db_password    = var.db_password
    s3_bucket_name = var.s3_bucket_name
  }))
}

# -----------------------------
# Auto Scaling Group
# -----------------------------
resource "aws_autoscaling_group" "asg" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets

  launch_template {
    id      = aws_launch_template.django.id
    version = "$Latest"
  }

  # Attach Classic ELB
  load_balancers = [var.elb_name]

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}

# -----------------------------
# Outputs
# -----------------------------
output "ec2_iam_profile" {
  value = aws_iam_instance_profile.ec2_profile.name
}
