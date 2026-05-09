#!/bin/bash

# This is the "logs.sh" script. 
# This script collects system and authentication logs for forensic timeline analysis. 

# Accepts the output directory passed from main.sh:
OUTPUT_DIR=$1

# Creating a specific subdirectory for log artifacts.
mkdir -p "$OUTPUT_DIR/logs"

echo "Collecting logs..."

# Authentication logs:
# Records login attempts, sudo usage, and ssh connections.
echo "[AUTH LOG]" > "$OUTPUT_DIR/logs/auth.log"

if [ -f /var/log/auth.log ]; then
    cat /var/log/auth.log >> "$OUTPUT_DIR/logs/auth.log"
else
    echo "auth.log not found" >> "$OUTPUT_DIR/logs/auth.log"
fi

# System logs:
# This collects general system messages, including kernel alerts and service starts and stops.
echo "[SYSLOG]" > "$OUTPUT_DIR/logs/syslog.txt"

if [ -f /var/log/syslog ]; then
    cat /var/log/syslog >> "$OUTPUT_DIR/logs/syslog.txt"
else
    echo "syslog not found" >> "$OUTPUT_DIR/logs/syslog.txt"
fi

# Systemd journal 
# This collects binary logs managed by systemd. 
echo "[JOURNALCTL]" > "$OUTPUT_DIR/logs/journal.txt"
journalctl --no-pager >> "$OUTPUT_DIR/logs/journal.txt" 2>/dev/null
