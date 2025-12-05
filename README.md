### My Setup

- Docker (Version: 29.0.1)
- Helm (Version: 4.0.0)
- Minikube with Docker driver (Version: 1.37.0)

## Deployment evidance are in assets directory ##

## For minikube deployment

Step 1: Execute pipeline/minikube-init.sh

Step 2: Execute pipeline/deploy.sh

OR

Step 1: Execute "kubectl apply -f .\manifest\namespace.yaml"

Step 2: Execute "kubectl apply -f .\manifest --recursive"

## For helm-chart deployment

Step 1: Modify the helm/values.yaml

Step 2: Excecute "helm install '<deployment-name>' helm"

## To Destroy Everything

Step 1: Execute "kubectl delete -f .\manifest --recursive"

Step 2: Execute "helm uninstall '<deployment-name>'"