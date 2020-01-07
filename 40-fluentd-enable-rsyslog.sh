#!/bin/bash
if [ -z ${LOG_PRJ} ]; then LOG_PRJ=openshift-logging; fi
echo "Input RSYSLOG_HOST:"
read RSYSLOG_HOST
oc set env ds/fluentd -c='*' USE_REMOTE_SYSLOG="true" REMOTE_SYSLOG_HOST=${RSYSLOG_HOST} -n ${LOG_PRJ}
