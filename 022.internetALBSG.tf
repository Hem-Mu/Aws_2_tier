resource "aws_security_group" "internetAlbSG" {
  name        = "internetAlbSG"
  description = "80 open"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "http to webServer"
    from_port        = var.httpport
    to_port          = var.httpport
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minwook.kim-internetAlbSG"
    Owner = "minwook.kim"
  }
  lifecycle {
    create_before_destroy = true
  }
}
output "internetAlbSG" {
    value = "${aws_security_group.internetAlbSG.id}"
  }