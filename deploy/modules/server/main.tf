resource "aws_security_group" "server_sg" {
  name        = "${var.owner}-webserver"
  description = "Allow HTTPS out to download required packages"

  egress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_instance" "server" {
  ami           = local.instance_ami
  instance_type = local.instance_type

  iam_instance_profile = aws_iam_instance_profile.server_profile.name

  tags = {
    Name = "${var.owner}-log-generating-server"
  }

  security_groups = [
    aws_security_group.server_sg.name
  ]

  user_data = data.template_file.user_data.rendered

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
