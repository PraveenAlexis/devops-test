#!/bin/bash
#
# This is a file that can run in a build server and will to the following task
#
kubectl create namespace production
kubectl create configmap mysql-seed \
  --from-file=seed.sql=./seed/seed.sql \
  -n production
kubectl create secret generic mysql-secret \
  --from-literal=MYSQL_ROOT_PASSWORD=rootpassword \
  --from-literal=MYSQL_DATABASE=targets \
  --from-literal=MYSQL_USER=targets \
  --from-literal=MYSQL_PASSWORD=password \
  -n production

minikube addons enable ingress
minikube tunnel

echo "Buildin the image"

docker build -t web:latest .
minikube image load web:latest

echo "Pushing image to docker registry"