#!/bin/bash
# Create fortify user
groupadd -r fortify && useradd -m -r -g fortify fortify && usermod -aG sudo fortify
sudo su - fortify
# Configure microk8s
sudo snap install microk8s --classic
sudo usermod -a -G microk8s fortify