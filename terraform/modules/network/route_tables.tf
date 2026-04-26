resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
    Type = "public"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route-table"
    Type = "private"
  }
}

resource "aws_route_table_association" "public" {
  for_each = {
    for k, s in aws_subnet.subnets :
    k => s if s.tags.Type == "public"
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  for_each = {
    for k, s in aws_subnet.subnets :
    k => s if s.tags.Type == "server" || s.tags.Type == "database"
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}