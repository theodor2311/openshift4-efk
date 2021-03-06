#!/bin/bash
set -euoE pipefail
readonly ELASTICSEARCH_INSTANCE=$(oc get pods -lcomponent=elasticsearch -n openshift-logging -o jsonpath='{.items[0].metadata.name}')
[[ -z "${ELASTICSEARCH_INSTANCE}" ]] && echo 'Elasticsearch instance not found' && exit 1
echo 'Changing project to openshift-logging Project...'
oc project openshift-logging
oc exec "${ELASTICSEARCH_INSTANCE}" -c elasticsearch -- es_util --query=_cluster/settings?pretty=true
