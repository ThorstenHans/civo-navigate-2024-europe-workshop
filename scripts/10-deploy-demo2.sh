#!/bin/sh

set -euo pipefail


export VALKEY_PASSWORD=$(kubectl get secret --namespace valkey valkey -o jsonpath="{.data.valkey-password}" | base64 -d)
kubectl create secret generic -n demo civokv --from-literal=valkey-url="redis://:${VALKEY_PASSWORD}@valkey-master.valkey.svc.cluster.local:6379"


cd ..
cd civo-livedemo2

echo "Creating and Pushing OCI artifact"
spin registry push ttl.sh/civo-livedemo2:24h --build

cd ..
echo "Deploying to Civo"
kubectl apply -n demo -f ./kubernetes/livedemo2.yaml