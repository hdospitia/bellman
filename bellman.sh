#!/usr/bin/env bash

# Set script options
set -o pipefail
set -o nounset
set -o errexit

# Update APT sources and install Git package
sudo apt-get update
sudo apt install -y git-all curl build-essential

# Install Docker engine from convenience script
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sudo sh /tmp/get-docker.sh

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Add Brew to the PATH
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# Add Homebrew Taps
brew tap hashicorp/tap
brew tap aws/tap
brew tap weaveworks/tap

# Install utilities from Homebrew
brew install \
    gcc \
    kubectl \
    kind \
    minikube \
    terragrunt \
    hashicorp/tap/terraform \
    hashicorp/tap/vagrant \
    hashicorp/tap/packer \
    aws/tap/aws-sam-cli \
    awscli \
    pre-commit \
    gh \
    jandedobbeleer/oh-my-posh/oh-my-posh \
    tmux \
    vim \
    go

# Clone configurations repo
git clone https://github.com/hdospitia/configs.git ~/configs

# Put configurations
cp ~/configs/tmux.conf ~/.tmux.conf
cp ~/configs/vimrc ~/.vimrc
cp ~/configs/dani.omp.json ~/.dani.omp.json