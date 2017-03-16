# Build on latest Ubuntu LTS
FROM ubuntu:latest
MAINTAINER Dave Van Vessem <dave@undarl.com>

# Change shell to bash to allow the source command
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set non-interactive debconf
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install required system packages
RUN apt-get update && apt-get install -y -q --no-install-recommends \
	apt-transport-https \
	build-essential \
	ca-certificates \
	curl \
	git \
	libssl-dev \
	python \
	rsync \
	software-properties-common \
	wget \
    && rm -rf /var/lib/apt/lists/*

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VER_1 ????
ENV NODE_VER_2 ????

# Install nvm and node
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VER_1 \
    && nvm install $NODE_VER_2 \
    && nvm alias default $NODE_VER_1
    && nvm use default


