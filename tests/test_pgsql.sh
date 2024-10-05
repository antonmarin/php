#!/usr/bin/env sh
set -eu

echo -n 'pdo_pgsql should be disabled'
php -m | grep -qv pdo_pgsql
echo ' -> OK'

echo -n 'pdo_pgsql should be enabled when property set'
php -dextension=pdo_pgsql.so -m | grep -q pdo_pgsql
echo ' -> OK'
