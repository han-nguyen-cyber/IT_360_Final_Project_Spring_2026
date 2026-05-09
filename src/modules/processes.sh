#!/bin/bash

# This is the "processes.sh" script. 
# This script captures the current state of system execution, including active 
# processes, loaded kernel drivers, and service statuses. 

# Accepts the output directory passed from main.sh:
OUTPUT_DIR=$1

# Creating a specific subdirectory for log artifacts.
mkdir -p "$OUTPUT_DIR/processes"

# Running Processes (ps)
# Captures a snapshot of every process currently in memory.
# Looks at high CPU usage, processes with no parent, or processes 
# running out of unusualy directories (like /tmp or /dev/shm).

echo "Collecting process information..."

echo "[RUNNING PROCESSES]" > "$OUTPUT_DIR/processes/processes.txt"
ps aux >> "$OUTPUT_DIR/processes/processes.txt"

# Kernel modules (lsmod)
# Lists all loaded drivers; this is critical for detecting rootkits. 
# If an attacker has loaded a malicious kernel module (LKM), they can 
# hide files, processes, and network connections from the OS entirely.
echo "[KERNEL MODULES]" > "$OUTPUT_DIR/processes/kernel_modules.txt"
lsmod >> "$OUTPUT_DIR/processes/kernel_modules.txt"

echo "[SYSTEMD SERVICES]" > "$OUTPUT_DIR/processes/services.txt"
systemctl list-units --type=service --all >> "$OUTPUT_DIR/processes/services.txt" 2>/dev/null
