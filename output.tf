output "pub1a_instance_ip" {
  value = aws_instance.pub1a.public_ip
}

output "pub1b_instance_ip" {
  value = aws_instance.pub1b.public_ip
}

output "pub2a_instance_ip" {
  value = aws_instance.pub2a.public_ip
}

output "pub2b_instance_ip" {
  value = aws_instance.pub2b.public_ip
}

output "db_instance_ip" {
  value = aws_db_instance.db-vm.endpoint
}

output "elb_dns_name" {
  value = aws_lb.web_alb.dns_name
}