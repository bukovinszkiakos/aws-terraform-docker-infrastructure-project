
resource "aws_lb" "whale_alb" {
  name               = "${var.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]
  subnets         = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-alb"
  }
}

resource "aws_lb_target_group" "whale_tg" {
  name     = "${var.name_prefix}-tg"
  port     = var.listener_port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check.path
    port                = "traffic-port"
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.name_prefix}-tg"
  }
}

resource "aws_lb_target_group_attachment" "servers" {
  for_each = toset(var.instance_ids)

  target_group_arn = aws_lb_target_group.whale_tg.arn
  target_id        = each.value
  port             = var.listener_port
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.whale_alb.arn
  port              = var.listener_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.whale_tg.arn
  }
}