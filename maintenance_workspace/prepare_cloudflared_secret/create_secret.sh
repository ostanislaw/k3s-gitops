#!/bin/bash
kubectl create secret generic cloudflared-credentials -n networking --from-file=credentials.json  --output=yaml --dry-run=client
