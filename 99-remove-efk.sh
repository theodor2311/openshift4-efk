#!/bin/bash
oc delete sub -n openshift-logging cluster-logging
oc delete sub -n openshift-operators elasticsearch-operator
oc delete project openshift-logging
