#Start minikube
minikube start --profile dc1 --memory 4096 --driver=docker 
# wait a bit 

#check minikube status 
minikube status

#check nodes to ensure kubectl is configured to the correct context 
kubectl get nodes


#install consul-k8s via CLI


#    Install the HashiCorp tap, which is a repository of all Homebrew packages for HashiCorp:

    brew tap hashicorp/tap

#    Install the Consul K8s CLI with hashicorp/tap/consul formula.

    brew install hashicorp/tap/consul-k8s

#    Issue the install subcommand to install Consul on Kubernetes:

    consul-k8s install 

