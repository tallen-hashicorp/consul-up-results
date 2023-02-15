# Register Service
curl --request PUT --data @code/external-vault/external-vault-service.json localhost:8500/v1/catalog/register

# Check Service
curl localhost:8500/v1/catalog/service/external-vault

# Deploy Terminating gateway
kubectl apply -f ./code/gateways/terminating_gateway.yaml

# Add external vault intentions for guy
kubectl apply -f ./code/intentions/external-vault_intentions.yaml 

## Test
kubectl exec deployments/guy -- curl -vvvs --header "Host: do-not-delete-ever.vault.92607e45-319d-44bd-9879-284b72f492b8.aws.hashicorp.cloud" http://localhost:1234/
curl -vvvs http://vault.localhost:8080/ 