output "Jenkins-URL" {
  description = "Show public IP of the instance created"
  value       = "${aws_instance.jenkins_vm.public_ip}:${var.server-port}"
}
