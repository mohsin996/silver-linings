# Deploynig EC2 instance with Apache
resource "aws_key_pair" "deployer" {
  key_name = "web_server"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Create web server
resource "aws_instance" "my-webserver1" {
    ami = "${var.latest_redhat}"
    instance_type = "t2.micro"
    key_name      = "web_server"
    subnet_id     = "${var.sn_web1}"
    associate_public_ip_address = true
    vpc_security_group_ids = [
    "${var.sg_web}",
  ]
    user_data = "${file("webapp/app/userdata.sh")}"
    tags = {
        "Name" = "my-webserver-1"
        "Site" = "my-web-site"
    }

connection {
    user         = "ec2-user"
    private_key  = "${file("~/.ssh/id_rsa")}"
    host = self.public_ip
  }

  # Save the public IP
  provisioner "local-exec" {
    command = "echo ${aws_instance.my-webserver1.public_ip} >> public-ip.txt"
  }

}

# Create web server2
resource "aws_instance" "my-webserver2" {
    ami = "${var.latest_redhat}"
    instance_type = "t2.micro"
    key_name      = "web_server"
    subnet_id     = "${var.sn_web2}"
    associate_public_ip_address = true
    vpc_security_group_ids = [
    "${var.sg_web}",
  ]
    user_data = "${file("webapp/app/userdata.sh")}"
    tags = {
        "Name" = "my-webserver-2"
        "Site" = "my-web-site"
    }
connection {
    user         = "ec2-user"
    private_key  = "${file("~/.ssh/id_rsa")}"
    host = self.public_ip
  }

  # Save the public IP
  provisioner "local-exec" {
    command = "echo ${aws_instance.my-webserver2.public_ip} >> public-ip.txt"
  }

}
