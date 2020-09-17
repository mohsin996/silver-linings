#### VARIABLES
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
