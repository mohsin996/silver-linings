output "mywebserver1" {
  value = "${aws_instance.my-webserver1.id}"
}
output "mywebserver2" {
  value = "${aws_instance.my-webserver2.id}"
}
