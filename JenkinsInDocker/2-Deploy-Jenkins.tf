provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "eg2-s3bucket-for-shared-terraform-tfstate"
    key    = "jenkins/terraform.tfstate"
    region = "eu-west-3"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name = "${var.projectname}-sg"

  tags {
    Name    = "${var.projectname}-sg"
    Env     = "${var.env}"
    owner   = "${var.owner}"
    billing = "${var.billing}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_http_in_on_jenkins" {
  type              = "ingress"
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  from_port         = "${var.server-port}"
  to_port           = "${var.server-port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_status_in_on_jenkins" {
  type              = "ingress"
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  from_port         = "${var.monitoring-port}"
  to_port           = "${var.monitoring-port}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_out_on_jenkins" {
  type              = "egress"
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh_in_for_me_on_jenkins" {
  type              = "ingress"
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["88.174.85.15/32"]
}

data "aws_ami" "Docker_Jenkins_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Jenkins_in_Docker*"]
  }

  /* name_regex = "^myami-\\d{3}" */
  owners = ["self"]
}

resource "aws_instance" "jenkins_vm" {
  /* ami                    = "ami-0ee645b06c5a06743" */
  ami                    = "${data.aws_ami.Docker_Jenkins_ami.id}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.jenkins_sg.id}"]
  count                  = 1
  user_data              = "${data.template_file.user_data.rendered}"
  key_name               = "Docker"

  tags {
    Name    = "${var.projectname}"
    Env     = "${var.env}"
    owner   = "${var.owner}"
    billing = "${var.billing}"
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/scripts/user-data.sh")}"

  vars {
    server-port     = "${var.server-port}"
    monitoring-port = "${var.monitoring-port}"
  }
}

resource "local_file" "adminpassword" {
  content  = "sudo cat $(sudo find / -name initialAdminPassword 2>/dev/null)"
  filename = "${path.module}/adminpassword.txt"
}
