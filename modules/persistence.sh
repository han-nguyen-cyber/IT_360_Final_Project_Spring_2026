#!/bin/bash

OUTPUT="output/persistence.txt"

echo "[+] Running Persistence Detection..." > $OUTPUT

echo "=== CRON JOBS ===" >> $OUTPUT
crontab -l >> $OUTPUT 2>/dev/null
ls /etc/cron* >> $OUTPUT

echo "=== STARTUP SCRIPTS ===" >> $OUTPUT
cat /etc/rc.local >> $OUTPUT 2>/dev/null
ls /etc/init.d >> $OUTPUT

echo "=== SYSTEMD SERVICES ===" >> $OUTPUT
systemctl list-unit-files --type=service >> $OUTPUT

echo "=== SUID/SGID BINARIES ===" >> $OUTPUT
find / -perm -4000 -type f 2>/dev/null >> $OUTPUT

echo "[+] Persistence Detection Complete"
