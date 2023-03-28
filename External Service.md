# Adding an external service
![Diagram](./docs/Consul%20External%20Service.png)

### Prerequisites
* Ensure a consul licence file is located at home/Hashicorp/consul.hclic

### Setup
To setup the Consul service mesh run the following:

* 1_consul_ent_license_secret.sh
* 2_install_consul.sh
* 3_deploy_services.sh
* 4_deploy_gateways.sh
* 5_default_intentions.sh

Or if your feeling lazy use this
```bash
sh 1_consul_ent_license_secret.sh && sh 2_install_consul.sh && sh 3_deploy_services.sh && sh 4_deploy_gateways.sh && sh 5_default_intentions.sh
```

### External Service

First register the external service with with following
```bash
curl --request PUT --data @code/external-vault/external-vault-service.json localhost:8500/v1/catalog/register
```

Next update the terminating gateway to use the new external service and add a intention to allow guy to access the external-vault service
```bash
kubectl apply -f ./code/gateways/terminating_gateway.yaml
kubectl apply -f ./code/intentions/external-vault_intentions.yaml 
```

Now update the ingress gateway to use the external serivce if you have not already
```bash
kubectl apply -f ./code/intentions/external-vault_intentions.yaml 
```

### Testing is works
```bash
curl -vvvs http://vault.localhost:8080/
```

### Testing it works
```bash
kubectl exec deployments/frontend -- curl -vvvs --header "Host: do-not-delete-ever.vault.92607e45-319d-44bd-9879-284b72f492b8.aws.hashicorp.cloud" http://localhost:1234/
```

### Gotchas
* Ensure you dont use https:// or http:// in any urls
* Ensure your terminating gatway matches the URL in the external service
* Ensure your terminating gateway was `caFile: "/etc/ssl/certs/ca-certificates.crt"`

### Add envoy debug logging
```bash
kubectl exec deployments/frontend -- curl -X POST  http://localhost:19000/logging?level=debug
```

### Reading guy deployment envoy logs
```bah
kubectl logs -f  deployments/guy consul-dataplane
```
