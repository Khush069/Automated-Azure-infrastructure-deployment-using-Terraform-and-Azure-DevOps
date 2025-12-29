## azure-infra-automation
## Overview

This repository demonstrates automated Azure infrastructure deployment using Terraform and Azure DevOps.
The pipeline provisions Azure resources (VM, VNet, Subnet) automatically via a self-hosted Azure DevOps agent.

## Features

Fully automated CI/CD pipeline in Azure DevOps

Uses Terraform for Infrastructure as Code (IaC)

Secure variable group to manage Azure credentials and infrastructure variables

Self-hosted agent setup to avoid hosted parallelism limitations

Verified VM deployment in eastus with Standard_DS1_v2

## Folder Structure
azure-infra-automation/
│
├── main.tf                 # Terraform resource definitions
├── variables.tf            # Terraform variables
├── terraform.tfvars        # Optional local variables
├── provider.tf             # Azure provider configuration
├── output.tf               # Terraform outputs
└── azure-pipeline.yml      # Azure DevOps pipeline YAML

## Prerequisites
Azure subscription
Azure DevOps organization
Personal Access Token (PAT) with Agent Pools: Read & Manage
Self-hosted agent machine (Windows or Linux)
Terraform >= 1.6.x

## Setup Instructions
1️⃣ Configure Variable Group in Azure DevOps

Create a variable group named TerraformVariables with the following variables:

Variable	Value	Secret
ARM_CLIENT_ID	<service-principal-app-id>	✅
ARM_CLIENT_SECRET	<service-principal-password>	✅
ARM_SUBSCRIPTION_ID	<subscription-id>	❌
ARM_TENANT_ID	<tenant-id>	❌
resource_group_name	rg-infra-demo	❌
location	eastus	❌
vnet_name	vnet-demo	❌
subnet_name	subnet-demo	❌
vm_name	vm-demo	❌
vm_size	Standard_DS1_v2	❌
vm_zone	2	❌
admin_username	azureadmin	❌
admin_password	<your-password>	✅
2️⃣ Set Up Self-Hosted Agent

Create agent pool TerraformSelfHosted in Azure DevOps

Download agent package for your OS (Windows/Linux)

Run config.cmd (Windows) or config.sh (Linux)

Connect agent to your organization and assign to pool

Agent setup screenshot placeholder:

3️⃣ Update Pipeline YAML
trigger:
- main
pool:
  name: TerraformSelfHosted

variables:
- group: TerraformVariables
- name: TF_VAR_vm_size
  value: Standard_DS1_v2

steps:
- checkout: self

- script: |
    curl -LO https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
    unzip terraform_1.6.6_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    terraform version
  displayName: 'Install Terraform'

- script: terraform init
  displayName: Terraform Init

- script: terraform validate
  displayName: Terraform Validate

- script: terraform plan
  displayName: Terraform Plan

- script: terraform apply -auto-approve
  displayName: Terraform Apply

4️⃣ Run Pipeline

Trigger pipeline on main branch

Terraform provisions resources in Azure automatically

Pipeline run screenshot placeholder:

5️⃣ Terraform Output
Plan: 1 to add, 0 to change, 0 to destroy.
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
Azure Portal screenshot placeholder: Image shared seperately as output.

## Notes
Ensure self-hosted agent is online before running the pipeline
Terraform state is managed in your configured backend (Azure Storage recommended)

## Tech Stack
Terraform
Azure DevOps
Azure Cloud
PowerShell / Bash for agent setup

#Terraform #AzureDevOps #Azure #DevOps #InfrastructureAsCode #IaC #CloudAutomation #SelfHostedAgent #CI_CD #CloudEngineering
