# target group ARN not the ALB ARN to be used by ASG
output "aws_alb_target_group_arn" {
  value = aws_lb_target_group.tcp-example.arn
}
