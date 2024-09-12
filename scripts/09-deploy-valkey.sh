#!/bin/sh

set -euo pipefail

helm install valkey --namespace valkey --create-namespace oci://registry-1.docker.io/bitnamicharts/valkey  