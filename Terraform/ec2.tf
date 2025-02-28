resource "aws_instance" "nexus" {
  ami           = var.ami-Amazon-Linux-2 # Change this to the correct Amazon Linux 2 AMI ID for your region
  instance_type = "t2.medium"
  key_name      = "jenkins" # Replace with your actual key pair name

  security_groups = [aws_security_group.nexus_sg.name]

  tags = {
    Name = "Nexus"
  }
}