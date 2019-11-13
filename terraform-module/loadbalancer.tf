resource "aws_security_group" "website_fw_lb" {
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  vpc_id = module.vpc.vpc_id
}

resource "aws_lb" "website_loadbalancer" {
  name               = "lb-website-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    aws_security_group.website_fw_lb.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Terraform = "true"
    Purpose = "PoS"
    State = "Experimental"
    Owner = "Philip Rodrigues"
    Owner_team = "CloudOps"
    Expire_by = "20191231"
    Environment = var.environment
    Version = var.release_version
  }
}

resource "aws_lb_target_group" "website_lb_targetgroup" {
  name     = "nginx-port"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  deregistration_delay = "300"
//  health_check {
//    interval = "300"
//    port = "80"
//    protocol = "HTTP"
//    timeout = "10"
//    healthy_threshold = "10"
//    unhealthy_threshold= "10"
//  }
}

resource "aws_lb_listener" "nginx_forward_config" {
  load_balancer_arn = aws_lb.website_loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.website_lb_targetgroup.arn
    type             = "forward"
  }
}