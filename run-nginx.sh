#!/bin/sh
cd "$(dirname $0)"
./nginx/nginx_bin/sbin/nginx "$@"