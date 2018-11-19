# vim:set ft=dockerfile:
FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		liblua5.3-0 \
		libpcre3 \
		libssl1.1 \
    	rsyslog \
		keepalived \
  && rm -f /etc/rsyslog.d/20-ufw.conf \
	&& rm -rf /var/lib/apt/lists/*
### install keepalived and rsyslog
ENV HAPROXY_MAJOR 1.8
ENV HAPROXY_VERSION 1.8.12
ENV HAPROXY_MD5 9f37013ec1e76942a67a9f7c067af9f2

# see https://sources.debian.net/src/haproxy/jessie/debian/rules/ for some helpful navigation of the possible "make" arguments
RUN set -x \
	\
	&& buildDeps=' \
		ca-certificates \
		gcc \
		libc6-dev \
		liblua5.3-dev \
		libpcre3-dev \
		libssl-dev \
		make \
		wget \
		zlib1g-dev \
	' \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	\
	&& wget -O haproxy.tar.gz "https://www.haproxy.org/download/${HAPROXY_MAJOR}/src/haproxy-${HAPROXY_VERSION}.tar.gz" \
	&& echo "$HAPROXY_MD5 *haproxy.tar.gz" | md5sum -c \
	&& mkdir -p /usr/src/haproxy \
	&& tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1 \
	&& rm haproxy.tar.gz \
	\
	&& makeOpts=' \
		TARGET=linux2628 \
		USE_LUA=1 LUA_INC=/usr/include/lua5.3 \
		USE_OPENSSL=1 \
		USE_PCRE=1 PCREDIR= \
		USE_ZLIB=1 \
	' \
	&& make -C /usr/src/haproxy -j "$(nproc)" all $makeOpts \
	&& make -C /usr/src/haproxy install-bin $makeOpts \
	\
	&& mkdir -p /usr/local/etc/haproxy \
	&& mkdir -p /usr/local/etc/haproxy/socks \
	&& mkdir -p /usr/local/etc/haproxy/logs \
	&& mkdir -p /usr/local/etc/keepalived/logs \
	&& cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors \
	&& rm -rf /usr/src/haproxy \
	\
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -f /etc/rsyslog.conf \
	&& rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Tehran /etc/localtime \
	&& echo "Asia/Tehran" > /etc/timezone
### create haproxy hiarchy ,set local time zone for logfile 
COPY docker-entrypoint.sh /
COPY rsyslog.conf /etc/rsyslog.conf
### copy rsyslog config file
COPY rotate_haproxy.sh /usr/local/bin/rotate_haproxy.sh
### copy haproxy log rotate file script
COPY rotate_keepalived.sh /usr/local/bin/rotate_keepalived.sh
### copy keepalived log rotate file script
ENTRYPOINT ["/docker-entrypoint.sh"]
