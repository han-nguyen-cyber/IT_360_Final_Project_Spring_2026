#!/bin/bash

OUTDIR="output_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTDIR"

echo "Enabling Collection Modules:"

bash modules/system_info.sh "$OUTDIR"
bash modules/users_auth.sh "$OUTDIR"
bash modules/processes.sh "$OUTDIR"
bash modules/network.sh "$OUTDIR"
bash modules/logs.sh "$OUTDIR"
bash modules/persistence.sh "$OUTDIR"

echo "Generating Hashes:"
find "$OUTDIR" -type f -exec sha256sum {} \; > hashes.txt

echo "Collection Complete!"
