#!/bin/bash

# Determine which scripts should run
RUN_SMART=true
RUN_NVME=true
RUN_LVM=false
RUN_IPMITOOL=false

# Check for LVM support
if [[ -e /sys/module/dm_mod ]]; then
    RUN_LVM=true
fi

# Check for IPMI support
if [[ -e /dev/ipmi0 ]] || [[ -e /dev/ipmi/0 ]] || [[ -e /dev/ipmidev/0 ]]; then
    RUN_IPMITOOL=true
fi

# Clean up old prometheus files
rm -f smart.prom nvme.prom lvm.prom ipmitool.prom impitool.prom

echo "Enabled scripts:"
if $RUN_SMART; then echo "- smart"; fi
if $RUN_NVME; then echo "- nvme"; fi
if $RUN_LVM; then echo "- lvm"; fi
if $RUN_IPMITOOL; then echo "- ipmitool"; fi

while true; do
  THEN=$(date +%s)

  # Run enabled scripts
  if $RUN_SMART; then
      /scripts/smartmon.py > smart.prom.part
      mv smart.prom.part smart.prom
  fi

  if $RUN_NVME; then
      /scripts/nvme_metrics.py > nvme.prom.part
      mv nvme.prom.part nvme.prom
  fi

  if $RUN_LVM; then
      /scripts/lvm-prom-collector -g -p > lvm.prom.part
      mv lvm.prom.part lvm.prom
  fi

  if $RUN_IPMITOOL; then
      ipmitool sensor | /scripts/ipmitool > ipmitool.prom.part
      mv ipmitool.prom.part ipmitool.prom
  fi

  ELAPSED=$(( $(date +%s) - $THEN ))
  SLEEP_TIME=$(( 30 - $ELAPSED ))
  if [ $SLEEP_TIME -gt 0 ]; then
      sleep $SLEEP_TIME
  fi
done
