#!/bin/bash

# This is the "network.sh" script.
# This script gathers network state artifacts to identify active connections and potential backdoors.

# Accepts the output directory passed from main.sh:
OUTPUT_DIR=$1

# Creating a specific subdirectory for network-related forensic data.
mkdir -p "$OUTPUT_DIR/network"

echo "Collecting network artifacts..."

# Active connections: shows what ports are open, and what external IPs the system is communicating with.
echo "[ACTIVE CONNECTIONS]" > "$OUTPUT_DIR/network/connections.txt"
ss -tulnp >> "$OUTPUT_DIR/network/connections.txt"

# Network interfaces: identify assigned IP addresses, MAC addresses, and Promiscuous Mode, which can indicate 
# if a packet sniffer like Wireshark is running.
echo "[NETWORK INTERFACES]" > "$OUTPUT_DIR/network/interfaces.txt"
ip a >> "$OUTPUT_DIR/network/interfaces.txt"

# Routing table; this checks for unusual static routes. Attackers can modify routing tables to 
# intercept traffic or bypass local security gateways.
echo "[ROUTING TABLE]" > "$OUTPUT_DIR/network/routes.txt"
ip route >> "$OUTPUT_DIR/network/routes.txt"
