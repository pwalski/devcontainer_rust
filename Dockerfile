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
    && apt-get -y install tree

USER vscode

RUN rm -rf /home/vscode/.oh-my-zsh

RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN curl https://wasmtime.dev/install.sh -sSf | bash
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | bash

RUN rm /home/vscode/.zshrc
COPY --chown=vscode .zshrc /home/vscode/.zshrc

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
