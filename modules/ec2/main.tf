data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "web_sg" {
  name_prefix = "${var.environment}-web-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y || sudo yum install nginx -y
              rm -f /usr/share/nginx/html/index.html
              rm -f /etc/nginx/conf.d/default.conf
              echo "Deployed via Terraform" > /usr/share/nginx/html/index.html
              mkdir -p /var/www/html
              echo "Deployed via Terraform" > /var/www/html/index.html
              chmod 644 /usr/share/nginx/html/index.html
              sudo systemctl enable nginx
              sudo systemctl restart nginx
  EOF

  user_data_replace_on_change = true

  tags = {
    Name = "${var.environment}-web-server"
  }
}
