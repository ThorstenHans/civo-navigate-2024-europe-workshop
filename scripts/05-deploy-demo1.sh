#!/bin/sh

set -euo pipefail

cd ..
cd civo-livedemo1

echo "Creating and Pushing OCI artifact"
spin registry push ttl.sh/civo-livedemo1:24h --build

cd ..
echo "Deploying to Civo"
kubectl apply -n demo -f ./kubernetes/livedemo1.yaml