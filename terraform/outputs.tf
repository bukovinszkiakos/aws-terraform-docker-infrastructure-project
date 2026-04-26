output "alb_dns" {
  description = "Public URL of the Load Balancer"
  value       = aws_lb.whale_alb.dns_name
}