resource "aws_key_pair" "keypair" { 
  key_name = "hamster" # 키페어의 이름
  public_key = file("./id_rsa.pub") # 키페어 public key 지정
}