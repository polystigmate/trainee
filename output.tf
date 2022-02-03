output "ubuntu1" {
    value = aws_instance.ubuntu-1-instance.public_ip
}

output "ubuntu2" {
    value = aws_instance.ubuntu-2-instance.public_ip
}

output "loadbalance" {
    value = aws_elb.polygon-elb.dns_name
}