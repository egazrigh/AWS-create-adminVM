# AWS-create-adminVM

A packer template to build an Windows 2016 Administration VM on AWS with EC2 LaunchConfig customisation for Win 2016, image Tagging, Windows Update task...

Builded image can be customized by providing a list of :
- Chocolatey packages (separated by spaces)
- Windows Features (Powershell Windows Features names separated by comma) 
- Powershell PSGallery Modules names separated by comma

All installed packages, modules or features are verified with Pester tests.

# Pre-requisite
A Subscription , default VPC...

# Usage

Can add a packer_variable.json file to configure theses variables :
```JSON
{
    "region": "eu-west-3",
    "projectname" : "Packer",
    "owner" : "Eric",
    "billing" : "Bibi",
    "environment" : "Test",
    "build_date" : "2018_06_18",
    "choco_packages": "7zip putty.install sysinternals notepadplusplus git packer terraform vscode googlechrome pester",
    "windowsfeatures": "Web-Server,Remote-Desktop-Services,RSAT,RSAT-RDS-Tools,RSAT-File-Services,Web-Mgmt-Console",
    "powershell_psgallery_modules" : "PoshRSJob,Posh-SSH,posh-git"
}
```
Then run :
```
packer build -var-file .\packer_variables.json .\Win2016_Admin_VM.json
or 
packer build -var-file=.\packer_variables.json .\Win2016_Admin_VM.json
```

Output :
A TestResults xml containing the Pester tests results.

# Notes


