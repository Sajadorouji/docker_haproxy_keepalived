#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

case $STATE in
        "MASTER") /usr/local/sbin/haproxy -W -D -f /usr/local/etc/haproxy/haproxy.cfg
                  exit 0
                  ;;
        "BACKUP") kill $(pidof haproxy)
                  exit 0
                  ;;
        "FAULT")  kill $(pidof haproxy)
                  exit 0
                  ;;
        *)        echo "unknown state"
                  exit 1
                  ;;
esac
