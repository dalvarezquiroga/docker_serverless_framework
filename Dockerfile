# Base image to be used
FROM ubuntu:20.04

# Environment Variables
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

# Input data
ARG NON_ROOT_USER=nroot
ARG SERVERLESS_VERSION=2.38.0
ARG NODEJS_VERSION=17

# Change to ROOT user to do maintenance/install tasks
USER root

# Working directory
WORKDIR /tmp

# Install packages
RUN apt-get update && apt-get install -y \
    python3.8 \
    python3-pip \
    git \ 
    wget \
    jq \
    curl \
    gnupg \
    bash

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash -
RUN apt-get -y install nodejs
RUN npm install -g serverless@${SERVERLESS_VERSION}
RUN npm i serverless-python-requirements

# Check versions
RUN node -v
RUN npm -v
RUN python3 -V
RUN serverless -v

# Cleanup
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

# Copy requirements.txt file to workdir
COPY requirements.txt /tmp/

# Install pip components from requirements.txt
RUN pip3 install -r requirements.txt

# Clean up tmp directory
RUN rm --recursive --force -- *

# Create a non-root user
RUN useradd --create-home --shell /bin/bash ${NON_ROOT_USER} && su - ${NON_ROOT_USER}

# Use non-root user
USER ${NON_ROOT_USER}

# Set workdir to user home
WORKDIR /home/${NON_ROOT_USER}

# Configure SSH client
RUN mkdir -p /home/${NON_ROOT_USER}/.ssh && \
    chmod 700 /home/${NON_ROOT_USER}/.ssh && \
    printf "Host *\\n\\tStrictHostKeyChecking no\\n\\n" > /home/${NON_ROOT_USER}/.ssh/config

# Command to execute
CMD ["bash"]
