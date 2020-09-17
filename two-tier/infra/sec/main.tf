#Create Web Server SG
resource "aws_security_group" "my-webserver" {
  name        = "webserver"
  description = "Allow HTTP from Anywhere"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-webserver"
    Site = "my-web-site"
  }
}
#Creating Database Server SG
resource "aws_security_group" "my-database" {
  name        = "database"
  description = "Allow MySQL/Aurora from WebService"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.my-webserver.id}"]
    self            = false
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-database"
    Site = "my-web-site"
  }
}
#Create Load Balancer SG
resource "aws_security_group" "my-loadbalancer" {
  name        = "loadbalancer"
  description = "Allow HTTP from Anywhere via ELB"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-loadbalancer"
    Site = "my-web-site"
  }
}
