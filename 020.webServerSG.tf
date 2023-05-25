resource "aws_security_group" "webServerSG" {
  name        = "webServerSG"
  description = "webServerSG"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "bastion to webServer"
    from_port        = var.sshport
    to_port          = var.sshport
    protocol         = "tcp"
    security_groups = [aws_security_group.bastinSG.id] #source SG
  }
  ingress {
    description      = "alb to webServer"
    from_port        = var.httpport
    to_port          = var.httpport
    protocol         = "tcp"
    security_groups = [aws_security_group.internetAlbSG.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minwook.kim-webServerSG"
    Owner = "minwook.kim"
  }
  lifecycle {
    create_before_destroy = true
  }
}
output "webServerSG_id" {
    value = aws_security_group.webServerSG.id
  }