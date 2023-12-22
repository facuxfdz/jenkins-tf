data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "ssh_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow jenkins inbound traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.ubuntu_ami.id
  instance_type               = "t2.medium"
  security_groups             = [aws_security_group.ssh_sg.id]
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = aws_key_pair.instance_key_pair.key_name
  provisioner "file" {
    source      = "jenkins-install.sh"
    destination = "/tmp/jenkins-install.sh"
    connection {
      type    = "ssh"
      user    = "ubuntu"
      host    = self.public_ip
      timeout = "1m"
      agent   = true
    }
  }

  provisioner "file" {
    source      = "disable-login.groovy"
    destination = "/tmp/disable-login.groovy"

    connection {
      type    = "ssh"
      user    = "ubuntu"
      host    = self.public_ip
      timeout = "1m"
      agent   = true
    }
  }

  provisioner "file" {
    source      = "install-plugins.groovy"
    destination = "/tmp/install-plugins.groovy"

    connection {
      type    = "ssh"
      user    = "ubuntu"
      host    = self.public_ip
      timeout = "1m"
      agent   = true
    }
  }

  provisioner "remote-exec" {
    connection {
      type    = "ssh"
      user    = "ubuntu"
      host    = self.public_ip
      timeout = "1m"
      agent   = true
    }
    inline = [
      "sudo mkdir -p /var/lib/jenkins/init.groovy.d",
      "sudo mv /tmp/disable-login.groovy /var/lib/jenkins/init.groovy.d/disable-login.groovy",
      "sudo mv /tmp/install-plugins.groovy /var/lib/jenkins/init.groovy.d/install-plugins.groovy",
      "sudo chmod +x /tmp/jenkins-install.sh",
      "sudo /tmp/jenkins-install.sh ${var.jenkins_admin_credentials.username} ${var.jenkins_admin_credentials.password} ${var.jenkins_plugins}"
    ]
  }

  tags = {
    Name = "jenkins"
  }
}

resource "aws_key_pair" "instance_key_pair" {
  key_name   = "aws_key"
  public_key = file(var.public_key_path)
}
