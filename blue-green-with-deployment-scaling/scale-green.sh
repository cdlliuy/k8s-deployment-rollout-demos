#!/bin/bash

piloting=$1
if [ -z "$piloting" ]; then
   piloting=0
fi 
online_replica_number=$(kubectl get deployment  helloworld-deployment -ojsonpath='{.status.availableReplicas}')
green_replica_number=$((online_replica_number*2*piloting/100))
kubectl scale deployment helloworld-deployment-green --replicas $green_replica_number
