resource "aws_launch_configuration" "website_launch_configuration" {
  image_id = var.deploy_image_website
  instance_type = var.deploy_image_website_instance_type
  security_groups = [aws_security_group.website_fw_lb.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_placement_group" "webiste_placement_group" {
  name = "website-placement"
  strategy = "spread"
}
resource "aws_autoscaling_group" "webinstance_scale_group" {
  name                      = "website-autoscaler-group-${var.environment}"
  max_size                  = var.maximum_number_of_instances
  min_size                  = var.minumum_number_of_instances
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.number_of_instances
  force_delete              = true
  placement_group           = aws_placement_group.webiste_placement_group.id
  launch_configuration      = aws_launch_configuration.website_launch_configuration.name
  target_group_arns         = [aws_lb_target_group.website_lb_targetgroup.arn]
  vpc_zone_identifier       = module.vpc.private_subnets
  timeouts {
    delete = "15m"
  }

  tag  {
    key = "env"
    value = var.environment
    propagate_at_launch  = true

  }
  tag {
    key                 = "release"
    value               = "1.0.0"
    propagate_at_launch = true
  }
}

