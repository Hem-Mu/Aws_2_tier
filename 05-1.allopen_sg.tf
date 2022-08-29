resource "aws_security_group" "web" {
  name        = "all_open"
  description = "Allow all inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "all_open"
  }
}

resource "aws_security_group_rule" "web_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all" # all, TCP, UDP
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web.id}"

  lifecycle { 
    create_before_destroy = true 
    } # 생성 후 삭제
} # all inbound
resource "aws_security_group_rule" "web_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web.id}"

  lifecycle { 
    create_before_destroy = true 
    } # 생성 후 삭제
} # all outbound
resource "aws_security_group_rule" "icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp" # all, TCP, UDP
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web.id}"

  lifecycle { 
    create_before_destroy = true 
    } # 생성 후 삭제
} # all inbound icmp

output "allopen_sg" {
    value = "${aws_security_group.web.id}"
  }