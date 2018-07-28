variable "region" {
  description = "Region where to deploy"
  type        = "string"
  default     = "eu-west-3"
}

variable "env" {
  description = "The environement (prod/dev/hml/test)"
}

variable "server-port" {
  description = "The port the web server will use for http requests"
  type        = "string"
}

variable "monitoring-port" {
  description = "The port the web server will use for monitoring requests"
  type        = "string"
}

variable "projectname" {
  description = "Name of project"
  type        = "string"
  default     = "projectname"
}

variable "owner" {
  description = "owner of project"
  type        = "string"
  default     = "owner"
}

variable "billing" {
  description = "billing of project"
  type        = "string"
  default     = "billing"
}

data "aws_availability_zones" "all" {}
