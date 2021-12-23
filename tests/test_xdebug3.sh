#!/usr/bin/env sh
set -eu

echo -n 'Xdebug should be enabled when zend_extension is set'
php -dzend_extension=xdebug.so -m | grep -q xdebug
echo ' -> OK'

echo -n 'Xdebug should be disabled when zend_extension is not set'
php -m | grep -qv xdebug
echo ' -> OK'

echo -n 'Xdebug client host should equal PHP_INI_XDEBUG_REMOTE_HOST env var value when env var is set'
export EXPECTED_XDEBUG_REMOTE_HOST=192.168.1.1
PHP_INI_XDEBUG_REMOTE_HOST=${EXPECTED_XDEBUG_REMOTE_HOST} php -dzend_extension=xdebug.so \
  -i | grep -q "xdebug.client_host => ${EXPECTED_XDEBUG_REMOTE_HOST}"
echo ' -> OK'

echo -n 'Xdebug client host should be localhost by default'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.client_host => localhost"
echo ' -> OK'

echo -n 'Xdebug idekey should be PHPSTORM'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.idekey => PHPSTORM"
echo ' -> OK'

echo -n 'Xdebug mode should be debug'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.mode => debug"
echo ' -> OK'

echo -n 'Xdebug start_with_request should be default'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.start_with_request => default"
echo ' -> OK'
