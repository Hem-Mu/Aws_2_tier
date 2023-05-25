resource "aws_security_group" "appServerSG" {
  name        = "appServerSG"
  description = "appServerSG"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "bastion to appServer"
    from_port        = var.sshport
    to_port          = var.sshport
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastinSG.id] #source SG
  }

  ingress {
    description      = "tomcat"
    from_port        = var.tomcatport
    to_port          = var.tomcatport
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #source SG
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minwook.kim-appServerSG"
    Owner = "minwook.kim"
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "appServerSG_id" {
  value = aws_security_group.appServerSG.id
}
