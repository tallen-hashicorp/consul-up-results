#create grafana username password as k8s secret
kubectl create secret generic grafana-admin \
      --from-literal=admin-user=admin \
      --from-literal=admin-password=admin

#install grafana from helm chart
helm install grafana grafana \
      --repo https://grafana.github.io/helm-charts \
      --set 'service.type=LoadBalancer' \
      --set 'service.port=3000' \
      --set 'persistence.enabled=true' \
      --set 'rbac.pspEnabled=false' \
      --set 'admin.existingSecret=grafana-admin' \
      --wait


#Queries
#create 1 dashboard and then create one panel for each query
#in the panel paste this in the prometheus code bit
 ## Example 7-5: rps.promql
sum(
  rate(
    envoy_http_downstream_rq_completed{
      consul_source_service="$Service",
      envoy_http_conn_manager_prefix="public_listener"
    }[$__rate_interval]
  )
)

 ## Example 7-6: error-percentage.promql
sum(
  rate(
    envoy_http_downstream_rq_xx{
      consul_source_service="$Service",
      envoy_http_conn_manager_prefix=~"public_listener|ingress_upstream_8080",
      envoy_response_code_class="5"
    }[$__rate_interval]
  )
) /
sum(
  rate(
    envoy_http_downstream_rq_completed{
      consul_source_service="$Service",
      envoy_http_conn_manager_prefix=~"public_listener|ingress_upstream_8080"
    }[$__rate_interval]
  )
)

## Example 7-7: latency-50.promql
histogram_quantile(
  0.5,
  sum(
    rate(
      envoy_http_downstream_rq_time_bucket{
        consul_source_service="$Service",
        envoy_http_conn_manager_prefix=~"public_listener|ingress_upstream_8080"
      }[$__rate_interval]
    )
  ) by (le)
)

## Example 7-8: latency-99.promql
histogram_quantile(
  0.99,
  sum(
    rate(
      envoy_http_downstream_rq_time_bucket{
        consul_source_service="$Service",
        envoy_http_conn_manager_prefix=~"public_listener|ingress_upstream_8080"
      }[$__rate_interval]
    )
  ) by (le)
)
