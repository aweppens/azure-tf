# Setup

# Azure CLI
* Download and install the Azure CLI from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
  * On MacOS, run brew update && brew install azure-cli
  * On Windows, you can download an rund the installer

* Install on Ubuntu
```
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
```

* Download and install the Microsoft signing key:
```
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
        sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
```

* Add the Azure CLI software repository:
```
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list
```

* Update repository information and install the azure-cli package:
```
sudo apt-get update
sudo apt-get install azure-cli
```
# Sign in
You can follow the following link for detailed steps: https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell-bash?tabs=bash
Login and Verify subscriptions.  Replace the <microsoft_account_email> placeholder with the Microsoft account email address whose Azure subscriptions you want to listjk
```
az login
az account list --query "[?user.name=='<microsoft_account_email>'].{Name:name, ID:id, Default:isDefault}" --output Table
```
# Set Azure subscription
```
export SUBSCRIPTION_ID="<azure_subscription_id>"
az account set --subscription "<subscription_id_or_subscription_name>"
```
# Create service principal for role-based access.
Note the output of the Service Principal
command where the client id, client secret, and tenant ids are shown.
* You can replace the <service-principal-name> with a custom name
* Upon successful completion, az ad sp create-for-rbac displays several values. The appId, password, and tenant values are used in the next step
```
az ad sp create-for-rbac --name <service_principal_name> --role Contributor
```
# Environment variables
For the below values, you should have noted them
from the above steps.
* Edit ~/.bashrc
```
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_CLIENT_ID="<azure_appId>"
export ARM_CLIENT_SECRET="<azure_client_secret>"
export ARM_TENANT_ID="<azure_tenant_id>"
```
