FROM python:alpine AS build

RUN apk add --no-cache \
    smartmontools \
    jq \
    nvme-cli \
    bash \
    hwids-pci \
    ipmitool \
    lvm2
RUN pip install prometheus-client

COPY node-exporter-textfile-collector-scripts /scripts
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN test -f /scripts/smartmon.py
RUN test -f /scripts/nvme_metrics.sh
RUN test -f /scripts/ipmitool
ENTRYPOINT /entrypoint.sh
