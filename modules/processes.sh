#!/bin/bash

OUTPUT_DIR=$1

mkdir -p "$OUTPUT_DIR/processes"

echo "Collecting process information..."

echo "[RUNNING PROCESSES]" > "$OUTPUT_DIR/processes/processes.txt"
ps aux >> "$OUTPUT_DIR/processes/processes.txt"

echo "[KERNEL MODULES]" > "$OUTPUT_DIR/processes/kernel_modules.txt"
lsmod >> "$OUTPUT_DIR/processes/kernel_modules.txt"

echo "[SYSTEMD SERVICES]" > "$OUTPUT_DIR/processes/services.txt"
systemctl list-units --type=service --all >> "$OUTPUT_DIR/processes/services.txt" 2>/dev/null
