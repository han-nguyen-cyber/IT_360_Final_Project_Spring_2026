#!/bin/bash

OUTPUT_DIR=$1

mkdir -p "$OUTPUT_DIR/system"

echo -e "\n1. Collecting system information..."

echo "[KERNEL INFO]" > "$OUTPUT_DIR/system/kernel.txt"
uname -a >> "$OUTPUT_DIR/system/kernel.txt"

echo "[HOSTNAME]" > "$OUTPUT_DIR/system/hostname.txt"
hostname >> "$OUTPUT_DIR/system/hostname.txt"

echo "[TIMEZONE]" > "$OUTPUT_DIR/system/timezone.txt"
timedatectl >> "$OUTPUT_DIR/system/timezone.txt" 2>/dev/null

echo "[CPU INFO]" > "$OUTPUT_DIR/system/cpu.txt"
lscpu >> "$OUTPUT_DIR/system/cpu.txt"

echo "[MEMORY INFO]" > "$OUTPUT_DIR/system/memory.txt"
free -h >> "$OUTPUT_DIR/system/memory.txt"
