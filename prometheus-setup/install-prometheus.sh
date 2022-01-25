kubectl create namespace monitoring
helm install prometheus prometheus-community/kube-prometheus-stack -f ./prometheus-helm-value-nopv.yaml
kubectl -n monitoring get pvc
kubectl -n monitoring get pods
kubectl -n monitoring get svc
