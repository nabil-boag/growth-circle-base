FROM circleci/openjdk:8-jdk

  ARG TERRAFORM_VERSION=0.11.11
  ARG KONG_PROVIDER_VERSION=4.4.0

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo bash - && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt-get update && \
    sudo apt-get install -y python-pip coreutils jq nodejs && \
    sudo apt-get install yarn && \
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
