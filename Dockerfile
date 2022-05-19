# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.209.6/containers/rust/.devcontainer/base.Dockerfile

# [Choice] Debian OS version (use bullseye on local arm64/Apple Silicon): buster, bullseye
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/rust:0-${VARIANT}

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
    zsh \
    neovim \
    emacs \
    fzf \
    exa \
    tldr \
    nodejs \
    tree \
    npm \
    build-essential cmake \
    python-dev \
    python3-dev \
    python-setuptools \
    python3-setuptools \
    python-pip \
    python3-pip \
    python3-venv \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g typescript
RUN npm install -g webpack
RUN npm install -g yarn
RUN npm install -g grunt

USER vscode

RUN rm -rf /home/vscode/.oh-my-zsh

RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | bash

RUN rm /home/vscode/.zshrc
COPY --chown=vscode .zshrc /home/vscode/.zshrc

RUN rustup toolchain install stable
RUN rustup toolchain install beta
RUN rustup toolchain install nightly

RUN cargo install \
    bootimage \
    cargo-audit \
    cargo-binutils \
    cargo-edit \
    cargo-expand \
    cargo-license \
    cargo-readme \
    cargo-xbuild \
    worker-build \
    cargo-watch \
    cargo-sort
