#install consul using our helm values
#you may need to uninstall consul if consul-k8s installed one : consul uninstall 
consul-k8s install -config-file ./code/consul/consul_install_values.yaml

#check consul installation
consul-k8s status

