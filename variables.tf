variable "region" { 
  description = "AWS region"
  type = string
  default = "ca-central-1" 
}

variable "environment" { 
  description = "Environment name (choose dev or prod)"
  type = string
}

variable "instance_type" {
  description = "EC2 instance type (choose t2.micro or t3.medium)"
  type = string
}

variable "key_name" { 
  description = "SSH key name"
  type = string
}

variable "allowed_ssh_cidr" {
  type = list(string)
}

