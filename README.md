# silver-linings
This repository contains Terraform codes to create a one-tier and two tier prod application in AWS.
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

## Cloning the repository
```bash
$ git clone https://github.com/mohsin996/wiki_problem_statement.git
Cloning into 'wiki_problem_statement'...
remote: Enumerating objects: 23, done.
remote: Counting objects: 100% (23/23), done.
remote: Compressing objects: 100% (19/19), docreate ne.
remote: Total 23 (delta 3), reused 9 (delta 0), pack-reused 0
Unpacking objects: 100% (23/23), done.```
