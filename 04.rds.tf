# resource "aws_db_subnet_group" "rdsSubnet" {
#   name = "rds_subnet"
#   subnet_ids = [
#     data.terraform_remote_state.network.outputs.pri1_id, # pri sub 1
#     data.terraform_remote_state.network.outputs.pri2_id  # pri sub 2
#   ]
#   description = "Rds_Subnet"
# }

# resource "aws_db_instance" "default" {
#   allocated_storage    = 20
#   engine               = "mysql"
#   engine_version       = "8.0.28"
#   db_subnet_group_name = aws_db_subnet_group.rdsSubnet.name
#   availability_zone    = var.zone # ap-northeast-2a
#   instance_class       = "db.t3.small"

#   identifier           = "mysql" # rds name
#   username             = var.rdsID # rds account name
#   password             = var.rdsPW # 8 char more

#   #vpc_security_group_ids = ""
#   parameter_group_name = "default.mysql8.0"
#   skip_final_snapshot  = true
#   port                 = "3306"
# }

# resource "aws_db_parameter_group" "pg" {
#   name   = "mysql-korean-pg" # 이름
#   family = "mysql8.0" # 적용 할 default parameter group 종류

#   parameter {
#     name  = "character_set_server"
#     value = "utf8"
#   }

#   parameter {
#     name  = "character_set_client"
#     value = "utf8"
#   }
# } # 한글지원