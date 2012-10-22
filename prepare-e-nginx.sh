#!/bin/sh
cd "$(dirname $0)"

########## Directories #########
NGINX="$PWD/nginx"
PREFIX="$NGINX/nginx_bin"
SBIN="$PREFIX/sbin/nginx"
CONF="$NGINX/conf/nginx.conf"
PID="$NGINX/pid/nginx.pid"
LOGS_DIR="$NGINX/logs"
ERROR_LOG="$LOGS_DIR/error.log"
HTTP_LOG="$LOGS_DIR/access.log"
ARCHIVES="$PWD/archives"
SOURCES="$PWD/sources"

############## User and Group ###############
NGINX_USER="nginx"
NGINX_GROUP="nginx"

###### SOURCES #########
NGINX_SOURCE="$SOURCES/nginx-1.2.4"
PCRE_SOURCE="$SOURCES/pcre-8.30"
ZLIB_SOURCE="$SOURCES/zlib-1.2.5"
OPENSSL_SOURCE="$SOURCES/openssl-1.0.0j"
################################################
./clean-all.sh
############# Extract sources ##################
for archive in nginx-1.2.4.tar.gz openssl-1.0.0j.tar.gz pcre-8.30.tar.gz zlib-1.2.5.tar.gz
do
    tar -xzvf "$ARCHIVES/$archive" -C "$SOURCES"
done
mv "$SOURCES/madler-zlib-41fd7e5" "$SOURCES/zlib-1.2.5"
########################################################

cd "$NGINX_SOURCE"
./configure --prefix="$PREFIX" --sbin-path="$SBIN" --conf-path="$CONF" --pid-path="$PID" --error-log-path="$ERROR_LOG" --http-log-path="$HTTP_LOG" --user="$NGINX_USER" --group="$NGINX_GROUP" --with-http_ssl_module --with-pcre="$PCRE_SOURCE" --with-pcre-jit --with-zlib="$ZLIB_SOURCE" --with-openssl="$OPENSSL_SOURCE"
make && make install



