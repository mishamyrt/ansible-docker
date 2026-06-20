ARG UBUNTU_VERSION_ARG=26.04

FROM ubuntu:${UBUNTU_VERSION_ARG} AS ansible
LABEL maintainer="Mikhael Khrustik <misha@myrt.co>"
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common gpg gpg-agent \
    && add-apt-repository --yes --update ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends gcc python3-pip python3-dev ansible sshpass openssh-client rsync \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade --no-cache-dir --break-system-packages pycrypto pywinrm
RUN ansible-galaxy collection install community.docker
RUN echo 'localhost' > /etc/ansible/hosts
CMD ["ansible-playbook", "--version"]
