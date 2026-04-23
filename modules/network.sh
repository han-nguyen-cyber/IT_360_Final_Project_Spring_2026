
OUTPUT="output/network.txt"

netstat -tulnp > $OUTPUT 2>/dev/null
ip a >> $OUTPUT
route -n >> $OUTPUT
