#!/bin/bash -x

# Installing common

apt-get update
apt-get -y install git wget curl vim
apt-get -y install gnupg2

if [ ! -d /app ]; then
    mkdir /app
fi

#######################
# Installing go
GO_HOME="/app/go"
GO_VERSION="13.4"
if [ ! -d $GO_HOME ]; then
    mkdir $GO_HOME
fi

wget https://dl.google.com/go/go1.$GO_VERSION.linux-amd64.tar.gz -P $GO_HOME
tar -C /usr/local -zxvf $GO_HOME/go1.$GO_VERSION.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
echo "export PATH=\$PATH:/usr/local/go/bin" >> /root/.bashrc
export PATH=$PATH:/usr/local/go/bin
go version
