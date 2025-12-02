# Use official Ubuntu base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install common utilities and clean up
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates \
    sudo \
    curl \
    git \
    iproute2 \
    gnupg \
    lsb-release \
    apt-transport-https \
 && rm -rf /var/lib/apt/lists/*

# Create vscode user (UID/GID match devcontainer defaults)
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
 && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
 && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
 && chmod 0440 /etc/sudoers.d/$USERNAME

# Ensure PATH and basic config
ENV USER=$USERNAME
ENV HOME=/home/$USERNAME
WORKDIR $HOME

# (Optional) add any extra tools you want preinstalled here

# drop back to non-root user
USER $USERNAME
