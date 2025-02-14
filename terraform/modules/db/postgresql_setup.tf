data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
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
  tags = var.tags
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group" "db_setup" {
  vpc_id = var.vpc_id

  # Allow inbound traffic on port 5432 for PostgreSQL from within the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  # Allow all outbound traffic
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
      SQL_FILE=core.sql
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
      CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

      CREATE TABLE ecr_data (
        eICR_ID VARCHAR(200) PRIMARY KEY,
        set_id VARCHAR(255),
        eicr_version_number VARCHAR(50),
        data_source VARCHAR(2), -- S3 or DB
        fhir_reference_link VARCHAR(500), -- Link to the ecr fhir bundle
        patient_name_first VARCHAR(100),
        patient_name_last VARCHAR(100),
        patient_birth_date DATE,
        date_created TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        report_date DATE
      );

      CREATE TABLE ecr_rr_conditions (
          uuid VARCHAR(200) PRIMARY KEY,
          eICR_ID VARCHAR(200) NOT NULL REFERENCES ecr_data(eICR_ID),
          condition VARCHAR
      );

      CREATE TABLE ecr_rr_rule_summaries (
          uuid VARCHAR(200) PRIMARY KEY,
          ecr_rr_conditions_id VARCHAR(200) REFERENCES ecr_rr_conditions(uuid),
          rule_summary VARCHAR
      );
    EOF
    destination = "core.sql"
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
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = self.password_data
      host     = self.public_ip
    }
  }

  tags = var.tags

  depends_on = [aws_db_instance.postgresql]
}