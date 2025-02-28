output "Nexus-details" {
  value = [
    aws_instance.nexus.id, 
    aws_instance.nexus.public_ip
  ]
}