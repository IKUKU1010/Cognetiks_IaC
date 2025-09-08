# -----------------------------
# Classic Elastic Load Balancer
# -----------------------------
resource "aws_elb" "this" {
  name            = "${var.name}-elb"
  subnets         = var.subnets
  security_groups = [var.elb_sg_id]

  listener {
    instance_port     = 8000
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:8000/"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }

  tags = {
    Name = "${var.name}-elb"
  }
}
