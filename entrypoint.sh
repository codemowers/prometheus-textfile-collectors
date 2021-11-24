#!/bin/bash
while true; do
  /scripts/smartmon.sh > /run/node-exporter/smart.prom.part
  mv /run/node-exporter/smart.prom.part /run/node-exporter/smart.prom
  /scripts/nvme_metrics.sh > /run/node-exporter/nvme.prom.part
  mv /run/node-exporter/nvme.prom.part /run/node-exporter/nvme.prom
  /scripts/bridge.sh > /run/node-exporter/bridge.prom.part
  mv /run/node-exporter/bridge.prom.part /run/node-exporter/bridge.prom
  ipmitool sensor | /scripts/ipmitool > /run/node-exporter/impitool.prom.part
  mv /run/node-exporter/impitool.prom.part /run/node-exporter/impitool.prom
  sleep 15
done
