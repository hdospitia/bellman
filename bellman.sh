#!/usr/bin/env bash

# Set script options
set -o pipefail
set -o nounset
set -o errexit
set -x

# Update APT sources and install Git package
sudo apt-get update
sudo apt install -y git-all curl build-essential

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
    awscli \
    pre-commit \
    gh \
    jandedobbeleer/oh-my-posh/oh-my-posh \
    tmux \
    vim \
    go \
    nvm

# Install Vim Vundle Plugin Manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Clone configurations repo
git clone https://github.com/hdospitia/configs.git ~/configs

# Put configurations
cp ~/configs/tmux.conf ~/.tmux.conf
cp ~/configs/vimrc ~/.vimrc

# Install Docker engine from convenience script
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sudo sh /tmp/get-docker.sh
sudo usermod -aG docker $USER

# Install NodeJS tools
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
# . ~/.nvm/nvm.sh
# nvm install --lts

# Enable Oh My Posh
echo 'eval "$(oh-my-posh init bash -c "https://raw.githubusercontent.com/hdospitia/configs/main/dani.omp.json")"' >> ~/.profile
. ~/.profile