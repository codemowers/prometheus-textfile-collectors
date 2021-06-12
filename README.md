# Background

Ubuntu packages are outdated and getting textfile collectors working is a hassle.
This is the only sane option for running Prometheus Node Exporter with textfile collectors
such as SMART metrics, NVMe metrics etc.


# Deploying

See supplied `docker-compose.yml`


# Security

Don't forget to add some `iptables` rules for protecting the node exporter endpoint.

![Still waiting for bearer token](https://imgflip.com/i/5d21t5)
