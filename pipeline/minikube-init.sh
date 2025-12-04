#!/bin/bash
minikube start --driver=docker
minikube addons enable metrics-server
minikube addons enable ingress
minikube dashboard &
minikube tunnel &

# make sure target.praveenalexis.com is added to your /etc/hosts file pointing to 127.0.0.1 because minikube tunnel will route traffic from there to the minikube cluster
##   127.0.0.1     target.praveenalexis.com