#!/bin/bash
sudo apt-get update
# Configure microk8s
sudo snap install microk8s --classic
microk8s.status
# Create fortify user
sudo groupadd -r fortify && sudo useradd -m -r -g fortify fortify && sudo usermod -aG sudo fortify
sudo usermod -a -G microk8s fortify
