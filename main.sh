#!/bin/bash

echo "Starting Linux Live Response Collection..."

# Define output directory:=
OUTPUT_DIR="output_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

# Timestamp
date > "$OUTPUT_DIR/timestamp.txt"

echo "Running System Info Module..."
bash modules/system_info.sh "$OUTPUT_DIR"

echo "Running User/Auth Module..."
bash modules/users_auth.sh "$OUTPUT_DIR"

echo "Running Process Module..."
bash modules/processes.sh "$OUTPUT_DIR"

echo "Running Network Module..."
bash modules/network.sh "$OUTPUT_DIR"

echo "Running Logs Module..."
bash modules/logs.sh "$OUTPUT_DIR"

echo "Running Persistence Detection Module..."
bash modules/persistence.sh "$OUTPUT_DIR"

echo "Collection Complete. Output: $OUTPUT_DIR"

# Outputs get aggregated and bundled into one file, AI_BUNDLE
AI_BUNDLE="$OUTPUT_DIR/ai_bundle.txt"

echo "Creating AI input bundle..."

echo "SYSTEM" > "$AI_BUNDLE"
cat "$OUTPUT_DIR/system/"* >> "$AI_BUNDLE" 2>/dev/null

echo -e "USERS" >> "$AI_BUNDLE"
cat "$OUTPUT_DIR/users/"* >> "$AI_BUNDLE" 2>/dev/null

echo -e "PROCESSES" >> "$AI_BUNDLE"
cat "$OUTPUT_DIR/processes/"* >> "$AI_BUNDLE" 2>/dev/null

echo -e "NETWORK" >> "$AI_BUNDLE"
cat "$OUTPUT_DIR/network/"* >> "$AI_BUNDLE" 2>/dev/null

echo -e "LOGS" >> "$AI_BUNDLE"
cat "$OUTPUT_DIR/logs/"* >> "$AI_BUNDLE" 2>/dev/null

echo -e "PERSISTENCE" >> "$AI_BUNDLE"
cat "$OUTPUT_DIR/persistence/"* >> "$AI_BUNDLE" 2>/dev/null

echo "AI bundle created at: $AI_BUNDLE"

# AI Integration: Feed AI_BUNDLE into Gemini for a digital forensics report
echo "Running AI analysis..."

python3 modules/ai.py "$AI_BUNDLE" > "$OUTPUT_DIR/ai_analysis.txt"

echo "AI analysis saved to $OUTPUT_DIR/ai_analysis.txt"
