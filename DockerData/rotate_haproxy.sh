#!/bin/bash

LOG_PATH="/usr/local/etc/haproxy/logs/haproxy.log"
LOG_BACKUP="/usr/local/etc/haproxy/logs/haproxylog.backup"
if [ `cat $LOG_PATH | wc -l` -gt 1000 ];then
  if [ -f $LOG_BACKUP ];then
    rm -f $LOG_BACKUP
  fi
  cp -f $LOG_PATH $LOG_BACKUP
  tail -n 1000 $LOG_PATH > $LOG_PATH
  /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  /bin/kill -HUP `cat /var/run/rsyslogd.pid 2> /dev/null` 2> /dev/null || true
fi
