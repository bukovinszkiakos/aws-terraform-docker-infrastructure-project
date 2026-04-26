output "public_subnets" {
  value = [
    for s in aws_subnet.subnets :
    s.id if s.map_public_ip_on_launch
  ]
}

output "server_subnets" {
  value = [
    for k, s in aws_subnet.subnets :
    s.id if s.tags.Type == "server"
  ]
}


output "vpc_id" {
  value = aws_vpc.main.id
}

