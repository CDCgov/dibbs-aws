data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create a DB subnet group
resource "aws_db_subnet_group" "db_setup" {
  name       = "${local.vpc_name}-db-setup-group-${terraform.workspace}"
  subnet_ids = var.public_subnet_ids
  tags       = var.tags
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group" "db_setup" {
  vpc_id = var.vpc_id

  # Allow inbound traffic on port 22 to SSH from the user's IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  # Allow all outbound traffic
  # https://avd.aquasec.com/misconfig/aws/ec2/avd-aws-0104/
  # trivy:ignore:AVD-AWS-0104
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_instance" "postgresql_setup" {
  count                       = var.database_type == "postgresql" && var.ssh_key_name != "" ? 1 : 0
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.db_setup.id]
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name

  provisioner "file" {
    content     = <<-EOF
      DATABASE_URL=postgres://${aws_db_instance.postgresql[0].username}:${random_password.database.result}@${aws_db_instance.postgresql[0].address}:${aws_db_instance.postgresql[0].port}/${aws_db_instance.postgresql[0].db_name}
      SQL_FILE=postgresql.sql
    EOF
    destination = ".env"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  provisioner "file" {
    # content     = <<-EOF
    #   CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    #   CREATE SCHEMA ecr_viewer;
    #   CREATE TABLE ecr_viewer.ecr_data (
    #     eicr_id VARCHAR(200) PRIMARY KEY,
    #     set_id VARCHAR(255),
    #     eicr_version_number VARCHAR(50),
    #     data_source VARCHAR(2), -- S3 or DB
    #     fhir_reference_link VARCHAR(500), -- Link to the ecr fhir bundle
    #     patient_name_first VARCHAR(100),
    #     patient_name_last VARCHAR(100),
    #     patient_birth_date DATE,
    #     date_created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    #     report_date DATE
    #   );
    #   CREATE TABLE ecr_viewer.ecr_rr_conditions (
    #       uuid VARCHAR(200) PRIMARY KEY,
    #       eicr_id VARCHAR(200) NOT NULL REFERENCES ecr_viewer.ecr_data(eicr_id),
    #       condition VARCHAR
    #   );
    #   CREATE TABLE ecr_viewer.ecr_rr_rule_summaries (
    #       uuid VARCHAR(200) PRIMARY KEY,
    #       ecr_rr_conditions_id VARCHAR(200) REFERENCES ecr_viewer.ecr_rr_conditions(uuid),
    #       rule_summary VARCHAR
    #   );
    # EOF
    content     = <<-EOF
    EOF
    destination = "postgresql.sql"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  provisioner "file" {
    content     = <<-EOF
      #!/bin/bash
      # Load environment variables from .env file
      if [ -f .env ]; then
          export $(cat .env | xargs)
      fi
      # Run the SQL file
      psql $DATABASE_URL -f $SQL_FILE
    EOF
    destination = "postgresql_setup.sh"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y postgresql-client",
      "chmod +x postgresql_setup.sh",
      "./postgresql_setup.sh",
      "sudo shutdown now"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  tags = merge(var.tags, { Name = local.vpc_name })

  depends_on = [aws_db_instance.postgresql]
}

resource "aws_instance" "sqlserver_setup" {
  count                       = var.database_type == "sqlserver" && var.ssh_key_name != "" ? 1 : 0
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = [aws_security_group.db_setup.id]
  associate_public_ip_address = true
  key_name                    = var.ssh_key_name

  provisioner "file" {
    content     = <<-EOF
      DATABASE_URL=sqlserver://${aws_db_instance.sqlserver[0].username}:${random_password.database.result}@${aws_db_instance.sqlserver[0].address}:${aws_db_instance.sqlserver[0].port};database=${aws_db_instance.sqlserver[0].db_name};encrypt=true;trustServerCertificate=true
      DATABASE_HOST=${aws_db_instance.sqlserver[0].address}
      DATABASE_USER=${aws_db_instance.sqlserver[0].username}
      DATABASE_PASSWORD=${random_password.database.result}
      DATABASE_NAME=ecr_viewer_db
      SQL_FILE=sqlserver.sql
    EOF
    destination = ".env"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  provisioner "file" {
    content     = <<-EOF
      IF NOT EXISTS (
          SELECT *
          FROM sys.databases
          WHERE name = 'ecr_viewer_db'
          )
      BEGIN
          CREATE DATABASE ecr_viewer_db
      END
      GO
      
      CREATE SCHEMA ecr_viewer;

      CREATE TABLE ecr_viewer.ecr_data
      (
          eicr_id                  VARCHAR(200) PRIMARY KEY,
          set_id                   VARCHAR(255),
          fhir_reference_link      VARCHAR(255),
          last_name                VARCHAR(255),
          first_name               VARCHAR(255),
          birth_date               DATE,
          gender                   VARCHAR(50),
          birth_sex                VARCHAR(50),
          gender_identity          VARCHAR(50),
          race                     VARCHAR(255),
          ethnicity                VARCHAR(255),
          latitude                 FLOAT,
          longitude                FLOAT,
          homelessness_status      VARCHAR(255),
          disabilities             VARCHAR(255),
          tribal_affiliation       VARCHAR(255),
          tribal_enrollment_status VARCHAR(255),
          current_job_title        VARCHAR(255),
          current_job_industry     VARCHAR(255),
          usual_occupation         VARCHAR(255),
          usual_industry           VARCHAR(255),
          preferred_language       VARCHAR(255),
          pregnancy_status         VARCHAR(255),
          rr_id                    VARCHAR(255),
          processing_status        VARCHAR(255),
          eicr_version_number      VARCHAR(50),
          authoring_date           DATETIME,
          authoring_provider       VARCHAR(255),
          provider_id              VARCHAR(255),
          facility_id              VARCHAR(255),
          facility_name            VARCHAR(255),
          encounter_type           VARCHAR(255),
          encounter_start_date     DATETIME,
          encounter_end_date       DATETIME,
          reason_for_visit         VARCHAR(MAX),
          active_problems          VARCHAR(MAX),
          date_created DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
      )

      CREATE TABLE ecr_viewer.patient_address
      (
          UUID VARCHAR(200) PRIMARY KEY,
          [use]  VARCHAR(7), -- The valid values are: "home" | "work" | "temp" | "old" | "billing"
          type VARCHAR(8), -- The valid values are: "postal" | "physical" | "both"
          text VARCHAR(MAX),
          line VARCHAR(255),
          city VARCHAR(255),
          district VARCHAR(255),
          state VARCHAR(255),
          postal_code VARCHAR(20),
          country VARCHAR(255),
          period_start DATETIMEOFFSET,
          period_end DATETIMEOFFSET,
          eicr_id VARCHAR(200) REFERENCES ecr_viewer.ecr_data (eicr_id)
      )

      CREATE TABLE ecr_viewer.ecr_rr_conditions
      (
          UUID      VARCHAR(200) PRIMARY KEY,
          eicr_id   VARCHAR(200) NOT NULL REFERENCES ecr_viewer.ecr_data (eicr_id),
          condition VARCHAR(MAX)
      )

      CREATE TABLE ecr_viewer.ecr_rr_rule_summaries
      (
          UUID                 VARCHAR(200) PRIMARY KEY,
          ECR_RR_CONDITIONS_ID VARCHAR(200) REFERENCES ecr_viewer.ecr_rr_conditions (UUID),
          rule_summary         VARCHAR(MAX)
      )


      CREATE TABLE ecr_viewer.ecr_labs
      (
          UUID                                   VARCHAR(200),
          eicr_id                                VARCHAR(200) REFERENCES ecr_viewer.ecr_data (eicr_id),
          test_type                              VARCHAR(255),
          test_type_code                         VARCHAR(50),
          test_type_system                       VARCHAR(255),
          test_result_qualitative                VARCHAR(MAX),
          test_result_quantitative               FLOAT,
          test_result_units                      VARCHAR(50),
          test_result_code                       VARCHAR(50),
          test_result_code_display               VARCHAR(255),
          test_result_code_system                VARCHAR(50),
          test_result_interpretation             VARCHAR(255),
          test_result_interpretation_code        VARCHAR(50),
          test_result_interpretation_system      VARCHAR(255),
          test_result_reference_range_low_value  FLOAT,
          test_result_reference_range_low_units  VARCHAR(50),
          test_result_reference_range_high_value FLOAT,
          test_result_reference_range_high_units VARCHAR(50),
          specimen_type                          VARCHAR(255),
          specimen_collection_date               DATE,
          performing_lab                         VARCHAR(255),
          PRIMARY KEY (UUID, eicr_id)
      );
    EOF
    destination = "sqlserver.sql"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  provisioner "file" {
    content     = <<-EOF
      #!/bin/bash
      # Load environment variables from .env file
      if [ -f .env ]; then
          export $(cat .env | xargs)
      fi
      # Run the SQL file
      sqlcmd -S $DATABASE_HOST -U $DATABASE_USER -P $DATABASE_PASSWORD -d $DATABASE_NAME -i $SQL_FILE
    EOF
    destination = "sqlserver_setup.sh"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo curl -sSL -O https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb",
      "sudo dpkg -i packages-microsoft-prod.deb",
      "sudo apt-get update",
      "sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev",
      "chmod +x sqlserver_setup.sh",
      "./sqlserver_setup.sh",
      "sudo shutdown now"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  tags = merge(var.tags, { Name = local.vpc_name })

  depends_on = [aws_db_instance.sqlserver]
}
