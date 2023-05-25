resource "aws_security_group" "internalAlbSG" {
  name        = "internalAlbSG"
  description = "8080 open"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "tomcat to appServer"
    from_port        = var.tomcatport
    to_port          = var.tomcatport
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
    Name = "minwook.kim-internalAlbSG"
    Owner = "minwook.kim"
  }
  lifecycle {
    create_before_destroy = true
  }
}
output "internalAlbSG_id" {
    value = "${aws_security_group.internetAlbSG.id}"
  }