#!/usr/bin/env sh
set -eu

echo -n 'Xdebug file should exist'
 php -dzend_extension=xdebug.so -m | grep -q xdebug
echo ' -> OK'
