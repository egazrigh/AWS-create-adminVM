output "Jenkins-URL" {
  description = "Show public DNS of the instance created"
  value       = "${aws_instance.jenkins_vm.public_dns}:${var.server-port}"
}
