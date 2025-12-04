#!/bin/bash
minikube start --driver=docker
minikube addons enable metrics-server
minikube addons enable ingress
minikube dashboard &
minikube tunnel &
