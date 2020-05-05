#!/bin/bash
if [ -z "${LOG_PRJ}" ]; then LOG_PRJ=openshift-logging; fi
if [ -z "${ES_PRJ}" ]; then ES_PRJ=openshift-operators; fi
TMP_FILE=/dev/shm/20-check-efk-status

rm -f ${TMP_FILE}

( LOG_NS=$(oc get project "${LOG_PRJ}" -o jsonpath='{.metadata.name}' 2>/dev/null);if [ -z "${LOG_NS}" ]; then LOG_NS="\e[31mNot found";fi;echo "LOG_NS=\"${LOG_NS}\"" >> "${TMP_FILE}" ) &
( ES_NS=$(oc get project "${ES_PRJ}" -o jsonpath='{.metadata.name}' 2>/dev/null);if [ -z "${ES_NS}" ]; then ES_NS="\e[31mNot found";fi;echo "ES_NS=\"${ES_NS}\"" >> "${TMP_FILE}" ) &


#Checking CRDs...
( ES_CRD=$(oc get elasticsearches.logging.openshift.io -A -o jsonpath='{.items[*].metadata.name} ({.items[*].metadata.namespace})' 2>/dev/null)

if [ ${ES_CRD} == "()" ]; then
  if ! oc get crd/elasticsearches.logging.openshift.io >/dev/null 2>&1; then
    ES_CRD="\e[31mCRD not found"
  else
    ES_CRD="\e[33mNo instance found"
  fi
fi
echo "ES_CRD=\"${ES_CRD}\"" >> "${TMP_FILE}") &

( LOG_CRD=$(oc get clusterloggings.logging.openshift.io -A -o jsonpath='{.items[*].metadata.name} ({.items[*].metadata.namespace})' 2>/dev/null)

if [ ${LOG_CRD} == "()" ]; then
  if ! oc get crd/clusterloggings.logging.openshift.io >/dev/null 2>&1; then
    LOG_CRD="\e[31mCRD not found"
  else
    LOG_CRD="\e[33mNo instance found"
  fi
fi
echo "LOG_CRD=\"${LOG_CRD}\"" >> "${TMP_FILE}") &

# #Checking Operator Groups...
( LOG_OG=$(oc get OperatorGroup -n ${LOG_PRJ} -o jsonpath='{.items[*].metadata.name}' 2>/dev/null)
if [ -z "${LOG_OG}" ]; then LOG_OG="\e[31mNot found"; fi
echo "LOG_OG=\"${LOG_OG}\"" >> "${TMP_FILE}") &

( ES_OG=$(oc get OperatorGroup -n ${ES_PRJ} -o jsonpath='{.items[*].metadata.name}' 2>/dev/null)
if [ -z "${ES_OG}" ]; then ES_OG="\e[31mNot found"; fi
echo "ES_OG=\"${ES_OG}\"" >> "${TMP_FILE}") &

#Checking Subscriptions...
( LOG_SUB=$(oc get Subscription -n ${LOG_PRJ} -o jsonpath='{.items[*].status.installedCSV}' 2>/dev/null)
if [ -z "${LOG_SUB}" ]; then LOG_SUB="\e[31mNot found"; fi
echo "LOG_SUB=\"${LOG_SUB}\"" >> "${TMP_FILE}") &

( ES_SUB=$(oc get Subscription -n ${ES_PRJ} -o jsonpath='{.items[*].status.installedCSV}' 2>/dev/null)
if [ -z "${ES_SUB}" ]; then ES_SUB="\e[31mNot found"; fi
echo "ES_SUB=\"${ES_SUB}\"" >> "${TMP_FILE}") &

#Checking ManagementState
( ES_MS=$(oc get clusterloggings.logging.openshift.io/instance -n ${LOG_PRJ} -o jsonpath='{.spec.managementState}' 2>/dev/null)
if [ -z "${ES_MS}" ]; then ES_MS="\e[31mNot found"; fi
if [ ${ES_MS} == "Unmanaged" ];then ES_MS="\e[33m${ES_MS}";fi
echo "ES_MS=\"${ES_MS}\"" >> "${TMP_FILE}") &



wait
source "${TMP_FILE}"
#cat ${TMP_FILE}
echo "---"
echo "Elasticsearch"
echo -e "Namespace: \e[32m${ES_NS}\e[0m"
echo -e "Instance: \e[32m${ES_CRD}\e[0m"
echo -e "managementState: \e[32m${ES_MS}\e[0m"
echo -e "OperatorGroup: \e[32m${ES_OG}\e[0m"
echo -e "Subscription: \e[32m${ES_SUB}\e[0m"
echo "---"
echo "Clusterloggings"
echo -e "Namespace: \e[32m${LOG_NS}\e[0m"
echo -e "Instance: \e[32m${LOG_CRD}\e[0m"
echo -e "OperatorGroup: \e[32m${LOG_OG}\e[0m"
echo -e "Subscription: \e[32m${LOG_SUB}\e[0m"
rm -f "${TMP_FILE}"
