#!/bin/bash
while true; do
  /scripts/smartmon.sh > /run/node-exporter/smart.prom
  /scripts/nvme_metrics.sh > /run/node-exporter/nvme.prom
  /scripts/bridge.sh > /run/node-exporter/bridge.prom
  /scripts/ipmitool > /run/node-exporter/impitool.prom
  sleep 15
done
