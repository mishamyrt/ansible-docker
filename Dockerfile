ARG UBUNTU_VERSION=26.04

FROM ubuntu:${UBUNTU_VERSION} AS ansible
LABEL maintainer="Mikhael Khrustik <misha@myrt.co>"
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        software-properties-common=0.120 \
        gpg=2.4.8-4ubuntu3 \
        gpg-agent=2.4.8-4ubuntu3 \
    && add-apt-repository --yes --update ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc=4:15.2.0-5ubuntu1 \
        python3-pip=25.1.1+dfsg-1ubuntu2 \
        python3-dev=3.14.3-0ubuntu2 \
        ansible=13.1.0+dfsg-1ubuntu1 \
        sshpass=1.10-0.1build1 \
        openssh-client=1:10.2p1-2ubuntu3.2 \
        rsync=3.4.1+ds1-7ubuntu0.3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --upgrade --no-cache-dir --break-system-packages \
        pycrypto==2.6.1 \
    && ansible-galaxy collection install community.docker \
    && echo 'localhost' > /etc/ansible/hosts

CMD ["ansible-playbook", "--version"]
