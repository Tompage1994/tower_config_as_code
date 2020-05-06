FROM centos:7

ENV ANSIBLE_VERSION 2.9.*

RUN yum install -y python git curl python3 python-pip && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    yum-config-manager --add-repo https://releases.ansible.com/ansible-tower/cli/ansible-tower-cli-el7.repo && \
    yum install -y ansible-tower-cli --nogpgcheck

CMD ansible --version