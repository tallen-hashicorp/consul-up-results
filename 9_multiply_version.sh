#deploy splitter
kubectl apply -f ./code/backend/backend-service-splitter.yaml

#deploy v2
kubectl apply -f ./code/backend/backend-v2-deployment.yaml

#deploy resolver
kubectl apply -f ./code/backend/backend-service-resolver.yaml

#update router if needed
kubectl apply -f ./code/backend/backend-service-router.yaml