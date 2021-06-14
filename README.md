# Background

Ubuntu packages are outdated and getting textfile collectors working is a hassle.
This is the only sane option for running Prometheus Node Exporter with textfile collectors
such as SMART metrics, NVMe metrics etc.


# Deploying

See supplied `docker-compose.yml` and launch:

```
docker-compose --project-name prometheus_node_exporter up -d
```


# Security

Don't forget to add some `iptables` rules for protecting the node exporter endpoint.

![Still waiting for Prometheus devs to add bearer token support](https://i.imgflip.com/5d21t5.jpg)
