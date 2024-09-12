#!/bin/sh

set -euo pipefail

# Provision Kubernetes cluster
civo k8s create livedemo -n 1 -s g4p.kube.small --cluster-type talos --save -w
