# Setup

# Azure CLI
* Download and install the Azure CLI from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
  * On MacOS, run brew update && brew install azure-cli
    * On Windows, you can download an rund the installer

# Sign in
```
az login
az account list --all --query "[].id"
```
# Set Azure subscription
```
export SUBSCRIPTION_ID="<azure_subscription_id>"
az account set --subscription="${SUBSCRIPTION_ID}"
```
# Create service principal for role-based access. Note the output of the Service Principal
# command where the client id, client secret, and tenant ids are shown.
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
```
# Once you have your Azure Service Principal values, you need to set a few environment variables
# so you're not having to maintain them. For the below values, you should have noted them
# from the above steps.
```
echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID="${SUBSCRIPTION_ID}"
export ARM_CLIENT_ID="<azure_client_id>"
export ARM_CLIENT_SECRET="<azure_client_secret>"
export ARM_TENANT_ID="<azure_tenant_id>"
```
# Not needed for public, required for usgovernment, german, china.
```
export ARM_ENVIRONMENT=public
```
