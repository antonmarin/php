#!/usr/bin/env sh
set -eu

echo '9000 port should be opened'
nc -zv fpm 9000

echo 'php-fpm config should be valid'
php-fpm -t

echo -n 'xdebug should be enabled if zend_extension=xdebug.so is passed to cmd'
php-fpm -d zend_extension=xdebug.so -i | grep -q "xdebug support => enabled"
echo ' -> OK'
