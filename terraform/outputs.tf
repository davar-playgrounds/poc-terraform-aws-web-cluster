output "loadbalancer_entry_point" {
  value = aws_lb.website_loadbalancer.dns_name
}