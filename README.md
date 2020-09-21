# openshift-efk

Tested on OpenShift 4.5.8, Elasticsearch Operator 4.5.0-202008310950.p0

# How to use

Use ./00-deploy-efk-operators.sh to install required operators and projects  
Deploy your own logging instance CRD, you may reference the samples in ./samples

# ES_QUERY

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

# ES_UTIL

Executing the es_util script on the Elasticsearch container.
