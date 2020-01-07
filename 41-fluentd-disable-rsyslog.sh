#!/bin/bash
if [ -z $LOG_PRJ ]; then LOG_PRJ=openshift-logging; fi
oc set env ds/fluentd -c='*' USE_REMOTE_SYSLOG- REMOTE_SYSLOG_HOST- -n ${LOG_PRJ}
