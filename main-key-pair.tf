resource "aws_key_pair" "deployer" {
  key_name   = "ubuntu_ssh_key"
  public_key = file(var.path_to_public_key)
}