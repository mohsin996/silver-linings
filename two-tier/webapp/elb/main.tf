#Creating a ELB
resource "aws_elb" "my-loadbalancer" {
  name = "my-loadbalancer"
  security_groups = ["${var.sg_elb}"]
  subnets = ["${var.sn_web1}", "${var.sn_web2}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:80"
    interval = 30
  }
instances = ["${var.mywebserver1_id}", "${var.mywebserver2_id}"]
  tags = {
    Name = "my-loadbalancer"
  }
}
