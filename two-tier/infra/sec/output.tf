#share the output for other modules
output "sg_web" {
  value = "${aws_security_group.my-webserver.id}"
}
output "sg_db" {
  value = "${aws_security_group.my-database.id}"
}
output "sg_elb" {
  value = "${aws_security_group.my-loadbalancer.id}"
}
