#!/bin/bash
#
# This is a file that can run in a build server and will to the following task
#
echo "Building the image"

docker build -t web:latest .

echo "Pushing image to minikube"

minikube image load web:latest

echo "Deploying to minikube"

kubectl apply -f .\manifest\namespace.yaml
kubectl apply -f .\manifest --recursive