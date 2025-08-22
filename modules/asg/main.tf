# Auto Scaling Group resource
resource "aws_autoscaling_group" "bar" {
  name     = "foobar3-terraform-test"
  max_size = 4
  min_size = 2

  #   Time (in seconds) after instance comes into service before checking health
  health_check_grace_period = 300

  health_check_type = "EC2"
  desired_capacity  = 3

  # List of ALB/NLB names to add to the autoscaling group names.
  target_group_arns = [aws_lb.test.arn]

  launch_configuration = aws_launch_configuration.foobar.name
  vpc_zone_identifier  = [aws_subnet.main.id]

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  launch_template {
    id      = aws_launch_template.foo.id
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
    key                 = "foo"
    value               = "bar"
    propagate_at_launch = true
  }

  tag {
    key                 = "lorem"
    value               = "ipsum"
    propagate_at_launch = false
  }
}

# Launch Template
resource "aws_launch_template" "foo" {
  name                   = "foo"
  image_id               = "ami-0150ccaf51ab55a51"
  instance_type          = "t2.micro"
  key_name               = "terraform"
  ebs_optimized          = true
  vpc_security_group_ids = [aws_security_group.main]
  description            = "Launch Template for Terraform/Opentofu project used by ASG"

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

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}


