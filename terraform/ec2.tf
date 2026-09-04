resource "aws_instance" "api" {
  ami           = "ami-0619724297c6fa28d"
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids     = [aws_security_group.api.id]
  associate_public_ip_address = true
  key_name                    = "chave-projeto"

iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
              #!/bin/bash
              curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs git
              EOF

  tags = {
    Name = "${var.project_name}-ec2"
  }
}

