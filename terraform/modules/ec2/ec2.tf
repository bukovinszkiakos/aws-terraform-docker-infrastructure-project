data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  count = var.instance_count

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = var.subnet_ids[count.index]

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile   = var.instance_profile_name

  key_name = var.key_name

  associate_public_ip_address = false

  user_data = templatefile("${path.root}/config/user_data.sh", {
    ecr_repo_url = var.ecr_repo_url
  })

  tags = {
    Name = "whale-server-${count.index + 1}"
    Role = "app"
  }
}