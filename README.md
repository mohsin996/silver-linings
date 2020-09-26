# silver-linings
This repository contains Terraform codes to create a one-tier and two tier prod LAMP application in AWS.
## Prerequisites:

- AWS CLI (Install AWS CLI)
- Terraform (Install Terraform)
- Ansible (Install Ansible)
- IAM user in AWS with access keys.


#### Terraform & Ansible version
```bash
$ python --version
Python 3.8.0
$ terraform -version
 Terraform v0.12.23
$ ansible --version
 ansible 2.9.11
```
#### configuring aws-cli 
```bash
$ aws configure
 AWS Access Key ID [******************XX]:
 AWS Secret Access Key [*****************XX]:
 Default region name [us-east-1]:
 Default output format [table]:

Creating config key file and directory structure
```bash
 $ ssh-keygen -t rsa -b 4096 -f ~/.ssh/my_aws
```
## Cloning the repository
```
$ git clone https://github.com/mohsin996/silver-linings.git
Cloning into 'silver-linings'...
remote: Enumerating objects: 63, done.
remote: Counting objects: 100% (63/63), done.
remote: Compressing objects: 100% (56/56), done.
remote: Total 63 (delta 13), reused 40 (delta 2), pack-reused 0
Unpacking objects: 100% (63/63), done.
```
