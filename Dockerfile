FROM centos:7

ENV ANSIBLE_VERSION 2.9.*

RUN yum install -y python git curl python3 python-pip && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    pip3 install --user https://releases.ansible.com/ansible-tower/cli/ansible-tower-cli-latest.tar.gz

CMD ansible --version