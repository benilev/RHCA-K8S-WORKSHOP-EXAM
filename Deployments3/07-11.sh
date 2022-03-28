#! /bin/bash

WEBAPP_DEPLOY="webapp"

7) 
kubectl set image deployments/$WEBAPP_DEPLOY nginx=nginx:1.17.4

# verify
deploy_image=$(kubectl describe deployment $WEBAPP_DEPLOY | grep Image:)
echo "$WEBAPP_DEPLOY currently using $deploy_image"

8)
kubectl rollout history deploy $WEBAPP_DEPLOY
kubectl get deploy,pods

9)
kubectl rollout undo deployments/$WEBAPP_DEPLOY

#  verify
deploy_image=$(kubectl describe deployment $WEBAPP_DEPLOY | grep Image:)
echo "$WEBAPP_DEPLOY currently using $deploy_image"

10)
kubectl set image deployments/$WEBAPP_DEPLOY nginx=nginx:1.100

# verify
deploy_image=$(kubectl describe deployment $WEBAPP_DEPLOY | grep Image:)
echo "$WEBAPP_DEPLOY currently using $deploy_image"

# however
kubectl get deploy,pods 
kubectl get deploy,pods | grep ImagePullBackOff

10B)
kubectl rollout undo deployments/$WEBAPP_DEPLOY

#  verify
deploy_image=$(kubectl describe deployment $WEBAPP_DEPLOY | grep Image:)
echo "$WEBAPP_DEPLOY currently using $deploy_image"
kubectl get deploy,pods

10C/D)
kubectl rollout history deploy webapp --revision=5

10E)
kubectl set image deployments/$WEBAPP_DEPLOY nginx=nginx

kubectl rollout history deploy $WEBAPP_DEPLOY

# verify 
kubectl get deploy,pods
deploy_image=$(kubectl describe deployment $WEBAPP_DEPLOY | grep Image:)
echo "$WEBAPP_DEPLOY currently using $deploy_image"

11)
kubectl autoscale deploy webapp --min=10 --max=20 --cpu-percent=85 

# verify
kubectl get hpa

# replicas
watch -d -n 0.5 "kubectl get pod -l app=webapp"

12)
kubectl delete deploy webapp
kubectl delete hpa webapp
