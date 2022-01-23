# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.209.6/containers/rust/.devcontainer/base.Dockerfile

# [Choice] Debian OS version (use bullseye on local arm64/Apple Silicon): buster, bullseye
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/rust:0-${VARIANT}

RUN apt-get update  && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install zsh \
    && apt-get -y install neovim \
    && apt-get -y install emacs \
    && apt-get -y install fzf \
    && apt-get -y install exa \
    && apt-get -y install tldr \
    && apt-get -y install nodejs \
    && apt-get -y install tree \
    && apt-get -y install npm \
    && apt-get -y install python3-venv

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
    worker-build
