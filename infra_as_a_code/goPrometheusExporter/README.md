# Prometheus exporters in GO

## Introduction

This readme presents the steps needed to plot the graph 
linked to a customise prometheus exporter using Golang.

It includes the following stesp:

- Install prometheus and grafana in one VM
- Install a prometheus exporter in another VM

The prometheus exporter contains the source code of the 
customise exporter to extract the system date in this example.
Then, it exposes this metric, seconds of the date, locally. 
The lable of this metris is idw_m1. There is an extra
metric named idw_m2 which is set to a fix value.

The prometheus VM collects these exposed metrics and
allows grafana to used them to build the dashboard.

# How to reproduce this scenario

1. Build`default virtual infra

```bash
vagrant up
```

2. Start prometheus

```bash
vagrant ssh prometheus
sudo su
cd /app/prometheus
sh start_prometheus.sh &
```

3. Start customise Prometheus exporter
```bash
vagrant ssh goExporter
sudo su
/app/dev/startExample.sh
```

4. Create dashboards in Grafana

- Open tab to PromQL:  http://172.10.23.12:9090

  Verify that idw_m1 is retrived by typing "idw_m1" in the field "Expresion" 
  and click "Execute". It should display a metric similar to :
  
  ```bash
  idw_m1{instance="172.10.23.13:8080",job="MyPrometheus"}	8
  ```

- Open a tab to Grafana: http://172.10.23.12:3000

  Change the default admin password (admin/admin)
  Click on Settings and verify that "Data source" is pointing to "localhost:9090". 
  you can click "save and test" to verify that grafana is able to connect to prometheus.

  Create a new folder, create a new dashboard and add a new
  graph of the "idw_m1" metric.
