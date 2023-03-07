#!/bin/bash
alias k8s='microk8s'
alias k8sconfig='microk8s.config'
alias k8senable='microk8s.enable'
alias k8sdisable='microk8s.disable'
alias k8status='microk8s.status'
alias kubectl='microk8s.kubectl'
alias k='kubectl'
alias ka='kubectl apply -f'
alias kc='kubectl create'
alias kcd='kubectl create deployment'
alias kci='kubectl create ingress'
alias kcs='kubectl create secret'
alias kd='kubectl describe'
alias kdi='kubectl describe ingress'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias ke='kubectl expose'
alias kg='kubectl get'
alias kgi='kubectl get ingress'
alias kgp='kubectl get pod'
alias kgs='kubectl get service'
alias kinfo='kubectl cluster-info'
alias kl='kubectl get all'
alias kla='kubectl get all --all-namespaces -o wide'
alias kll='kubectl get all --all-namespaces'
alias kn='kubectl get nodes'
alias kns='kubectl get namespaces'
alias kp='kubectl get pods'
alias krm='kubectl delete'
alias krmi='kubectl delete ingress'
alias krmp='kubectl delete pod'
alias krms='kubectl delete service'
alias krmns='kubectl delete namespace'
alias ks='kubectl get services'
source <(kubectl completion bash) # set up autocomplete in bash
complete -o default -F __start_kubectl k