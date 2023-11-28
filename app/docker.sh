#!/usr/bin/env bash

## Set environment
distro=$(lsb_release -is | tr '[:upper:]' '[:lower:]')

## Remove old Docker version
apt-get remove docker docker-engine docker.io containerd runc || true

## Update and install basic dependencies
apt-get update
apt-get install -y ca-certificates curl gnupg

## Create keyrings
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL "https://download.docker.com/linux/${distro}/gpg" | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

## Setup the repository
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${distro} \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Update and install Docker
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Test Hello World
docker run hello-world
