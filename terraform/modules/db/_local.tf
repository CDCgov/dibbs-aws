locals {
  vpc_name                  = "${var.project}-${var.owner}-${terraform.workspace}"
  sqlserver_engine          = "sqlserver-ex"
  sqlserver_engine_version  = "16.00.4165.4.v1"
  sqlserver_instance_class  = "db.t3.micro"
  postgresql_engine         = "postgres"
  postgresql_engine_version = "16.8"
  postgresql_instance_class = "db.t3.micro"
}
