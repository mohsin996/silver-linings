
# Two-Tier

To deployment of [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) with Terraform in AWS Cloud

This solution is having 2 modules.
- **Infrastructure** - this will have two sub-modules: network and security
- **Web application**- this will have three sub-modules: application, database and load balancer.

## Infrastructure
This module will create following services-
- VPC (Virtual Private Cloud)
- VPC Internet Gateway
- VPC Public & Private Subnets
- VPC Routing table
- VPC Security Groups for web & database

## Web Application
This module will create following services-
- EC2 (Elastic Cloud Compute) in two AZ
- RDS (Relational Database Service)
- ELB (Elastic Load Balancer)

### Infra Module – Explanation
-	Sub module - net – creates a VPC, two public & two private subnets, IG and Route Table.
-	Sub Module - sec – creates security groups for webserver, database load balancer.

### Web Module – Explanation
-	Sub module - app – provision EC2 instances and install Apache, php & places MediaWiki tar.gz in Apace root directory.
-	Sub Module - db – creates RDS in Private subnet with endpoint details stored in a file.
-	Sub Module – elb – creates a classic Load balancer.

Main Terraform Script calls both the infra and webapp modules. 

main.tf 

```#### VARIABLES
variable "region" {}
variable "database_name" {}
variable "database_user" {}
variable "database_password" {}

#### CALL MDOULES
module "core_infra" {
  source  = "./infra"
  region  = "${var.region}"
}
module "webapp" {
  source   = "./webapp"
  region   = "${var.region}"
  sg_elb = "${module.core_infra.sg_elb}"
  # pass web security group and public networks
  sg_web = "${module.core_infra.sg_web}"
  sn_web1 = "${module.core_infra.sn_pub1}"
  sn_web2 = "${module.core_infra.sn_pub2}"
  # pass database security group and private networks
  sg_db  = "${module.core_infra.sg_db}"
  sn_db1 = "${module.core_infra.sn_priv1}"
  sn_db2 = "${module.core_infra.sn_priv2}"
  # database parameters
  database_name     = "${var.database_name}"
  database_user     = "${var.database_user}"
  database_password = "${var.database_password}"
}
```
### Directory Tree
```bash
── wiki_problem_statement
    ├── db.tfvars
    ├── db_endpoint.txt
    ├── main.tf
    ├── public-ip.txt
    ├── infra
    │   ├── aws.tf
    │   ├── main.tf
    │   ├── net
    │   │   ├── main.tf
    │   │   └── output.tf
    │   ├── output.tf
    │   └── sec
    │       ├── main.tf
    │       ├── output.tf
    │       └── variables.tf
    └── webapp
        ├── app
        │   ├── main.tf
        │   ├── output.tf
        │   └── variables.tf
        ├── aws.tf
        ├── db
        │   ├── main.tf
        │   └── variables.tf
        ├── elb
        │   ├── main.tf
        │   ├── output.tf
        │   └── variables.tf
        ├── main.tf
        └── variables.tf
  ```

## QuickStart 
**1. Initiating the Infra & Webapp modules.**
```bash
$ cd two-tier
$ terraform init
Initializing modules...
- core_infra in infra
- core_infra.network in infra/net
- core_infra.security in infra/sec
- webapp in webapp
- webapp.db in webapp/db
- webapp.elb in webapp/elb
- webapp.instances in webapp/app

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 3.6.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 3.6"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
**2. Terraform plan**
```bash
$ terraform plan -var-file="db.tfvars"
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

Terraform will perform the following actions:
module.core_infra.module.network.aws_internet_gateway.my-igw will be created
module.core_infra.module.network.aws_route_table.my-rt will be created
module.core_infra.module.network.aws_route_table_association.my-public1 will be created
module.core_infra.module.network.aws_route_table_association.my-public2 will be created
module.core_infra.module.network.aws_subnet.my-private1 will be created
module.core_infra.module.network.aws_subnet.my-private2 will be created
module.core_infra.module.network.aws_subnet.my-public1 will be created
module.core_infra.module.network.aws_subnet.my-public2 will be created
module.core_infra.module.network.aws_vpc.my-main will be created
module.core_infra.module.security.aws_security_group.my-database will be created
module.core_infra.module.security.aws_security_group.my-loadbalancer will be created
module.core_infra.module.security.aws_security_group.my-webserver will be created
module.webapp.module.db.aws_db_instance.my-db will be created
module.webapp.module.db.aws_db_subnet_group.my-dbsg will be created
module.webapp.module.elb.aws_elb.my-loadbalancer will be created
module.webapp.module.instances.aws_instance.my-webserver1 will be created
module.webapp.module.instances.aws_instance.my-webserver2 will be created
module.webapp.module.instances.aws_key_pair.deployer will be created

Plan: 18 to add, 0 to change, 0 to destroy.
```
**3. Terraform Apply**
```bash
$ terraform apply  -var-file="db.tfvars" -auto-approve
module.webapp.module.instances.aws_key_pair.deployer: Creation complete after 3s [id=web_server]
module.core_infra.module.network.aws_vpc.my-main: Creation complete after 21s [id=vpc-0defdcd0e02f5dc9f]
module.core_infra.module.network.aws_subnet.my-public2: Creation complete after 6s [id=subnet-05c2191c3906658ea]
module.core_infra.module.network.aws_subnet.my-public1: Creation complete after 6s [id=subnet-0038350715546c76e]
module.core_infra.module.network.aws_subnet.my-private1: Creation complete after 6s [id=subnet-02bbf3243b51ea58b]
module.core_infra.module.network.aws_subnet.my-private2: Creation complete after 6s [id=subnet-0352d1150565d62da]
module.core_infra.module.network.aws_internet_gateway.my-igw: Creation complete after 7s [id=igw-0e777468508d64c96]
module.webapp.module.db.aws_db_subnet_group.my-dbsg: Creation complete after 4s [id=my-dbsg]
module.core_infra.module.network.aws_route_table.my-rt: Creation complete after 5s [id=rtb-053e3f3948e28437f]
module.core_infra.module.security.aws_security_group.my-webserver: Creation complete after 12s [id=sg-0f6ba8e4a85e3b343]
module.core_infra.module.security.aws_security_group.my-loadbalancer: Creation complete after 12s [id=sg-09914dafc09e37c29]
module.core_infra.module.network.aws_route_table_association.my-public2: Creation complete after 1s [id=rtbassoc-069f4e0dbfe3f584d]
module.core_infra.module.network.aws_route_table_association.my-public1: Creation complete after 1s [id=rtbassoc-000d86d4e5c759ae2]
module.core_infra.module.security.aws_security_group.my-database: Creation complete after 13s [id=sg-0acf9b16b82c39876]
module.webapp.module.instances.aws_instance.my-webserver2: Creation complete after 38s [id=i-036d635476de2dbf8]
module.webapp.module.instances.aws_instance.my-webserver1: Creation complete after 38s [id=i-02fef188397f82f4c]
module.webapp.module.elb.aws_elb.my-loadbalancer: Creation complete after 23s [id=my-loadbalancer]
module.webapp.module.db.aws_db_instance.my-db: Creation complete after 4m17s [id=my-db]
Apply complete! Resources: 18 added, 0 changed, 0 destroyed.
```
**4. To destroy the Teraform infrastructure**
```bash
$ terraform destroy -var-file="db.tfvars"
..
Plan: 0 to add, 0 to change, 18 to destroy.
Destroy complete! Resources: 18 destroyed.
```

