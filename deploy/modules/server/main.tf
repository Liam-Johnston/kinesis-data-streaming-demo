data "aws_key_pair" "development_keys" {
  key_name = "${var.ssh_key_name}"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "server_sg" {
  name        = "${var.owner}-webserver"
  description = "Allow ssh into webserver"

  egress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.ip_address}/32"]
  }
}

resource "aws_instance" "server" {
  ami                   = local.instance_ami
  instance_type         = local.instance_type

  iam_instance_profile  = aws_iam_instance_profile.server_profile.name
  key_name              = data.aws_key_pair.development_keys.key_name

  tags = {
    Name = "${var.owner}-log-generating-server"
  }

  security_groups = [
    aws_security_group.server_sg.name
  ]

  user_data = data.template_file.user_data.rendered
}
