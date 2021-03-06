#!/bin/bash
# Update and Install More Packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget unzip curl

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
mkdir -p ~/.local/bin/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
mv ./kubectl ~/.local/bin/kubectl
kubectl version --client

# Install Docker
curl https://get.docker.com | sudo bash
sudo groupadd docker
sudo usermod -aG docker jenkins
sudo su - jenkins
newgrp docker
#sudo systemctl restart jenkins.service  #restarting jenkins service 

# Install Docker-Compose
sudo apt update
sudo apt install -y curl jq
version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Terraform
sudo apt update && sudo apt upgrade -y
sudo apt install -y unzip wget

wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip
unzip terraform_*_linux_*.zip

sudo mv terraform /usr/local/bin/
rm terraform_*_linux_*.zip