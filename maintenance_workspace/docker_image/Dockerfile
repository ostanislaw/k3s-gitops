# syntax=docker/dockerfile:1.3
# https://github.com/FernandoMiguel/Buildkit#mounttypecache

FROM ubuntu:21.10 as base
ENV DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt update
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y --no-install-recommends curl apt-transport-https software-properties-common python3-pip gnupg2
#FOR YARN
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y cmdtest


FROM base as repositories
#FOR KUBECTL
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
#FOR TERRAFORM
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
#FOR HELM
RUN curl -fsSL https://baltocdn.com/helm/signing.asc | apt-key add -
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt update

FROM repositories as prerequisites
#DIRENV
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y direnv
#AGE
# ubuntu 21.04+ has age in repository
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y age
#GO-TASK
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
#IPCALC
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y ipcalc
#JQ
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y jq
#KUBECTL
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y kubectl
#TERRAFORM
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y terraform
#HELM
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y helm
#KUSTOMIZE
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
#PRE-COMMIT
RUN --mount=type=cache,id=pip,target=/root/.cache/pip \
    pip3 install pre-commit
#ANSIBLE
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y ansible
#SOPS
RUN --mount=type=tmpfs,target=/tmp/sops_deb --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    curl -fsSLo /tmp/sops_deb/sops.deb https://github.com/mozilla/sops/releases/download/v3.7.1/sops_3.7.1_amd64.deb && \
    apt install /tmp/sops_deb/sops.deb

#PRETTIER
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y --no-install-recommends npm
RUN --mount=type=cache,id=npm,target=/root/.npm \
    npm install -g prettier
# GITLEAKS
RUN --mount=type=cache,target=/tmp/gitleaks/ \
curl -fsSLo /tmp/gitleaks/gitleaks.tar.gz https://github.com/zricethezav/gitleaks/releases/download/v8.2.7/gitleaks_8.2.7_linux_x64.tar.gz && \
cd /tmp/gitleaks && tar -zxvf gitleaks.tar.gz && cp gitleaks /usr/local/bin
#GOLANG
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install --no-install-recommends -y golang
#ADDITIONAL TOOLS
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y git vim gettext-base less
#FLUX CLI
RUN curl -SL https://fluxcd.io/install.sh | bash

FROM prerequisites as user_layer
ARG UID=1000
ARG GID=1000
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt install -y --no-install-recommends sudo
RUN groupadd -g ${GID} developer &&\
    useradd -l -u ${UID} -g developer developer &&\
    install -d -m 0755 -o developer -g developer /home/developer &&\
    usermod -aG sudo developer &&\
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER developer
