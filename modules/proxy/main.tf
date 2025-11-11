data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "proxy" {
  count         = var.instance_count
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_ids[count.index % length(var.public_subnet_ids)]
  vpc_security_group_ids = [var.proxy_sg_id]
  key_name               = var.key_name

  user_data = base64encode(file("${path.module}/../../scripts/nginx-setup.sh"))

  tags = {
    Name = "${var.project_name}-proxy-${count.index + 1}"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:\\Users\\sedie\\Desktop\\labsuser.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "echo 'Proxy setup completed'"
    ]
  }
}

resource "aws_lb_target_group_attachment" "proxy" {
  count            = var.instance_count
  target_group_arn = var.proxy_target_group_arn
  target_id        = aws_instance.proxy[count.index].id
  port             = 80
}