#! /bin/bash

kubectl apply -f 3.yaml

kubectl wait --for=condition=Ready pod/nginx

kubectl exec -it nginx env

kubectl delete -f 3.yaml
