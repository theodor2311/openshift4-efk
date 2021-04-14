# Handly scripts for managing EFK stack on OpenShift4

Tested on OpenShift 4.7.5 cluster-logging.5.0.2-18 elasticsearch-operator.5.0.1-23

## Deploy EFK stack on OpenShift

Use ./00-deploy-efk-operators.sh to install required operators and projects  
Deploy your own logging instance CRD, you may reference the samples in ./samples

## ES_QUERY

Wrapping the CURL command allowing you to directly query the Elasticsearch cluster without caring for the authentication, it will be executed on the Elasticsearch container directly so you can use localhost for the URL.
```bash
./es_query https://localhost:9200/_cluster/health?pretty=true

{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 3,
  "number_of_data_nodes" : 3,
  "active_primary_shards" : 20,
  "active_shards" : 58,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
```

## ES_UTIL

Executing the es_util script on the Elasticsearch container.
```bash
./es_util --query=_cat/indices?v=true
health status index                  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .security              NYkOmvlGQFOTkiER3beO_A   1   1          5            0     59.9kb         29.9kb
green  open   .kibana_92668751_admin l62ISpSkS-e_tgDfBxzSpQ   1   2          2            0     65.1kb         22.7kb
green  open   infra-000001           WR3aamzyQCyssUrVHtOh-w   3   2   22323257            0     39.4gb         12.8gb
green  open   app-000001             KlbS0gz1SPGKxGQA4h305Q   3   2     291191            0    543.5mb        181.1mb
green  open   audit-000001           vX9422gBQtKOWB-kuUgOnQ   3   2          0            0      2.2kb           783b
green  open   .kibana_1              ILT3KehSQp27wnDmweEo6g   1   1          1            0      7.4kb          3.7kb
```
