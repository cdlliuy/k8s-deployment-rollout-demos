#!/bin/bash


echo "apply new version to green version"
kubectl apply -f sample-deployment-helloworld-green.yaml
kubectl rollout status deployment/helloworld-deployment-green
sleep 2
for i in {1..10}; do curl http://localhost/helloworld; done;

echo "enable piloting"
./route-to-green.sh 50

echo "switch to the new version"
cat sample-deployment-helloworld-green.yaml | sed -e "s/-green//g" | kubectl apply -f -
kubectl rollout status deployment/helloworld-deployment
sleep 2
for i in {1..10}; do curl http://localhost/helloworld; done;

echo "disable green"
./route-to-green.sh 0
kubectl scale deployment helloworld-deployment-green --replicas 0
sleep 2
for i in {1..10}; do curl http://localhost/helloworld; done;

