# One-Tier


In this solution we are using 
- **Terraform** – To provision EC2 instance in a region.
- **Ansible** - To Integrate configuration management.

#### Terraform & Ansible Quickstart
```bash
$ cd one-tier
1. Terraform init
```
$ terraform init
```
2. Terraform plan
$ terraform plan
```

$ terraform apply -auto-approve
data.aws_vpc.default: Refreshing state...
aws_key_pair.deployer: Creating...
aws_security_group.app_sg: Creating...
aws_key_pair.deployer: Creation complete after 4s [id=app_key]
aws_security_group.app_sg: Still creating... [10s elapsed]
aws_security_group.app_sg: Creation complete after 12s [id=sg-0a0bd164ea6ca2307]
aws_instance.app_server: Creating...
aws_instance.app_server: Still creating... [10s elapsed]
.
aws_instance.app_server: Still creating... [1m0s elapsed]
aws_instance.app_server (remote-exec): Connecting to remote host via SSH...
.
aws_instance.app_server (local-exec): PLAY [configuration play] ****
aws_instance.app_server (local-exec): TASK [Gathering Facts]****
aws_instance.app_server (local-exec): TASK [ensure httpd is running] *****
aws_instance.app_server (local-exec): TASK [Install Mariadb Server] ****
aws_instance.app_server (local-exec): TASK [Install the php Dependencies] ****
aws_instance.app_server (local-exec): TASK [Create Mysql Database databasewiki] ***
aws_instance.app_server (local-exec): TASK [create database user admin with password] ****
aws_instance.app_server (local-exec): TASK [Downloading mediawiki-1.34.2.tar.gz and unarchiving] ****
aws_instance.app_server (local-exec): TASK [Create a symbolic link to /var/www/html/mediawiki] ****
aws_instance.app_server (local-exec): TASK [changing ownership of /var/www/html/mediawiki-1.34.2/] ****
aws_instance.app_server (local-exec): PLAY RECAP ***
aws_instance.app_server (local-exec): 54.166.33.212: ok=15   changed=14   unreachable=0 failed=0 skipped=0 rescued=0    ignored=0
aws_instance.app_server: Creation complete after 13m16s [id=i-0c536fd54d1686115]
$ terraform destroy -auto-approve
aws_key_pair.deployer: Refreshing state... [id=app_key]
data.aws_vpc.default: Refreshing state...
aws_security_group.app_sg: Refreshing state... [id=sg-0a0bd164ea6ca2307]
aws_instance.app_server: Refreshing state... [id=i-0c536fd54d1686115]
aws_key_pair.deployer: Destroying... [id=app_key]
aws_instance.app_server: Destroying... [id=i-0c536fd54d1686115]
aws_key_pair.deployer: Destruction complete after 1s
aws_instance.app_server: Still destroying... [id=i-0c536fd54d1686115, 10s elapsed]
aws_instance.app_server: Still destroying... [id=i-0c536fd54d1686115, 20s elapsed]
aws_instance.app_server: Still destroying... [id=i-0c536fd54d1686115, 30s elapsed]
aws_instance.app_server: Destruction complete after 36s
aws_security_group.app_sg: Destroying... [id=sg-0a0bd164ea6ca2307]
aws_security_group.app_sg: Destruction complete after 3s

Destroy complete! Resources: 3 destroyed.

```
