output "public_ip_address" {
  value = aws_eip.web.public_ip
  description = "The public IP address of the VM"
}

output "ip_address" {
  value = aws_network_interface.nic1.private_ips
  description = "The private IP address of the VM"
}

output "user" {
  value = "centos"
  description = "The name of the user for the VM"
}