output "address" {
  value = "${aws_elb.my-loadbalancer.dns_name}"
}
