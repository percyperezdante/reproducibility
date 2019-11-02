#!/bin/bash
set -x

# Installing prometheus go client
go get github.com/prometheus/client_golang/prometheus
go get github.com/prometheus/client_golang/prometheus/promauto
go get github.com/prometheus/client_golang/prometheus/promhttp


# Install mysql, create a user,  and create a temp1 table in a test DB
apt-get install mysql-server -y
mysql -u root << EOF
use mysql;
create user 'percy'@'localhost' identified by '';
grant all privileges on *.* to 'percy'@'localhost';
flush privileges;
EOF
service mysql restart

mysql -u percy << EOF
create database test;
use test;
create table temp1 (id int, name varchar(255));
insert into temp1 values (1,"mytest");
EOF

# Install mysql driver for go
go get -u github.com/go-sql-driver/mysql

# Copy all scripts to the guest
cp -r /vagrant/goExporter/dev /app/



