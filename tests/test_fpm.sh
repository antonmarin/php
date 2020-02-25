#!/usr/bin/env sh
set -eu

echo '9000 port should be opened'
nc -zv fpm 9000

#echo -n '9000 port should be opened'
#nc -zv fpm 9000
#echo ' -> OK'
