#!/bin/bash
if [ -z $LOG_PRJ ]; then LOG_PRJ=openshift-logging; fi
oc patch clusterloggings.logging.openshift.io/instance -p '{"spec":{"managementState":"Managed"}}' --type=merge -n ${LOG_PRJ}
