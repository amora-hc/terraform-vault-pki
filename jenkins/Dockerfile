FROM jenkins/jenkins:lts-jdk21
USER root

# Define versions
ARG TERRAFORM_VERSION=1.12.2
ARG VAULT_VERSION=1.19.5

# Install required OS packages
RUN apt-get update && \
    apt-get install -y curl unzip openssl gnupg2 software-properties-common apt-transport-https && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install jq (needed for JSON parsing in scripts)
RUN apt-get update && apt-get install -y jq

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/terraform.zip && \
    unzip -o -q /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip

# Install Vault
RUN curl -fsSL https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o /tmp/vault.zip && \
    unzip -o -q /tmp/vault.zip -d /usr/local/bin && \
    rm /tmp/vault.zip

# Jenkins plugins installation (JQuery3 API, HashiCorp Vault, Terraform, Azure CLI)
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Switch back to Jenkins user
USER jenkins