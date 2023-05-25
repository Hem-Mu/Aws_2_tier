resource "aws_lb_target_group" "apptarget" {
  name     = "minwook-appTargetGroup"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id

  health_check {
    enabled = true
    path    = "/hello"
    protocol = "HTTP"
    matcher = "200"
  }
  
  tags = {
    Owner = "minwook.kim"
  }
}
output "apptarget_id" {
  value = aws_lb_target_group.apptarget.name
}
