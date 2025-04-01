 # Azure-Infrastructure-Terraform

This GitHub repository contains provisioning of a sample Azure Infrastructure using terraform scripts.

### Getting started:
* Sign-in/ login to the Azure account.
* Select your default subcription.
* Install Visual Studio Code application in the local PC.
* Install Terraform for windows (latest version).

### Getting started with terraform:
* Navigate to Azure rm provider module in the Terraform registry.
* To deploy Azure resources using VS Code, Install the Azure rm provider in VS Code by running the code given in azure rm terraform registry.
* In Azure portal, register terraform application by Application registration option through Azure Active Directory.
  ![register application](https://github.com/user-attachments/assets/4cd47d09-6352-43fb-9617-fd0c79e40802)


### Terraform Configuration options:
In Azure rm provider, we provide the Credentials for authentication of Terraform to execute the commands in Azure account.
* Subscription ID of the subcription.

From Terraform application, add:
* Terraform Application/ Client ID.
* Directory/ Tenant ID.
* Client Credentials (create new client secret).

Give permission to Terraform application object, by assigning Contributer RBAC role from subscription.
* Assign role:

![role assign](https://github.com/user-attachments/assets/ac941743-edd7-48e6-9767-1cefbe8d6a3b)

* Add member:

![add members](https://github.com/user-attachments/assets/06559c2c-c748-432e-8a87-3bfcf99bc4c0)


### Azure Infrastructure resources provisioned in this repository:
* Virtual Network, Subnet configuration.
* Network Security Group(NSG) to define inbound rules for network security.
* Load Balancer and Backend pool to deliver incoming traffic among VM's.
* Virtual Machine Scale Set.
* Log Analytics Workspace and Configure Alerts rules.
* Recovery Services vault for VM backup.
