#!/usr/bin/env sh
set -eu

echo '9000 port should be opened'
nc -zv fpm 9000

echo 'php-fpm config should be valid'
php-fpm -t

#echo -n '9000 port should be opened'
#nc -zv fpm 9000
#echo ' -> OK'
