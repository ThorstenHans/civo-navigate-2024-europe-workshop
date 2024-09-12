#!/bin/sh

set -euo pipefail
cd ..
kubectl apply -n demo -f ./kubernetes/ingress-livedemo2.yaml