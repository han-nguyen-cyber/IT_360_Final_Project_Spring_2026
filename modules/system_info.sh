OUT=$1/system
mkdir -p "$OUT"

uname -a > "$OUT/kernel.txt"
hostnamectl > "$OUT/hostname.txt"
timedatectl > "$OUT/timezone.txt"
lscpu > "$OUT/cpu.txt"
free -h > "$OUT/memory.txt"
