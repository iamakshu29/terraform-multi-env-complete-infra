asg = {
  test_asg = {
    app1 = {
      name = "test-asg"
    }

  }

  launch_template = {
    app1 = {
      name          = "test-launch-template"
      image_id      = "ami-0150ccaf51ab55a51"
      instance_type = "t2.micro"
      key_name      = "terraform"
      ebs_optimized = true
      description   = "Launch Template for Terraform/Opentofu project used by ASG"
      tags = {
        Name = "test-asg-template"
      }
    }
  }
}


