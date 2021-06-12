
echo "# HELP node_bridge_members How many member interfaces bridge has"
echo "# TYPE node_bridge_members gauge"

for BRIDGE in $(ls /sys/devices/virtual/net); do
  if [ -e /sys/devices/virtual/net/$BRIDGE/brif ]; then
    echo node_bridge_members{bridge=\"$BRIDGE\"} $(/bin/ls -1 /sys/devices/virtual/net/$BRIDGE/brif 2>/dev/null | wc -l)
  fi
done
