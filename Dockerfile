FROM circleci/openjdk:8-jdk

RUN sudo apt-get update && \
    sudo apt-get install -y python-pip coreutils jq && \
    sudo pip install awscli && \
    sudo apt-get clean autoclean && \
    sudo apt-get autoremove --yes && \
    sudo rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip && \
    sudo unzip /tmp/terraform.zip -d /usr/local/bin && rm /tmp/terraform.zip

COPY ./bin /usr/bin
