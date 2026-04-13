#!/bin/bash

OUTPUT="output/system_info.txt"

echo "[+] Collecting System Info..." > $OUTPUT

uname -a >> $OUTPUT
hostname >> $OUTPUT
timedatectl >> $OUTPUT

echo "[+] Done"
