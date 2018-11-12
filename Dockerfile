FROM alpine:latest

# Build-time metadata as defined at http://label-schema.org

LABEL org.label-schema.name="Terraform Light tool" \
    org.label-schema.url="https://github.com/lenisha/" \
    org.label-schema.vcs-url="https://github.com/lenisha/terraform-light" \
    org.label-schema.schema-version="1.0"
                
ENV TERRAFORM_VERSION 0.11.10

RUN apk add --update wget bash openssh

# Install Terraform
RUN echo "===> Installing Terraform ${TERRAFORM_VERSION}..." \
 && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
 &&	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
 && mv terraform /usr/local/bin/terraform \
 && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip 
