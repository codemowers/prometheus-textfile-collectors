#!/bin/bash
cd /run/node-exporter/
rm -f *.prom

if [[ -e /sys/module/dm_mod ]]; then
    lvm_enabled=1
fi

if [[ -e /dev/ipmi0 ]]; then
    ipmi_enabled=1
fi
if [[ -e /dev/ipmi/0 ]]; then
    ipmi_enabled=1
fi
if [[ -e /dev/ipmidev/0 ]]; then
    ipmi_enabled=1
fi

echo "Additional scripts: $(env | grep _enabled | xargs)"

while true; do
  THEN=$(date +%s)
  /scripts/smartmon.py > smart.prom.part
  /scripts/nvme_metrics.sh > nvme.prom.part
  if [ ! -z $ipmi_enabled ]; then
      ipmitool sensor | /scripts/ipmitool > impitool.prom.part
  fi

  if [ ! -z $lvm_enabled ]; then
      /scripts/lvm-prom-collector -g -p > lvm.prom.part
  fi

  for j in *.part; do
      mv $j $(basename $j .part)
  done
  sleep $(( 30 - $(date +%s) + $THEN))
done
