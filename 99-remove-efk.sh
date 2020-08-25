#!/bin/bash
oc delete clusterlogging instance -n openshift-logging
oc delete sub -n openshift-logging cluster-logging
oc delete sub -n openshift-operators elasticsearch-operator
oc delete project openshift-logging
oc delete project openshift-operators-redhat
oc delete rolebindings prometheus-k8s -n openshift-operators-redhat
oc delete role prometheus-k8s -n openshift-operators-redhat
