resource "aws_instance" "bastion" {
  ami           = "ami-009b4df3c15b5fc2c" # centos 7
  instance_type = "t2.micro"
  subnet_id   =  data.terraform_remote_state.network.outputs.pub1_id
  key_name = data.terraform_remote_state.network.outputs.keypair
  vpc_security_group_ids = [aws_security_group.web.id] # 보안그룹
  
  tags = {
    Name = "bastion"
  }
}
resource "aws_eip" "bastionIP" {
  instance = aws_instance.bastion.id
  vpc      = true
}