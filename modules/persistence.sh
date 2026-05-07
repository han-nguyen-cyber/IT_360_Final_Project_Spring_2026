#!/bin/bash

OUTPUT_DIR=$1

mkdir -p "$OUTPUT_DIR/persistence"

echo "Checking persistence mechanisms..."

echo "[CRON JOBS]" > "$OUTPUT_DIR/persistence/cron.txt"

crontab -l >> "$OUTPUT_DIR/persistence/cron.txt" 2>/dev/null

ls -la /etc/cron* >> "$OUTPUT_DIR/persistence/cron.txt" 2>/dev/null

echo "[SYSTEMD SERVICES]" > "$OUTPUT_DIR/persistence/systemd.txt"

systemctl list-unit-files --type=service >> "$OUTPUT_DIR/persistence/systemd.txt" 2>/dev/null

echo "[RC.LOCAL]" > "$OUTPUT_DIR/persistence/rc_local.txt"

if [ -f /etc/rc.local ]; then
    cat /etc/rc.local >> "$OUTPUT_DIR/persistence/rc_local.txt"
else
    echo "rc.local not found" >> "$OUTPUT_DIR/persistence/rc_local.txt"
fi

echo "[SUID/SGID BINARIES]" > "$OUTPUT_DIR/persistence/suid_sgid.txt"

find / -perm /6000 -type f 2>/dev/null >> "$OUTPUT_DIR/persistence/suid_sgid.txt"
