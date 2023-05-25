resource "aws_launch_template" "webServer" {
  name = "webServer-template"
  image_id = "ami-035da6a0773842f64" # amazon linux 2
  instance_type = "t3.small"
  update_default_version = true # always LATEST version

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
    }
  }

  network_interfaces {
    device_index = 0
    subnet_id = data.terraform_remote_state.network.outputs.pri1_id
    security_groups = [aws_security_group.webServerSG.id]
    associate_public_ip_address = false
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.CodeDeployinstance_profile.name # Codedeploy trust IAM
  }

  key_name = data.terraform_remote_state.network.outputs.keypair

  user_data = base64encode(file("./codedeployAgentInstall.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "minwook.kim-webServer"
      Owner = "minwook.kim"
      codedeploy = "web"
    }
  }
}

resource "aws_launch_template" "appServer" {
  name = "appServer-template"
  image_id = "ami-035da6a0773842f64" # amazon linux 2
  instance_type = "t3.small"
  update_default_version = true # always LATEST version

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
    }
  }

  network_interfaces {
    device_index = 0
    subnet_id = data.terraform_remote_state.network.outputs.pri1_id
    security_groups = [aws_security_group.appServerSG.id]
    associate_public_ip_address = false
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.CodeDeployinstance_profile.name # Codedeploy trust IAM
  }

  key_name = data.terraform_remote_state.network.outputs.keypair

  user_data = base64encode(file("./codedeployAgentInstall.sh"))


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "minwook.kim-appServer"
      Owner = "minwook.kim"
      codedeploy = "app"
    }
  }
}