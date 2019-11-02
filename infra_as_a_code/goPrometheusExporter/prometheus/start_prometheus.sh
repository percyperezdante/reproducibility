#!/bin/bash

cd /root/go/src/github.com/prometheus/prometheus
/root/go/bin/prometheus --config.file=/vagrant/prometheus/prometheus.yml &

