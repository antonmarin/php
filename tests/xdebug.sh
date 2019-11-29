#!/usr/bin/env sh
set -eu

echo -n 'Xdebug should be enabled if zend_extension is set'
php -dzend_extension=xdebug.so -m | grep -q xdebug
echo ' -> OK'

echo -n 'Xdebug should be remote enabled'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.remote_enable => On"
echo ' -> OK'

echo -n 'Xdebug remote host should be localhost by default'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.remote_host => localhost"
echo ' -> OK'

echo -n 'Xdebug remote host should equal to ${PHP_INI_XDEBUG_REMOTE_HOST} if set'
export EXPECTED_XDEBUG_REMOTE_HOST=localhost
php -dzend_extension=xdebug.so -i | grep -q "xdebug.remote_host => ${EXPECTED_XDEBUG_REMOTE_HOST}"
echo ' -> OK'

echo -n 'Xdebug idekey should be PHPSTORM'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.idekey => PHPSTORM"
echo ' -> OK'

echo -n 'Xdebug autostart should be disabled'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.remote_autostart => Off"
echo ' -> OK'
