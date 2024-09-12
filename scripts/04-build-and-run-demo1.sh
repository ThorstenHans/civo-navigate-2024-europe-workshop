#!/bin/sh

set -euo pipefail


# Build the Spin App
cd .. 
cd civo-livedemo1
spin build

# Run the App
spin up