#!/bin/bash
set -x
apt-get install build-essential -y

PROM_HOME="/app/prometheus"
if [  ! -d $PROM_HOME ]; then
    mkdir $PROM_HOME
fi
rm -rf $PROM_HOME/*

#######################
# Install grafana
apt-get install apt-transport-https -y

GRAFANA_HOME="/app/grafana"
if [  ! -d $GRAFANA_HOME ]; then
    mkdir $GRAFANA_HOME
fi

wget https://dl.grafana.com/oss/release/grafana_6.3.4_amd64.deb -P $GRAFANA_HOME
apt-get install -y adduser libfontconfig1
dpkg -i $GRAFANA_HOME/grafana_6.3.4_amd64.deb


#######################
# Installing prometheus
go get github.com/prometheus/prometheus/cmd/...


# Starting prometheus and grafana
service grafana-server restart
# When we use go get, call prometheus from the root of the cloned directory
# https://github.com/prometheus/prometheus
cd /root/go/src/github.com/prometheus/prometheus
/root/go/bin/prometheus --config.file=/vagrant/prometheus/prometheus.yml &
# TODO
# Prometheus does not start when vagrant finishes, it requires to be started manually by login into the prometheus box
cp /vagrant/prometheus/start_prometheus.sh /app/prometheus/
sh start_prometheus &



# Reference

# How to install Go
# https://golang.org/doc/install

# How to install Prometheus
# https://www.howtoforge.com/tutorial/how-to-install-prometheus-and-node-exporter-on-centos-7/
# https://github.com/prometheus/prometheus/tree/master

# Install grafana
# https://grafana.com/grafana/download?platform=linux

# Install by downloading deb package
# https://grafana.com/docs/installation/debian/

