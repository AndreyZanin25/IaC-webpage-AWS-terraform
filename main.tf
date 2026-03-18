provider "aws" {      
  region = var.region 
}

module "web_ec2" {
  source = "./modules/ec2" 
  environment      = var.environment 
  instance_type    = var.instance_type
  key_name         = var.key_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

