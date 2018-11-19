#!/bin/bash

docker run -d --name haproxy \
-v $PWD/etc/haproxy/:/usr/local/etc/haproxy \
-v $PWD/etc/keepalived/:/usr/local/etc/keepalived \
--network host --cap-add=NET_ADMIN \
IMAGENAME
