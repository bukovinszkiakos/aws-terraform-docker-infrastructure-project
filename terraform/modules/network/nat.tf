resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id

  subnet_id = values({
    for k, s in aws_subnet.subnets :
    k => s if s.map_public_ip_on_launch
  })[0].id

  tags = {
    Name = "${var.name_prefix}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}