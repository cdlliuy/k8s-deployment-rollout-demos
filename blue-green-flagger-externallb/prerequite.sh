#!/bin/bash

helm repo add flagger https://flagger.app

kubectl create ns flagger

#the prometheus svc url in monitoring ns
helm upgrade -i flagger flagger/flagger \
--namespace flagger \
--version 1.14.0 \
--set meshProvider=kubernetes \
--set metricsServer=http://prometheus-kube-prometheus-prometheus.monitoring:9090  


helm upgrade -i flagger-loadtester flagger/loadtester \
--namespace=test \
--set cmd.timeout=1h

#helm uninstall flagger --namespace flagger
#helm uninstall flagger-loadtester --namespace test

