#create ingress gateway
kubectl apply -f ./code/gateways/ingress_gateway.yaml

# check ingress gateway(it should fail Synced: Fail)
kubectl get ingressgateway ingress-gateway -n consul

#see why it failed
kubectl describe ingressgateway ingress-gateway -n consul

#apply proxy default to make all services http instead of tcp
kubectl apply -f ./code/gateways/proxy_defaults.yaml

#check to see if it was applied
kubectl get proxydefaults global -n consul

#and if we now check the gateway, we see it was synced(Sync: True)
kubectl get ingressgateway ingress-gateway -n consul

#try accessing via ingress gateway (IF NEEDED)
# kubectl port-forward service/consul-ingress-gateway -n consul 8080

