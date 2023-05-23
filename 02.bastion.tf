resource "aws_instance" "bastion" {
  count = 2
  ami           = "ami-035da6a0773842f64" # amazon linux2
  instance_type = "t3.micro"
  subnet_id   =  data.terraform_remote_state.network.outputs.pub1_id
  key_name = data.terraform_remote_state.network.outputs.keypair
  vpc_security_group_ids = [aws_security_group.bastinSG.id] # 보안그룹
  
  tags = {
    Name = "minwook.kim-bastion-${count.index+1}"
    Owner = "minwook.kim"
  }
}
resource "aws_eip" "BastionIP" {
  count = 2
  instance = aws_instance.bastion[count.index].id
  vpc      = true
}








resource "aws_security_group" "bastinSG" {
  name        = "bastinSG"
  description = "bastinSG"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "SSH from VPC"
    from_port        = var.sshport
    to_port          = var.sshport
    protocol         = "tcp"
    cidr_blocks      = [var.btcIP]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 8080
    to_port          = 8080
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
    Name = "minwook.kim-bastinSG"
    Owner = "minwook.kim"
    codedeploy = "app"
  }
}