#!/bin/bash

OUTPUT_DIR=$1

mkdir -p "$OUTPUT_DIR/users"

echo "Collecting user/authentication data..."

echo "[LOGGED IN USERS]" > "$OUTPUT_DIR/users/logged_in.txt"
who >> "$OUTPUT_DIR/users/logged_in.txt"

echo "[LOGIN HISTORY]" > "$OUTPUT_DIR/users/login_history.txt"
last >> "$OUTPUT_DIR/users/login_history.txt"

echo "[PASSWD FILE]" > "$OUTPUT_DIR/users/passwd.txt"
cat /etc/passwd >> "$OUTPUT_DIR/users/passwd.txt"

echo "[BASH HISTORY]" > "$OUTPUT_DIR/users/bash_history.txt"

find /home -name ".bash_history" 2>/dev/null | while read file; do
    echo "----- $file -----" >> "$OUTPUT_DIR/users/bash_history.txt"
    cat "$file" >> "$OUTPUT_DIR/users/bash_history.txt" 2>/dev/null
done
