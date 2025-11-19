FROM python:alpine AS build

RUN apk add --no-cache \
    smartmontools \
    jq \
    nvme-cli \
    bash \
    hwids-pci \
    ipmitool \
    lvm2 \
 && pip install prometheus-client
COPY node-exporter-textfile-collector-scripts/smartmon.py /scripts/
COPY node-exporter-textfile-collector-scripts/nvme_metrics.py /scripts/
COPY node-exporter-textfile-collector-scripts/ipmitool /scripts/
COPY node-exporter-textfile-collector-scripts/lvm-prom-collector /scripts/
COPY entrypoint.sh /entrypoint.sh
WORKDIR /run/node-exporter/
ENTRYPOINT ["/entrypoint.sh"]
