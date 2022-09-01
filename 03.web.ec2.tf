resource "aws_instance" "web" {
  count = 10
  
  ami           = "ami-009b4df3c15b5fc2c" # centos 7
  instance_type = "t2.micro"
  subnet_id   =  data.terraform_remote_state.network.outputs.pri_all[(count.index % 2 == 0) ? 0 : 1] # pub 1,2
  # availability_zone = "${var.zone != "" ? var.zone: var.zones[ count.index % length(var.zones) ]}"
  key_name = data.terraform_remote_state.network.outputs.keypair
  
  vpc_security_group_ids = [aws_security_group.web.id] # 보안그룹

  tags = {
    Name = "web${count.index+1}"
  }

  user_data = "${file("./no_keypair.sh")}"
}


# subnet_id              = module.app_vpc.public_subnets[count.index % length(module.app_vpc.public_subnets)]  #모듈려 연산자 활용
