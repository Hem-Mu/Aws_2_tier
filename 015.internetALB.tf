resource "aws_lb" "frontalb" {
  name               = "minwook-webAlb"
  internal           = false # internet facing
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  enable_deletion_protection = false
  security_groups    = [aws_security_group.internetAlbSG.id]
  
  subnets = [
    data.terraform_remote_state.network.outputs.pub1_id,
    data.terraform_remote_state.network.outputs.pub2_id
  ]

  tags = {
    Owner = "minwook.kim"
  }
}

resource "aws_lb_listener" "frontalb_listener" {
  load_balancer_arn = aws_lb.frontalb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webtarget.arn
  }
}
output "frontalb_id" {
  value = aws_lb.frontalb.id
}
