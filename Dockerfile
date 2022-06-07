FROM ubuntu:20.04

ARG RUN_ENV_PROXY

ARG USERNAME=ubuntu
ARG GROUPNAME=ubuntu
ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=noninteractive
ENV USER $USERNAME
ENV HOME /home/${USER}
ENV PW ubuntu

# Install essentials
# hadolint ignore=DL3008
RUN apt-get update -q && \
    apt-get install --no-install-recommends -y \
    build-essential \
    tk-dev\
    openssh-client \
    locales \
    unzip \
    less \
    sudo \
    ca-certificates \
    ubuntu-wsl \
    iputils-ping \
    net-tools \
    dnsutils \
    git \
    curl \
    wget \
    bat \
    vim \
    gawk \
    fzf \
    peco \
    jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set laguage to Japanese
# hadolint ignore=DL3008
RUN apt-get update -q && \
    apt-get install --no-install-recommends -y language-pack-ja && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    update-locale LANG=ja_JP.UTF8

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup User
RUN groupadd -g $GID $GROUPNAME && \
    useradd -l -m -s /bin/bash -u $UID -g $GID $USERNAME && \
    gpasswd -a ${USER} sudo && \
    echo "${USER}:${PW}" | chpasswd && \
    sed -i.bak -r s#${HOME}:\(.+\)#${HOME}:/bin/bash# /etc/passwd && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY configs/wsl.conf /etc/wsl.conf

USER ${USER}

COPY --chown=$UID:$GID scripts ${HOME}/scripts
COPY --chown=$UID:$GID dotfiles ${HOME}

RUN find ${HOME}/scripts -type f -name "*.sh" -print0 | \
    xargs -0 chmod +x

WORKDIR ${HOME}

# VSCode PATH
RUN echo "" >> ~/.bashrc && \
    echo "# Set VSCode PATH" >> ~/.bashrc && \
    echo "source ~/.add_win_paths" >> ~/.bashrc

# 実行環境用のプロキシ設定を追加する
ENV http_proxy $RUN_ENV_PROXY
ENV https_proxy $RUN_ENV_PROXY
ENV HTTP_PROXY $RUN_ENV_PROXY
ENV HTTPS_PROXY $RUN_ENV_PROXY

USER root

# hadolint ignore=DL4006
RUN :  \
    && { \
    echo 'Acquire::http:proxy "'${http_proxy}'";'; \
    echo 'Acquire::https:proxy "'${https_proxy}'";'; \
    } | tee /etc/apt/apt.conf

# Set root proxy
RUN echo "export http_proxy=$http_proxy" >> /root/.bashrc && \
    echo "export https_proxy=$http_proxy" >> /root/.bashrc && \
    echo "export HTTP_PROXY=$http_proxy" >> /root/.bashrc && \
    echo "export HTTPS_PROXY=$http_proxy" >> /root/.bashrc

USER ${USER}

# Set user proxy
RUN echo "export http_proxy=$http_proxy" >> ~/.bashrc && \
    echo "export https_proxy=$http_proxy" >> ~/.bashrc && \
    echo "export HTTP_PROXY=$http_proxy" >> ~/.bashrc && \
    echo "export HTTPS_PROXY=$http_proxy" >> ~/.bashrc
