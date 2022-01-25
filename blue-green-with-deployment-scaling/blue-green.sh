#!/bin/bash


echo "apply new version to green version"
kubectl apply -f sample-deployment-helloworld-green.yaml
kubectl rollout status deployment/helloworld-deployment-green
sleep 2
for i in {1..10}; do curl http://localhost:12345; done;

echo "enable piloting"
./scale-green.sh 50
kubectl rollout status deployment/helloworld-deployment-green
sleep 2
for i in {1..10}; do curl http://localhost:12345; done;

echo "switch to the new version"
online_replica_number=$(kubectl get deployment  helloworld-deployment -ojsonpath='{.status.availableReplicas}')
cat sample-deployment-helloworld-green.yaml | sed -e "s/-green//g" | kubectl apply -f -
kubectl rollout status deployment/helloworld-deployment
kubectl scale deployment helloworld-deployment --replicas $online_replica_number
sleep 2
for i in {1..10}; do curl http://localhost:12345; done;

echo "disable green"
kubectl scale deployment helloworld-deployment-green --replicas 0
sleep 5
for i in {1..10}; do curl http://localhost:12345; done;

