ARG ITA_VERSION=latest

FROM exastro/exastro-it-automation-by-ansible-agent:${ITA_VERSION}

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY

ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV NO_PROXY=${NO_PROXY}

USER 0

RUN --mount=type=secret,id=host_certificate_file,dst=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem \
 dnf -y install langpacks-en glibc-langpack-en sudo git \
 && dnf -y install dnf-plugins-core \
 && dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo \
 && dnf -y install docker-ce-cli docker-buildx-plugin docker-compose-plugin \
 && echo 'Defaults visiblepw'              >> /etc/sudoers \
 && echo 'app_user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# RUN --mount=type=secret,id=host_certificate_file,dst=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem \
#  dnf -y install python3.9 python3.9-pip \
#  && alternatives --set python /usr/bin/python3.9 \
#  && alternatives --set python3 /usr/bin/python3.9

RUN alternatives --set python /usr/bin/python3.9 \
 && alternatives --set python3 /usr/bin/python3.9

USER 1000

RUN python -m pip install --upgrade pip --user \
 && python -m pip install ansible-builder ansible-lint yamllint ansibug

# Example:
# RUN ansible-galaxy collection install amazon.aws --force \
#  &&  pip install --upgrade boto3 botocore
# RUN ansible-galaxy collection install azure.azcollection --force --ignore-certs \
#  && python -m pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt
