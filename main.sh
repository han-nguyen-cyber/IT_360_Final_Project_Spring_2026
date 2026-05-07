#!/bin/bash

# This is the "main.sh" script. Its purpose is to orchestrate the modules of the Linux Live Response forensic collection tool.
echo "Starting Linux Live Response Collection..."

# Output directory definition: this is a unique output directory using a Year, Month, Day, Hour, Minute, Second format, 
# to prevent overwrites of previous forensic runs, and to validate evidence with a precise, chronological timeline of 
#actions and sequence of events.
OUTPUT_DIR="output_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

# Timestamp capturing the exact start time of the investigation, to aid the forensic timeline.
date > "$OUTPUT_DIR/timestamp.txt"

# Module execution phase:
# Each module is based off a standalone script, located in /modules, for the purpose of modularity and clean code.
# Modules include system_info.sh, users_auth.sh, processes.sh, network.sh, logs.sh,  and persistence.sh
# All module results are saved into the unique OUTPUT_DIR created above.
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

# Data aggregation phase
# Outputs get aggregated and bundled into one single file, AI_BUNDLE, for AI processing.
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

# AI integration and analysis phase:
# Feeds the aggregated forensic data AI_BUNDLE into the Gemini API for a digital forensics report.
echo "Running AI analysis..."

python3 modules/ai.py "$AI_BUNDLE" > "$OUTPUT_DIR/ai_analysis.txt"

echo "AI analysis saved to $OUTPUT_DIR/ai_analysis.txt"
