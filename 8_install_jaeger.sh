
helm repo add jetstack https://charts.jetstack.io

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace 
  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml


kubectl apply -f ./code/jaeger/jaeger_role.yaml
kubectl create namespace observability
kubectl create -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.41.0/jaeger-operator.yaml -n observability


kubectl apply -f ./code/jaeger/jaeger.yaml


#restart deployments if needed
kubectl rollout restart deploy/consul-ingress-gateway -n consul
kubectl rollout restart deploy/frontend
kubectl rollout restart deploy/backend