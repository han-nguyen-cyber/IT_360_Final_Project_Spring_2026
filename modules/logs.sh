cp /var/log/auth.log "$OUT/"
cp /var/log/syslog "$OUT/"
journalctl -n 1000 > journal.txt
