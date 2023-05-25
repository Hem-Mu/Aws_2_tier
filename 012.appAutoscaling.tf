resource "aws_autoscaling_group" "appautoscaling" {
    name = "appAutoScalingGroup"
  launch_template {
    id      = aws_launch_template.appServer.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    data.terraform_remote_state.network.outputs.pri1_id,
    data.terraform_remote_state.network.outputs.pri2_id
  ]

  min_size          = 1
  max_size          = 4
  desired_capacity  = 1
  health_check_type = "EC2"
  health_check_grace_period = 300

  target_group_arns = [aws_lb_target_group.apptarget.arn]

  tag {
    key                 = "Name"
    value               = "minwook-appServer"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "app" {
  name                   = "APP Target Tracking Policy"
  autoscaling_group_name = aws_autoscaling_group.appautoscaling.id
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60 # scaleout CPU percent
  }
}
output "appautoscaling_id" {
  value = aws_autoscaling_group.appautoscaling.id
}