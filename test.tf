terraform {
  required_providers{
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}
provider "aws" {
  access_key = var.acc
  secret_key = var.sec
  region = var.region
}
output "instance_ip_addr" {
  value = format("Access the AWS hosted app from here: %s%s",aws_instance.aws_tom.*.public_ip, ":8080/PersistentWebApp")
}
  resource "aws_instance" "aws_tom" {
    ami = var.ami
    instance_type = var.ins_type
    key_name = "sample"
    tags = {
      Name = "aws_tom"
    }
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file(var.key_pri)
      host = "self.public_ip"
    }

    user_data = <<-EOF
 #!/bin/bash
  sudo amazon-linux-extras install tomcat8.5
  sudo systemctl enable tomcat
  sudo systemctl start tomcat
  cd /usr/share/tomcat/webapps/
  sudo cp /tmp/PersistentWebApp.war /usr/share/tomcat/webapps/PersistentWebApp.war
  EOF

    provisioner "file" {
      source = "/var/lib/jenkins/workspace/Websapps/target/PersistentWebApp.war"
      destination = "/tmp/PersistentWebApp.war"
      connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file(var.key_pri)
        host = "self.public_ip"
      }
    }
  }
variable "region" {
  type = string
  default = "us-east-1"
}
variable "ami" {
  type = string
  default = "ami-047a51fa27710816e"
}
variable "ins_type" {
  type = string
  default = "t2.micro"
}

variable "key_pri" {
  type = string
 
}

variable "acc" {
type = string
}

variable "sec" {
type = string
}
variable "key_p" {
  type = string
}

