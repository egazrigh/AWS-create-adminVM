#!/bin/bash

docker run -p ${server-port}:${server-port} -p ${monitoring-port}:${monitoring-port} \
-v jenkins_home:/var/jenkins_home \
jenkins/jenkins:lts
# try to retreive Jenkins initialAdminPassword
sudo cat $(sudo find / -name initialAdminPassword 2>/dev/null)

