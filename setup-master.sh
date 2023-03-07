#!/bin/bash
# Create fortify user
groupadd -r fortify && useradd -m -r -g fortify fortify && usermod -aG sudo fortify
sudo su - fortify
# Configure self-signed certificates
sudo openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout /etc/ssl/private/master.key -out /etc/ssl/certs/master.pem -subj "/C=CA/ST=ON/L=Toronto/O=FortifyLab/OU=IT/CN=*.fortify.lab/emailAddress=fortify@fortify.lab"
sudo apt-get update
sudo apt-get install -y vim git openjdk-11-jdk dos2unix apt-transport-https net-tools network-manager haproxy
# Configure microk8s
sudo snap install microk8s --classic
sudo usermod -a -G microk8s fortify
microk8s.enable community
microk8s.enable hostpath-storage
microk8s.enable metallb:192.168.35.10-192.168.35.49
microk8s.enable ingress
microk8s.enable dns
microk8s.enable helm3
microk8s.enable rbac
microk8s.enable registry
microk8s.enable traefik
# Patch kubeconfig
microk8s.kubectl get nodes -o wide
microk8s.config > ~/.kube/config
sudo chmod 600 ~/.kube/config
# Configure helm
sudo snap install helm --classic
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add fortify https://fortify.github.io/helm3-charts
helm repo update
