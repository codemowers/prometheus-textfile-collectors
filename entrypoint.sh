#!/bin/bash

# Define all scripts with their conditions and commands
declare -A scripts
scripts[smart]="/scripts/smartmon.py"
scripts[nvme]="/scripts/nvme_metrics.py"

# Check for LVM support
if [[ -e /sys/module/dm_mod ]]; then
    scripts[lvm]="/scripts/lvm-prom-collector -g -p"
fi

# Check for IPMI support
if [[ -e /dev/ipmi0 ]] || [[ -e /dev/ipmi/0 ]] || [[ -e /dev/ipmidev/0 ]]; then
    scripts[ipmitool]="ipmitool sensor | /scripts/ipmitool"
fi

# Clean up old prometheus files
for script_name in "${!scripts[@]}"; do
    rm -f "${script_name}.prom"
done

echo "Enabled scripts: ${!scripts[*]}"

while true; do
  THEN=$(date +%s)

  # Run all enabled scripts
  for script_name in "${!scripts[@]}"; do
      ${scripts[$script_name]} > "${script_name}.prom.part"
  done

  # Move all .part files to final names
  for script_name in "${!scripts[@]}"; do
      if [[ -f "${script_name}.prom.part" ]]; then
          mv "${script_name}.prom.part" "${script_name}.prom"
      fi
  done

  ELAPSED=$(( $(date +%s) - $THEN ))
  SLEEP_TIME=$(( 30 - $ELAPSED ))
  if [ $SLEEP_TIME -gt 0 ]; then
      sleep $SLEEP_TIME
  fi
done
