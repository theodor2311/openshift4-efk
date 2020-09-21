#!/bin/bash
set -euoE pipefail
if [[ $# -eq 0 ]] ; then
    echo 'Usage: ./es_util --query=<QUERY>'
    exit 0
fi

readonly ELASTICSEARCH_INSTANCE=$(oc get pods -lcomponent=elasticsearch -n openshift-logging -o jsonpath='{.items[0].metadata.name}')
[[ -z "${ELASTICSEARCH_INSTANCE}" ]] && echo 'Elasticsearch instance not found' && exit 1
oc project openshift-logging >/dev/null
oc exec "${ELASTICSEARCH_INSTANCE}" -c elasticsearch -- es_util $@
