#!/bin/bash

piloting=$1
if [ -z "$piloting" ]; then
   piloting=0
fi 
online=$((100-$piloting))
kubectl patch trafficsplit helloworld-rollout --type "json" -p "[{\"op\":\"replace\",\"path\":\"/spec/backends/0/weight\",\"value\":$online},{\"op\":\"replace\",\"path\":\"/spec/backends/1/weight\",\"value\":$piloting}]"

sleep 5
for i in {1..10}; do curl http://localhost/helloworld; done;