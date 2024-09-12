# Civo Navigate Europe 2024 - Bring WebAssembly to Civo Kubernetes Workshop


This repository contains all samples shown as part of the **Bring WebAssembly to Civo Kubernetes with SpinKube** workshop.

## Prerequisites

- Create an account at civo.com
- Install `civo` CLI
- Install `spin` CLI and Rust (with target `wasm32-wasi`)
- Authenticate `civo` CLI with your civo.com account
- Install `kubectl` and `helm`
- Install `jq`
- Install `curl`

## Flow

1. Deploy a Civo Kubernetes using [`./scripts/01-deploy-k8s.sh`](./scripts/01-deploy-k8s.sh)
2. Deploy [cert-manager](https://cert-manager.io) [`./scripts/02-deploy-cert-manager.sh`](./scripts/02-deploy-cert-manager.sh)
3. Deploy [SpinKube](https://spinkube.dev) [`./scripts/03-deploy-spinkube.sh`](./scripts/03-deploy-spinkube.sh)
4. Build and Run Demo 1 [`./scripts/04-build-and-run-demo1.sh`](./scripts/04-build-and-run-demo1.sh)
5. Deploy the Spin App (Demo 1) [`./scripts/05-deploy-demo1.sh`](./scripts/05-deploy-demo1.sh)
6. Deploy an Ingress Controller [`./scripts/06-deploy-ingress.sh`](./scripts/06-deploy-ingress.sh)
7. Deploy an Ingress Route for the Spin App (Demo 1) [`./scripts/07-deploy-ingress-route.sh`](./scripts/07-deploy-ingress-route.sh)
8. Build and Run Demo 2 [`./scripts/08-build-and-run-demo2.sh`](./scripts/08-build-and-run-demo2.sh)
9. Deploy [valkey](https://valkey.io) [`./scripts/09-deploy-valkey.sh`](./scripts/09-deploy-valkey.sh)
10. Deploy the Spin App (Demo 2) [`./scripts/10-deploy-demo2.sh`](./scripts/10-deploy-demo2.sh)
11. 10. Deploy the Ingress Route (Demo 2) [`./scripts/11-deploy-ingress-route2.sh`](./scripts/11-deploy-ingress-route2.sh)


## Calling the Demo 1 Spin App

### When running locally

```bash
curl -iX GET http://localhost:3000
```

### When running on your Civo Kubernetes

```bash
# Find public IP of your Ingress Controller
ingress_ip=$(kubectl get svc -n kube-system traefik -o json | jq '.status.loadBalancer.ingress[0].ip' -r)

# Invoke the Spin App
curl -iX GET -H 'host: livedemo1.civo' http://$ingress_ip

HTTP/1.1 200 OK
Content-Type: text/plain
Date: Wed, 11 Sep 2024 14:30:46 GMT
Transfer-Encoding: chunked

Hello, Civo Navigate Europe!%
```

## Calling the Demo 2 Spin App

### When running locally

```bash
# set value in key-value store
curl -iX POST -d 'Navigate Europe' http://localhost:3000/civo

HTTP/1.1 201 Created
location: /civo
transfer-encoding: chunked
date: Wed, 11 Sep 2024 14:32:42 GMT

# get value from key-value store
curl -iX GET http://localhost:3000/civo

HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Wed, 11 Sep 2024 14:33:02 GMT

Navigate Europe%
```

### When running on your Civo Kubernetes

```bash
# Find public IP of your Ingress Controller
ingress_ip=$(kubectl get svc -n kube-system traefik -o json | jq '.status.loadBalancer.ingress[0].ip' -r)

# Invoke the Spin App
curl -iX POST -H 'host: livedemo2.civo' -d 'Civo Navigate' http://$ingress_ip/civo

HTTP/1.1 201 Created
location: /civo
transfer-encoding: chunked
date: Wed, 11 Sep 2024 14:34:39 GMT

# get value from key-value store
curl -iX GET -H 'host: livedemo2.civo' http://$ingress_ip/civo

HTTP/1.1 200 OK
Content-Type: text/plain
Date: Wed, 11 Sep 2024 14:35:02 GMT
Transfer-Encoding: chunked

Hello, Civo Navigate Europe!%
```
