#! /bin/bash

kubectl create configmap keyvalcfgmap --from-env-file=config.txt

# verify 
kubectl get cm keyvalcfgmap -o yaml
