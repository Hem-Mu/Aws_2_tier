resource "aws_lb" "internalalb" {
  name               = "minwook-appInternalalb"
  internal           = true # internal
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  enable_deletion_protection = false
  #security_groups    = [aws_security_group.internetAlbSG.id]

  subnets = [
    data.terraform_remote_state.network.outputs.pri1_id,
    data.terraform_remote_state.network.outputs.pri2_id
  ]

  tags = {
    Owner = "minwook.kim"
  }
}

resource "aws_lb_listener" "backendalb_listener" {
  load_balancer_arn = aws_lb.internalalb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apptarget.arn
  }
}
output "internalalb_id" {
  value = aws_lb.internalalb.id
}