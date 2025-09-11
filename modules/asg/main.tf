# Auto Scaling Group resource
resource "aws_autoscaling_group" "bar" {
  for_each = var.asg.test_asg

  name     = each.value.name
  max_size = 4
  min_size = 2

  #   Time (in seconds) after instance comes into service before checking health
  health_check_grace_period = 300

  health_check_type = "EC2"
  desired_capacity  = 3

  # List of ALB/NLB names to add to the autoscaling group names.
  target_group_arns =  var.aws_alb_arn

  vpc_zone_identifier  = var.subnets

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  launch_template {
    id      = aws_launch_template.test_template[each.key].id
    version = "$Latest"
  }

  #  terraform feature...it will wait upto 15 min for AWS to finish deleteing the ASG, after that it gives timeout error
  # terraform already have default timeouts, but with this we can override it accordingly.
  timeouts {
    delete = "15m"
  }

  # These types of tags are ONLY FOR ASG resource
  # When you define a tag {} block inside an aws_autoscaling_group, 
  # you can control whether the tag is applied only to the ASG itself or also to EC2 instances launched by the ASG.
  # true -> tag will be copied onto each EC2 instances created by ASG.
  # false -> tag will be applied only to the ASG resource, not the EC2 instance it launches.

  tag {
    key                 = "test-asg"
    value               = "EC2"
    propagate_at_launch = true
  }
}

# Launch Template
resource "aws_launch_template" "test_template" {
  for_each = var.asg.launch_template
  name                   = each.value.name
  image_id               = each.value.image_id
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  ebs_optimized          = try(each.value.ebs_optimized,false)
  vpc_security_group_ids = var.vpc_id
  description            = each.value.description

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size           = 12
      delete_on_termination = true
    }
  }

  # to protect from accidental stop/terminate
  #   disable_api_stop        = true
  #   disable_api_termination = true

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = each.value.tags
  }

  # user_data = filebase64("${path.module}/example.sh")
}


