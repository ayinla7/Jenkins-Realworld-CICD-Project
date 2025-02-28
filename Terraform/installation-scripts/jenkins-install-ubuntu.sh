#!/bin/bash
# Update the system
sudo apt update -y
sudo apt upgrade -y

# Install Jenkins on Ubuntu
wget -q -O /etc/apt/trusted.gpg.d/jenkins.asc https://pkg.jenkins.io/debian/jenkins.io.key
echo "deb http://pkg.jenkins.io/debian-stable/ /" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install jenkins -y

# Start and enable Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Installing Git
sudo apt install git -y

# Installing Java OpenJDK 11
sudo apt install openjdk-11-jdk -y

# Installing Ansible and dependencies
sudo apt install ansible -y
sudo apt install python3-pip -y
pip3 install boto3

# Provisioning Ansible Deployer Access
sudo useradd ansibleadmin
echo ansibleadmin | sudo passwd --stdin ansibleadmin
sudo sed -i "s/.*#host_key_checking = False/host_key_checking = False/g" /etc/ansible/ansible.cfg
sudo sed -i "s/.*#enable_plugins = host_list, virtualbox, yaml, constructed/enable_plugins = aws_ec2/g" /etc/ansible/ansible.cfg
ansible-galaxy collection install amazon.aws

# Enable Password Authentication and Grant Sudo Privilege
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# Apache Maven Installation/Config
sudo apt install maven -y

# You can set Java version alternatives if needed
# sudo update-alternatives --config java
# sudo update-alternatives --config javac

# Notes for Jenkins VM/EC2 Instance
# Instance Type: t2.medium or small minimum
# Open Port (Security Group): 8080 
