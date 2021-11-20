# Terraform Output Values

# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.ubuntu-hosts.*.public_ip
}

# EC2 Instance Public DNS
output "instance_privateIp" {
  description = "EC2 Instance Private IP"
  value = aws_instance.ubuntu-hosts.*.private_ip
}
