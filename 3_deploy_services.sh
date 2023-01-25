#deploy backend
kubectl apply -f ./code/backend/

#deploy frontend
kubectl apply -f ./code/frontend/

#test frontend service (it should fail)
kubectl exec consul-server-0 -n consul --curl -sS http://frontend.default:6600

#test backend service (it should work)
kubectl exec deploy/frontend -c frontend -- curl -si http://backend/bird