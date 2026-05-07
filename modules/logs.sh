#!/bin/bash

OUTPUT_DIR=$1

mkdir -p "$OUTPUT_DIR/logs"

echo "Collecting logs..."

echo "[AUTH LOG]" > "$OUTPUT_DIR/logs/auth.log"

if [ -f /var/log/auth.log ]; then
    cat /var/log/auth.log >> "$OUTPUT_DIR/logs/auth.log"
else
    echo "auth.log not found" >> "$OUTPUT_DIR/logs/auth.log"
fi

echo "[SYSLOG]" > "$OUTPUT_DIR/logs/syslog.txt"

if [ -f /var/log/syslog ]; then
    cat /var/log/syslog >> "$OUTPUT_DIR/logs/syslog.txt"
else
    echo "syslog not found" >> "$OUTPUT_DIR/logs/syslog.txt"
fi

echo "[JOURNALCTL]" > "$OUTPUT_DIR/logs/journal.txt"
journalctl --no-pager >> "$OUTPUT_DIR/logs/journal.txt" 2>/dev/null
