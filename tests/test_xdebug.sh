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
export EXPECTED_XDEBUG_REMOTE_HOST=127.0.0.1
PHP_INI_XDEBUG_REMOTE_HOST=${EXPECTED_XDEBUG_REMOTE_HOST} php -dzend_extension=xdebug.so \
  -i | grep -q "xdebug.remote_host => ${EXPECTED_XDEBUG_REMOTE_HOST}"
echo ' -> OK'

echo -n 'Xdebug idekey should be PHPSTORM'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.idekey => PHPSTORM"
echo ' -> OK'

echo -n 'Xdebug autostart should be disabled'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.remote_autostart => Off"
echo ' -> OK'

echo -n 'Xdebug profiler trigger should be enabled'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.profiler_enable_trigger => On"
echo ' -> OK'

echo -n 'Xdebug tracing trigger should be enabled'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.trace_enable_trigger => On"
echo ' -> OK'

echo -n 'Xdebug tracing function parameters should be by value'
php -dzend_extension=xdebug.so -i | grep -q "xdebug.collect_params => 3"
echo ' -> OK'
