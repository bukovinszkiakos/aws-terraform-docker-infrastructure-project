resource "aws_ecr_repository" "app_repo" {
  name = "whale-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.name_prefix}-app"
  }
}