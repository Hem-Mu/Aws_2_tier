#!/bin/bash

## Description
## id, pw 작성
## Amazon Linux2는 Time Sync Service가 기본적용임.

# Update Package Manager
sudo yum -y update
# hostname set
sudo hostnamectl set-hostname web

# 생성할 user의 id와 pw
id='hamster'
pw='q1q1q1q1' # 8char ↑

# User 생성
# User 없을 시 아래 if문을 실행하지 않음
if [ -n "$id" ] && [ -n "$pw" ]; then
  sudo useradd "$id"
  sudo bash -c "echo '$id:$pw' | chpasswd"
  sudo usermod -aG wheel "$id"
fi

# sudo 권한 부여
sudo chmod u+w /etc/sudoers
echo 'hamster ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo

# Timezone 변경
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# password 접속 허용
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo service sshd restart