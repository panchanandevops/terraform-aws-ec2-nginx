variable "env" {
  description = "Environment for this project"
  type        = string
}

variable "path_to_public_key" {
  description = "Give the path to you public ssh key"
  type        = string
}

variable "instance_settings" {
  description = "ami value for our ubuntu instance"

  type = map(object({
    instance_ami  = string
    instance_type = string
    subnet_name   = string
    public_ip     = bool
  }))
}

variable "public_subnet_ids" {
  description = "map of public subnet ids"
  type = map(string)
}

variable "security_group_id" {
  description = "List of security group ids"
  type = list(string)
}