FROM circleci/openjdk:8-jdk

ARG TERRAFORM_VERSION=0.11.11
ARG KONG_PROVIDER_VERSION=4.4.0

RUN sudo apt-get update && \
    sudo apt-get install -y python-pip coreutils jq && \
    sudo pip install awscli && \
    sudo apt-get clean autoclean && \
    sudo apt-get autoremove --yes && \
    sudo rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    sudo unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip

RUN mkdir -p $HOME/.terraform.d/plugins && \
    wget -O /tmp/kong_provider.zip https://github.com/kevholditch/terraform-provider-kong/releases/download/v${KONG_PROVIDER_VERSION}/terraform-provider-kong_${KONG_PROVIDER_VERSION}_linux_amd64.zip && \
    unzip /tmp/kong_provider.zip terraform-provider-kong_v${KONG_PROVIDER_VERSION} -d $HOME/.terraform.d/plugins && \
    rm /tmp/kong_provider.zip

COPY ./bin /usr/bin
