FROM ubuntu:16.04

# Build-time metadata as defined at http://label-schema.org

LABEL org.label-schema.name="Terraform Light tool" \
    org.label-schema.url="https://github.com/lenisha/" \
    org.label-schema.vcs-url="https://github.com/lenisha/terraform-light" \
    org.label-schema.schema-version="1.0"
                
ENV TERRAFORM_VERSION 0.11.10

RUN apt-get update \
 && apt-get install -y wget unzip lsb-release curl apt-transport-https

# Install Terraform
RUN echo "===> Installing Terraform ${TERRAFORM_VERSION}..." \
 && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
 &&	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
 && mv terraform /usr/local/bin/terraform \
 && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip 
 
 # Install Azure CLI (instructions taken from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" \
  | tee /etc/apt/sources.list.d/azure-cli.list \
 && curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    azure-cli \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /etc/apt/sources.list.d/* \
 && az --version
 
 RUN az extension add --name storage-preview
