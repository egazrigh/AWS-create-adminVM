# AWS-create-adminVM

A packer template to add a Jenkins Image inside a Docker AMI


# Pre-requisite
A Subscription , default VPC...

# Prepare / update Jenkins container image

Can add a packer_variable.json file to configure theses variables :
```JSON
{
    "region": "eu-west-3",
    "projectname" : "Jenkins_in_Docker",
    "owner" : "Eric",
    "billing" : "Bibi",
    "environment" : "Test",
    "build_date" : "2018_06_18"
}
```
Then run :
```
packer build var-file .\packer_variables.json 1-Create-Jenkins-AMI-in-Docker-image
```

# Deploy a Jenkins instance

terraform deploy

Output : 
- Jenkins-URL


# Notes


