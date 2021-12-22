#!/usr/bin/env sh
set -e

echo -n 'Image should set PHP_VERSION variable'
[ -n "${PHP_VERSION}" ]
echo ' -> OK'

echo -n 'Image should set XDEBUG_VERSION variable'
[ -n "${XDEBUG_VERSION}" ]
echo ' -> OK'
