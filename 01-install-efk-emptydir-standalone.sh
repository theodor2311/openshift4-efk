#!/bin/bash
CURRENT_DIR=$(dirname ${0})

echo 'Waiting for opertaors...'

for operator in elasticsearch-operator cluster-logging;do
while [[ $(oc get csv $(oc get packagemanifest $operator -n openshift-marketplace -o jsonpath='{.status.channels[].currentCSV}') -o jsonpath='{.status.reason}' 2>/dev/null) != 'Copied' ]];do
  sleep 1
done
echo $operator installed
done


oc create -f - << EOF
apiVersion: "logging.openshift.io/v1"
kind: "ClusterLogging"
metadata:
  name: "instance"
  namespace: "openshift-logging"
spec:
  managementState: "Managed"
  logStore:
    type: "elasticsearch"
    elasticsearch:
      nodeCount: 1
      resources:
        requests:
          memory: 4Gi
      storage: {}
      redundancyPolicy: "ZeroRedundancy"
  visualization:
    type: "kibana"
    kibana:
      replicas: 1
  curation:
    type: "curator"
    curator:
      schedule: "30 3 * * *"
  collection:
    logs:
      type: "fluentd"
      fluentd: {}
EOF


