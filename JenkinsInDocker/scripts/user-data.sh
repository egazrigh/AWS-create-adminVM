#!/bin/bash

docker run -p ${server-port}:${server-port} -p ${monitoring-port}:${monitoring-port} \
-v /var/jenkins_home \
jenkins/jenkins:lts
