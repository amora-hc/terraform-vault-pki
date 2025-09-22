# Terraform Vault PKI

This repository includes a collection of Terraform modules and infrastructure code for managing Vault PKI workflows. The core logic is modular, with reusable Terraform resources to deploy and operate Vault. This codebase remains flexible, allowing for the deployment and management of any Vault secret engine or authentication workflow via Terraform.

Code for creating an automated environment for running Terraform workflows using Jenkins has been added under the `jenkins` directory. 
This approach utilizes a prebaked Docker image containing all required CLI binaries, plugins, and a seed job definition. It enables users to build, orchestrate, and automate any action or workflow using Jenkins pipelines as code. New pipelines can be added to suit any use case by simply adding new file definitions.

By default, Jenkins will be accessible at [http://localhost:8081](http://localhost:8081) after deployment.

## Quick Start

### Prerequisites

- Docker and Docker Compose installed

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

### Before Running Pipelines

- Add Jenkins credentials for:
- **Vault AppRole:** (role_id, secret_id)
- **Azure Service Principal:** (client_id, secret, tenant, subscription)
- Go to **Jenkins > Manage Credentials** and add them.

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
