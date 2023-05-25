resource "aws_lb_target_group" "webtarget" {
  name     = "minwook-webTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
  
  health_check {
    enabled = true
    path    = "/helloWorld.html"
    protocol = "HTTP"
    matcher = "200"
  }

  tags = {
    Owner = "minwook.kim"
  }
}
output "webtarget_id" {
  value = aws_lb_target_group.webtarget.name
}
