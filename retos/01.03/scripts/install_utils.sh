#!/usr/bin/env bash

# Install utils
function install_utils() {
    sudo apt-get update
    sudo apt-get install -y \
        curl \
        wget \
        git \
        vim \
        htop \
        tree \
        unzip \
        zip \
        jq
}

function install_nginx() {
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
}

function install_docker() {
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
}

function install_kubectl() {
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    echo "export PATH=\$PATH:/usr/local/bin" >> ~/.bashrc
    kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
}

# Call the functions to install utilities
install_utils
install_nginx
install_docker
install_kubectl

