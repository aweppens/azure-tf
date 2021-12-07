# Overview

This is just a very basic Azure Landing Zone Setup containing the following:
* Azure Resource Group
* vNet with a private address space created in a specic region
* a Single Demo VM (Ubuntu 18.04-LTS)
    * Disk for VM storage (will delete whe VM detroyed)
    * a NIC for private and public IP
* Attached to the NIC:
    * NSG to allow SSH
    * Public IP

# Diagram
![AzureSinglevNet](https://user-images.githubusercontent.com/90761642/145072126-975317ab-6a19-4c53-a0df-edac464a3dee.png)


# Usage

* add your own IP to the ssh-source-address variable in terraform.tfvars
* kcreate ssh keys:
    * ssh-keygen -f mykey

This will genenrate mykey and mykey.pub. Terraform will send mykey.pub to the Azure instanceand store it in ~/.ssh/authorized_keys

* terraform init
* terraform plan
* terraform apply

# Login
* Copy the output of the public address
* ssh <ip_address> -i mykey -l demo

If you can't login make sure you added the correct IP

## Finding Images
```
az vm image list -p "Canonical"
az vm image list -p "Microsoft"
```
