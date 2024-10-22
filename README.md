

# Terraform AWS EC2-Nginx Module

This Terraform module provisions an Ubuntu EC2 instance running NGINX on AWS. It includes creating an EC2 instance, a security group, a key pair for SSH access, and running a user-data script to install and configure NGINX with a custom welcome page.

## Features
- Provision Ubuntu EC2 instances with public IP.
- Set up an NGINX web server on the EC2 instance.
- Automatically install NGINX using a startup script.
- SSH access via a specified key pair.

## Resources Created
- **EC2 Instance**: Ubuntu instance with a public IP, configured to run NGINX.
- **Security Group**: Allow SSH, HTTP, and HTTPS traffic.
- **Key Pair**: Used for SSH access.

## Usage Example

```hcl
module "nginx_ec2" {
  source = "./terraform-aws-ec2-nginx"

  env               = "dev"
  path_to_public_key = "~/.ssh/id_rsa.pub"

  instance_settings = {
    ubuntu_instance = {
      instance_ami  = "ami-0c55b159cbfafe1f0" # Replace with your region's Ubuntu AMI
      instance_type = "t2.micro"
      subnet_name   = "public_subnet_1"
      public_ip     = true
    }
  }

  public_subnet_ids = {
    public_subnet_1 = "subnet-1234567890abcdef"
  }

  security_group_id = ["sg-0a1b2c3d4e5f67890"]
}
```

## Variables

| Name                  | Type           | Description                                | Default |
|-----------------------|----------------|--------------------------------------------|---------|
| `env`                 | `string`       | Environment for this project               |         |
| `path_to_public_key`   | `string`       | Path to the public SSH key                 |         |
| `instance_settings`    | `map(object)`  | AMI, instance type, subnet, and public IP  |         |
| `public_subnet_ids`    | `map(string)`  | Map of public subnet IDs                   |         |
| `security_group_id`    | `list(string)` | List of security group IDs                 |         |

### `instance_settings` Structure

| Field          | Type    | Description                |
|----------------|---------|----------------------------|
| `instance_ami` | `string`| The AMI ID for the instance |
| `instance_type`| `string`| Instance type (e.g., `t2.micro`)|
| `subnet_name`  | `string`| Name of the subnet to use   |
| `public_ip`    | `bool`  | Whether to assign a public IP|

## Outputs

| Name                       | Description                         |
|----------------------------|-------------------------------------|
| `ubuntu_instance_public_ip` | The public IP of the Ubuntu instance|

## Prerequisites
1. Terraform 1.0 or newer.
2. AWS credentials configured.
3. A public SSH key for access to the EC2 instance.

## Deployment
1. Initialize the Terraform working directory:

   ```bash
   terraform init
   ```

2. Apply the configuration:

   ```bash
   terraform apply
   ```

3. Confirm to create the resources. Terraform will output the public IP of the EC2 instance after creation.

4. Access the NGINX web server in a browser using the public IP.

   ```
   http://<EC2-Public-IP>
   ```

## NGINX Configuration
The `nginx-script.sh` script installs NGINX and creates a simple index page:

```bash
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
echo "<h1>Hello From Ubuntu EC2 Instance!!!</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart nginx
```
