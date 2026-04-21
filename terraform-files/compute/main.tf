provider "aws" {
  region = "ap-south-1"
}

variable "environment" {}

# 🔗 Remote state (core)
data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket = "prashant-terraform-state-bucket-12345"
    key    = "core/terraform.tfstate"
    region = "ap-south-1"
  }
}

# -----------------------------
# SECURITY GROUPS
# -----------------------------
resource "aws_security_group" "frontend_sg" {
  name   = "frontend-sg-${var.environment}"
  vpc_id = data.terraform_remote_state.core.outputs.vpc_id

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
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_sg" {
  name   = "backend-sg-${var.environment}"
  vpc_id = data.terraform_remote_state.core.outputs.vpc_id

  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# FRONTEND EC2
# -----------------------------
resource "aws_instance" "frontend" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = var.environment == "dev" ? "t3.micro" : "c7i-flex.large"

  subnet_id = data.terraform_remote_state.core.outputs.public_subnet_id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  key_name = "flask"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              chmod 666 /var/run/docker.sock
              EOF

  tags = {
    Name = "frontend-${var.environment}"
  }
}

# -----------------------------
# BACKEND EC2
# -----------------------------
resource "aws_instance" "backend" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = var.environment == "dev" ? "t3.micro" : "c7i-flex.large"

  subnet_id = data.terraform_remote_state.core.outputs.private_subnet_id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  key_name = "flask"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              chmod 666 /var/run/docker.sock
              EOF

  tags = {
    Name = "backend-${var.environment}"
  }
}