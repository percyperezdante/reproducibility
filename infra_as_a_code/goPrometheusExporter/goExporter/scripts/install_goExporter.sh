#!/bin/bash
set -x
go get github.com/prometheus/client_golang/prometheus
go get github.com/prometheus/client_golang/prometheus/promauto
go get github.com/prometheus/client_golang/prometheus/promhttp

cp -r /vagrant/goExporter/dev /app/

