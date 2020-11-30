FROM jenkins/inbound-agent:latest

LABEL name=jenkins-slave

USER root

RUN \
    apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \ 
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    \
    groupadd -g 999 docker && \
    usermod -aG docker jenkins && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins
