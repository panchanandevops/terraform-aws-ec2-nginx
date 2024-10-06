output "ubuntu_instance_public_ip" {
  value = { for key, ip in aws_instance.ubuntu_instance : key => ip.public_ip }
}