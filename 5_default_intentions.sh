#apply default deny intention
kubectl apply -f ./code/intentions/deny_all_service_intentions.yaml

#apply allow between frontend and ingress-gateway
kubectl apply -f ./code/intentions/frontend_service_intentions.yaml

#apply allow between backend and frontend
kubectl apply -f ./code/intentions/backend_service_intentions.yaml