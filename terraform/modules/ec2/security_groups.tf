resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP/HTTPS traffic from internet"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.alb_ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow traffic only from ALB"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ec2_ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"

      security_groups = [aws_security_group.alb_sg.id]
    }
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}