#Add jenkins EC2
resource "aws_instance" "jenkins" {
  ami           = var.ami-Amazon-Linux-2 # Change this to the correct Amazon Linux 2 AMI ID for your region
  instance_type = var.t2-medium
  key_name      = var.key-pair-jenkins # Replace with your actual key pair name

  security_groups = [aws_security_group.jenkins_sg.name]

  iam_instance_profile = "AWS-EC2FullAccess-Role"
  user_data = file("./installation-scripts/jenkins-install.sh")

  tags = {
    Name = "Jenkins"
  }
}

#Add sonarQube EC2
resource "aws_instance" "sonarQube" {
  ami           = var.ami-ubuntu-22 # Change this to the correct Amazon Linux 2 AMI ID for your region
  instance_type = var.t2-medium
  key_name      = var.key-pair-jenkins # Replace with your actual key pair name

  security_groups = [aws_security_group.sonarqube_sg.name]

  user_data = file("./installation-scripts/sonarQube-install.sh")

  tags = {
    Name = "sonarQube"
  }
}

#Add nexus EC2
resource "aws_instance" "nexus" {
  ami           = var.ami-Amazon-Linux-2 # Change this to the correct Amazon Linux 2 AMI ID for your region
  instance_type = var.t2-medium
  key_name      = var.key-pair-jenkins # Replace with your actual key pair name

  security_groups = [aws_security_group.nexus_sg.name]

  user_data = file("./installation-scripts/nexus-install.sh")

  tags = {
    Name = "Nexus"
  }
}

#Add 2 environments - Dev,Stage,Prod
resource "aws_instance" "env" {
  count                  = 3
  ami                    = var.ami-Amazon-Linux-2
  instance_type          = var.t2-micro
  key_name               = var.key-pair-jenkins
  security_groups         = [aws_security_group.env_sg.name]
  tags = {
    Name        = element(["dev", "stage", "prod"], count.index)
    Environment = element(["dev", "stage", "prod"], count.index)
  }

  user_data = file("./installation-scripts/tomcat-ssh-configure.sh")
}

#Add Prometheus EC2
resource "aws_instance" "prometheus" {
  ami           = var.ami-ubuntu-22 # Change this to the correct Amazon Linux 2 AMI ID for your region
  instance_type = var.t2-micro
  key_name      = var.key-pair-jenkins # Replace with your actual key pair name

  security_groups = [aws_security_group.prometheus_sg.name]
  iam_instance_profile = "AWS-EC2FullAccess-Role"

  tags = {
    Name = "prometheus"
  }
}

#Add grafana EC2
resource "aws_instance" "grafana" {
  ami           = var.ami-ubuntu-22 # Change this to the correct Amazon Linux 2 AMI ID for your region
  instance_type = var.t2-micro
  key_name      = var.key-pair-jenkins # Replace with your actual key pair name

  security_groups = [aws_security_group.grafana_sg.name]

  tags = {
    Name = "grafana"
  }
}

#Add splunk EC2
resource "aws_instance" "splunk" {
  ami           = var.ami-Amazon-Linux-2 # Change this to the correct Amazon Linux 2 AMI ID for your region
  instance_type = var.t2-large
  key_name      = var.key-pair-jenkins # Replace with your actual key pair name

  security_groups = [aws_security_group.splunk_sg.name]

  tags = {
    Name = "splunk"
  }
}

