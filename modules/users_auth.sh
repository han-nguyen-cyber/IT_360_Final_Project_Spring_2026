OUT=$1/users
mkdir -p "$OUT"

who > "$OUT/logged_in_users.txt"
last > "$OUT/login_history.txt"
cat /etc/passwd > "$OUT/passwd.txt"

for h in /home/*/.bash_history; do
cp --no-preserve=mode,ownership "$h" "$OUT/" 2>/dev/null
done
