       
provider "aws" {
        region = "${var.region}"
}
#VPC
data "aws_vpc" "default" {
  default = true
}

#SG
resource "aws_security_group" "app_sg" {
        name            = "Appserver_SG"
        description     = "For web and ssh access"
        vpc_id          = "${data.aws_vpc.default.id}"

        ingress { 
                from_port       = 80
                to_port         = 80
                protocol        = "tcp"
                cidr_blocks     = ["0.0.0.0/0"]

        }       
        ingress { 
                from_port       = 22
                to_port         = 22
                protocol        = "tcp"
                cidr_blocks     = ["0.0.0.0/0"]

        }

        ingress { 
                from_port       = 443
                to_port         = 443
                protocol        = "tcp"
                cidr_blocks     = ["0.0.0.0/0"]

        }

        egress  { 
                from_port       = 0
                to_port         = 0
                protocol        = -1
                cidr_blocks     = ["0.0.0.0/0"]
        }

        tags = {
        "Name" = "app-server"
        "Site" = "mediawiki"
    }
}
#key pair
resource "aws_key_pair" "deployer" {
  key_name = "app_key"
  public_key = "${file("~/.ssh/my_aws.pub")}"
}
#Application instance. 
resource "aws_instance" "app_server" {
        ami = "${var.latest_redhat}" 
        instance_type = "t2.micro"
        key_name = "app_key"
        associate_public_ip_address = true
        vpc_security_group_ids = ["${aws_security_group.app_sg.id}"]    
	
	tags = {
        	"Name" = "app-server"
        	"Site" = "mediawiki"
   	 }
        provisioner "remote-exec" {
                inline = ["uptime"]
        
                connection {
                        type = "ssh"
                        host = self.public_ip
                        user = "ec2-user"
                        private_key = "${file("~/.ssh/my_aws")}"
                }
        }
        provisioner "local-exec" {
                command = "echo [prod] > ansible/hosts;echo ${aws_instance.app_server.public_ip} >> ansible/hosts"
                
        }
        provisioner "local-exec" {
                command = "ansible-playbook -i ansible/hosts ansible/playbook.yml --user ec2-user"
                
        }
}