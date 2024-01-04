#!/bin/bash
#installing the argocd services inside the cluster
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#installing the argo-cd CLI with curl
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

#Change the argocd-server service type to LoadBalancer
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

#extracting the argo cd user password
# Using command substitution to capture the output
password=$(argocd admin initial-password -n argocd)
echo "Initial Argo CD admin password: $password"

#port-forwarding to open the UI
kubectl port-forward svc/argocd-server -n argocd 8080:443

