FROM circleci/openjdk:8-jdk

RUN sudo apt-get update
RUN sudo apt-get install -y python-pip coreutils jq
RUN sudo pip install awscli
RUN sudo apt-get clean autoclean
RUN sudo apt-get autoremove --yes
RUN sudo rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
RUN sudo unzip /tmp/terraform.zip -d /usr/local/bin && rm /tmp/terraform.zip
