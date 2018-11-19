#!/bin/sh
set -e

set -- keepalived --dont-fork --dump-conf --log-detail --log-facility=2 --vrrp -f /usr/local/etc/keepalived/keepalived.conf
#haproxy -W -D -f /usr/local/etc/haproxy/haproxy.cfg
rm -rf /var/run/rsyslogd.pid 2>/dev/null
if [ ! `pidof rsyslogd` ]; then
	rsyslogd
fi
exec "$@"
