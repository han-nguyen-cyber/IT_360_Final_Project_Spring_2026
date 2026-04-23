#!/bin/bash

echo "[+] Starting Linux Live Response Collection..."

# Create output folder
mkdir -p output

# Timestamp
date > output/timestamp.txt

echo "[+] Running System Info Module..."
bash modules/system_info.sh

echo "[+] Running User/Auth Module..."
bash modules/users_auth.sh

echo "[+] Running Process Module..."
bash modules/processes.sh

echo "[+] Running Network Module..."
bash modules/network.sh

echo "[+] Running Logs Module..."
bash modules/logs.sh

echo "[+] Running Persistence Detection Module..."
bash modules/persistence.sh

echo "[+] Collection Complete. Check /output folder."
