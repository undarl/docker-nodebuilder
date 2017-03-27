# nvm/node environment for GitLab CI

# Installs two different versions of node; which two can 
#    be altered in the NODE_VER_1/2 environment variables
#    below.


# Build on latest Ubuntu LTS
FROM ubuntu:latest
MAINTAINER Dave Van Vessem <dave@undarl.com>

# Change shell to bash to allow the source command
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set non-interactive debconf
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install required packages
RUN apt-get update && apt-get install -y -q --no-install-recommends \
	apt-transport-https \
	build-essential \
	ca-certificates \
	curl \
	git \
	libfontconfig \
	libssl-dev \
	python \
	rsync \
	software-properties-common \
	wget \
    && rm -rf /var/lib/apt/lists/*

# nvm environment variables
# nvm and node versions should be changed here
ENV NVM_DIR /usr/local/nvm
ENV NVM_VER 0.33.0
ENV NODE_VER_1 0.12
ENV NODE_VER_2 6.10

# Install nvm and node
RUN curl https://raw.githubusercontent.com/creationix/nvm/v$NVM_VER/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VER_1 \
    && nvm install $NODE_VER_2 \
    && nvm alias default $NODE_VER_2 \
    && nvm use $NODE_VER_2

# Install Yarn
# RUN curl -o- -L https://yarnpkg.com/install.sh | bash

