#! /bin/bash

kubectl get nodes -o=custom-columns=NAME:.metadata.name,TAINTS:.spec.taints

kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl apply -f 08.yaml

kubectl get pods -owide
