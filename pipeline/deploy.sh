#!/bin/bash
#
# This is a file that can run in a build server and will to the following task
#

kubectl create namespace production
kubectl create configmap mysql-seed --from-file=seed.sql=./seed/seed.sql -n production
kubectl create secret generic mysql-secret --from-literal=MYSQL_ROOT_PASSWORD=rootpassword --from-literal=MYSQL_DATABASE=targets --from-literal=MYSQL_USER=targets --from-literal=MYSQL_PASSWORD=password -n production


set -euo pipefail

NAMESPACE="production"
CONFIGMAP_NAME="mysql-seed"
SECRET_NAME="mysql-secret"

echo "Ensuring namespace ${NAMESPACE} exists..."
if ! kubectl get namespace "${NAMESPACE}" >/dev/null 2>&1; then
  kubectl create namespace "${NAMESPACE}"
fi

echo "Ensuring ConfigMap ${CONFIGMAP_NAME} exists..."
if ! kubectl get configmap "${CONFIGMAP_NAME}" -n "${NAMESPACE}" >/dev/null 2>&1; then
  kubectl create configmap "${CONFIGMAP_NAME}" \
    --from-file=seed.sql=./seed/seed.sql \
    -n "${NAMESPACE}"
fi

echo "Ensuring Secret ${SECRET_NAME} exists..."
if ! kubectl get secret "${SECRET_NAME}" -n "${NAMESPACE}" >/dev/null 2>&1; then
  kubectl create secret generic "${SECRET_NAME}" \
    --from-literal=MYSQL_ROOT_PASSWORD=rootpassword \
    --from-literal=MYSQL_DATABASE=targets \
    --from-literal=MYSQL_USER=targets \
    --from-literal=MYSQL_PASSWORD=password \
    -n "${NAMESPACE}"
fi

echo "Done."

echo "Buildin the image"

docker build -t web:latest .

echo "Pushing image to minikube"

minikube image load web:latest

echo "Deploying to minikube"

kubectl apply -f .\manifest\mysql.yaml
kubectl apply -f .\manifest\web.yaml