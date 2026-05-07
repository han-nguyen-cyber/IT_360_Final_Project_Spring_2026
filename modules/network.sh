#!/bin/bash

OUTPUT_DIR=$1

mkdir -p "$OUTPUT_DIR/network"

echo "Collecting network artifacts..."

echo "[ACTIVE CONNECTIONS]" > "$OUTPUT_DIR/network/connections.txt"
ss -tulnp >> "$OUTPUT_DIR/network/connections.txt"

echo "[NETWORK INTERFACES]" > "$OUTPUT_DIR/network/interfaces.txt"
ip a >> "$OUTPUT_DIR/network/interfaces.txt"

echo "[ROUTING TABLE]" > "$OUTPUT_DIR/network/routes.txt"
ip route >> "$OUTPUT_DIR/network/routes.txt"
