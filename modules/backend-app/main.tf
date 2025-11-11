data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "backend" {
  count         = var.instance_count
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = var.private_subnet_ids[count.index % length(var.private_subnet_ids)]
  vpc_security_group_ids = [var.backend_sg_id]
  key_name               = var.key_name

  user_data = base64encode(templatefile("${path.module}/../../scripts/app-setup.sh", {
    internal_alb_dns = var.internal_alb_dns
  }))

  tags = {
    Name = "${var.project_name}-backend-${count.index + 1}"
  }

  provisioner "file" {
    source      = "${path.module}/../../app-files/"
    destination = "/home/ec2-user/"
    
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.private_ip
      bastion_host = var.bastion_host
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.private_ip
      bastion_host = var.bastion_host
    }
    
    inline = [
      "chmod +x /home/ec2-user/setup.sh",
      "cd /home/ec2-user && sudo ./setup.sh",
      "echo 'Backend application deployed successfully'"
    ]
  }
}

resource "aws_lb_target_group_attachment" "backend" {
  count            = var.instance_count
  target_group_arn = var.backend_target_group_arn
  target_id        = aws_instance.backend[count.index].id
  port             = 3000
}