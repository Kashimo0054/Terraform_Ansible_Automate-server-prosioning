provider "aws" {
  region = "ap-south-1"
}

# 1. Automated Security Group
resource "aws_security_group" "ansible_sg" {
  name        = "ansible_access_sg"
  description = "Security group for Ansible and Web traffic"

  # Allow SSH for Ansible
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Allow all outbound traffic (so servers can download packages)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Web Server Resource
resource "aws_instance" "web_server" {
  ami                    = "ami-05d2d839d4f73aafb"
  instance_type          = "t3.medium"
  key_name               = "Pipelinekeypair"
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Ansible-Web"
    Role = "web"
  }
}

# 3. Build Server Resource
resource "aws_instance" "build_server" {
  ami                    = "ami-05d2d839d4f73aafb"
  instance_type          = "t3.medium"
  key_name               = "Pipelinekeypair"
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Ansible-Build"
    Role = "build"
  }
}


# 4. DB Server Resource
resource "aws_instance" "db_server" {
  ami                    = "ami-05d2d839d4f73aafb"
  instance_type          = "t3.medium"
  key_name               = "Pipelinekeypair"
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Ansible-db"
    Role = "db"
  }
}
