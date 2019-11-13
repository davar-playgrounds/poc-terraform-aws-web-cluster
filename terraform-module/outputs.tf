output "loadbalancer_entry_point" {
  value = aws_lb.website_loadbalancer.dns_name
}

output "loadbalancer_name" {
  value = aws_lb.website_loadbalancer.name
}

output "test" {
  value = "value"
}