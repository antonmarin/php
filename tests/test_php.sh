#!/usr/bin/env sh
set -eu

echo -n 'PHP Default date.timezone should be Etc/UTC'
php -i | grep -q "date.timezone => Etc/UTC"
echo ' -> OK'

echo -n 'PHP TZ should set date.timezone'
TZ=Europe/Moscow php -i | grep -q "date.timezone => Europe/Moscow"
echo ' -> OK'

echo -n 'PHP user_ini.filename should be disabled'
php -i | grep -q "user_ini.filename => no value"
echo ' -> OK'

echo -n 'PHP Short open tag should be disabled'
php -i | grep -q "short_open_tag => Off"
echo ' -> OK'

echo -n 'PHP ASP tag should be disabled'
php -i | grep -q "asp_tags => Off"
echo ' -> OK'

echo -n 'PHP zend.enable_gc should be enabled'
php -i | grep -q "zend.enable_gc => On"
echo ' -> OK'

echo -n 'PHP default memory_limit should be 128M'
php -i | grep -q "memory_limit => 128M"
echo ' -> OK'

echo -n 'PHP PHP_INI_MEMORY_LIMIT should set memory_limit'
PHP_INI_MEMORY_LIMIT=256M php -i | grep -q "memory_limit => 256M"
echo ' -> OK'


