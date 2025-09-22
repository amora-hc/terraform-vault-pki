# Terraform Vault PKI

This repository includes a collection of Terraform modules and infrastructure code for managing Vault PKI workflows. The core logic is modular, with reusable Terraform resources to deploy and operate Vault. This codebase remains flexible, allowing for the deployment and management of any Vault secret engine or authentication workflow via Terraform.

Code for creating an automated environment for running Terraform workflows using Jenkins has been added under the `jenkins` directory. 
This approach utilizes a prebaked Docker image containing all required CLI binaries, plugins, and a seed job definition. It enables users to build, orchestrate, and automate any action or workflow using Jenkins pipelines as code. New pipelines can be added to suit any use case by simply adding new file definitions.

By default, Jenkins will be accessible at [http://localhost:8081](http://localhost:8081) after deployment.

## Quick Start

### Prerequisites

Before starting, ensure you have the following installed:

- Docker and Docker Compose
- Optional: `openssl` for certificate inspection

Additionally, ensure your system has:

- 4+ GB RAM and at least 10 GB free disk space for Docker containers
- Network access to Vault and Azure Key Vault

---

### Vault prerequisites

The `prereqs.sh` script automates the Vault-side configuration required for Jenkins pipelines to authenticate and interact securely with the Vault cluster

- Ensures `approle` auth method is enabled
- Defines a role named jenkins associated with the hcp-root policy (you can replace this with a more restrictive one as needed)
- Displays the `role_id` and generates a new `secret_id`. Both tese values are used to configure Jenkins credentials via the Vault Plugin further on

### Azure prerequisites

The `prereqs-azure.sh` script automates Azure-side setup for integrating Jenkins pipelines with Azure Key Vault. It provisions a Service Principal, assigns appropriate roles, and outputs credentials required by the Jenkins Azure Credentials Plugin.

- Defines the subscription, resource group, and Key Vault where certificates will be stored and managed.
- Generates a new Azure Service Principal with `Contributor` access to the specified resource group.
- Grants the Service Principal permissions to manage certificates (import, list, delete) in the specified Key Vault.
- Prints all values needed to populate Jenkins’ Azure Service Principal credentials plugin

### Credentials

#### Add Vault AppRole credentials

**Location:**  
`Manage Jenkins → Manage Credentials → (select store) → Global credentials (unrestricted) → Add Credentials`

**Steps:**
1. For **Kind**, choose **Vault App Role Credential**.  
2. Fill the form:
   - **Role ID:** `********` (from prerequisites script)  
   - **Secret ID:** `********` (from prerequisites script)  
   - **Path:** `approle` (or the mount path for your AppRole)  
   - **Namespace:** `admin` (or the namespace being provisioned)  
   - **ID:** `vault-cluster` (or any stable identifier for pipelines)  
   - **Description:** `AppRole for Jenkins` (or any valid description)
3. Click **Create**.

[HashiCorp Vault Plugin](https://plugins.jenkins.io/hashicorp-vault-plugin/)

#### Add Azure Service Principal credentials 

**Location:**  
`Manage Jenkins → Manage Credentials → (select store) → Global credentials (unrestricted) → Add Credentials`

**Steps:**
1. For **Kind**, choose **Azure Service Principal**.  
2. Fill the form:
   - **Subscription ID:** `********` (value from Azure prerequisites script)
   - **Client ID:** `*******` (value from Azure prerequisites script)
   - **Client Secret:** `*******` (value from Azure prerequisites script)
   - **Tenant ID:** `*******` (value from Azure prerequisites script)
   - **ID:** `azure-cloud` (or any stable identifier you will then reference in pipelines)
   - **Description:** `Azure Service Principal for Jenkins` (or any valid description)

Click on Create

[Azure Credentials Plugin](https://plugins.jenkins.io/azure-credentials/)

[Azure CLI Plugin](https://plugins.jenkins.io/azure-cli/)


### Installation

1. Clone the repository and navigate into the Jenkins folder:
```shell
  git clone https://github.com/amora-hc/terraform-vault-pki.git
  cd terraform-vault-pki/jenkins
```

2. Initialize and start Jenkins using Docker Compose:
```shell
./jenkins_init.sh
```

- Installs Jenkins, required plugins, CLI tools (terraform, vault, az), and mounts seed job definitions.

3. Log in to Jenkins:
- Use the initial admin password from the previous step (or directly from `jenkins_home/secrets/initialAdminPassword`).
- Create a new user when prompted and install recommended plugins.

4. You should see a **seed-job** created in Jenkins. Run it (may require script approval on first run). The job scans and loads all Groovy-defined pipelines from the repository.

### Usage

- Once the seed job has created the pipelines, set the correct parameter `VAULT_ADDR` before building any job.
- Pipelines automate Vault PKI provisioning and certificate lifecycle operations using the configured credentials.

## Tech Overview

- **Docker Compose:** Reproducible Jenkins environment setup.
- **Jenkins Pipelines as Code:** Automated workflows tracked via code.
- **Secrets Management:** Secure Vault and Azure credential use.
- **Extensible:** Add more pipeline Groovy files to customize.

## Troubleshooting

- Use `docker compose logs` for Jenkins container troubleshooting.
- Check Jenkins system logs if seed or pipeline jobs require approval or fail.
- Ensure credentials are present before using the pipelines.

---
