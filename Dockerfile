FROM alpine AS build

RUN apk add --no-cache \
    smartmontools \
    jq \
    nvme-cli \
    bash \
    hwids-pci

COPY node-exporter-textfile-collector-scripts /scripts
COPY entrypoint.sh /entrypoint.sh
COPY bridge.sh /scripts/
RUN chmod +x /scripts/bridge.sh
RUN chmod +x /entrypoint.sh
RUN test -f /scripts/smartmon.sh
RUN test -f /scripts/nvme_metrics.sh
RUN test -f /scripts/ipmitool
ENTRYPOINT /entrypoint.sh
