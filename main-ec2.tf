# Create Ubuntu EC2 Instance
resource "aws_instance" "ubuntu_instance" {
  for_each = {
    for key, setting in var.instance_settings : key => setting
    if setting.public_ip == true
  }

  ami                         = each.value.instance_ami
  instance_type               = each.value.instance_type
  associate_public_ip_address = true

  subnet_id              = var.public_subnet_ids[each.value.subnet_name]
  vpc_security_group_ids = var.security_group_id
  key_name               = aws_key_pair.deployer.key_name

  user_data = file("${path.module}/scripts/nginx-script.sh")

  tags = {
    Name = "${var.env}-ubuntu-instance"
  }
}