#!/usr/bin/env sh
set -eu

echo -n 'Mysqlnd should be enabled'
php -m | grep -q mysqlnd
echo ' -> OK'

echo -n 'pdo_mysql should be disabled'
php -m | grep -qv pdo_mysql
echo ' -> OK'

echo -n 'pdo_mysql should be enabled when property set'
php -dextension=pdo_mysql.so -m | grep -q pdo_mysql
echo ' -> OK'
