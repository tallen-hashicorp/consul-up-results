echo -n 'my-string' | base64

kubectl create secret generic consul-lic  --from-file=license=/Users/$(whoami)/Hashicorp/consul.hclic
