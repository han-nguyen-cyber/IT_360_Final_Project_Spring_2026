#!/bin/bash

# This is the "persistence.sh" script.
# The purpose of this script is to scan common locations where malware or backdoors hide to 
# survive system reboots.

# Accepts the output directory passed from main.sh:
OUTPUT_DIR=$1

# Creating a specific subdirectory for log artifacts.
mkdir -p "$OUTPUT_DIR/persistence"

echo "Checking persistence mechanisms..."

# Cron Jobs:
# Checks for automated tasks that run at specific intervals. Attackers often add entries
# to redownload a payload or re-establish a reverse shell. 
echo "[CRON JOBS]" > "$OUTPUT_DIR/persistence/cron.txt"

# Lists all system-wide cron directories where root-level persistence usually lives
crontab -l >> "$OUTPUT_DIR/persistence/cron.txt" 2>/dev/null

ls -la /etc/cron* >> "$OUTPUT_DIR/persistence/cron.txt" 2>/dev/null

# Systemd services:
# This is the modern way to start progress in Linux. A malicious service can be set to 
# "enabled" so it starts automatically every time the computer boots.
echo "[SYSTEMD SERVICES]" > "$OUTPUT_DIR/persistence/systemd.txt"

systemctl list-unit-files --type=service >> "$OUTPUT_DIR/persistence/systemd.txt" 2>/dev/null

# RC.LOCAL
# This is a legacy boot script. It's depreceated in certain distros, but is still a 
# common target because it's an easy place to hide a single malicious line. 
echo "[RC.LOCAL]" > "$OUTPUT_DIR/persistence/rc_local.txt"

if [ -f /etc/rc.local ]; then
    cat /etc/rc.local >> "$OUTPUT_DIR/persistence/rc_local.txt"
else
    echo "rc.local not found" >> "$OUTPUT_DIR/persistence/rc_local.txt"
fi

# SUID/SGID Binaries
# Files with these permissions run with the privilege of the file owner
# Attackers can set the permissions on a shell to escalate their privileges later.
echo "[SUID/SGID BINARIES]" > "$OUTPUT_DIR/persistence/suid_sgid.txt"

find / -perm /6000 -type f 2>/dev/null >> "$OUTPUT_DIR/persistence/suid_sgid.txt"
