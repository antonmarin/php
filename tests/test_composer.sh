#!/usr/bin/env sh
set -eu

echo -n 'Composer should be allowed as superuser'
echo "${COMPOSER_ALLOW_SUPERUSER}" | grep -q 1
echo ' -> OK'

echo -n 'Composer should be not limited by memory'
echo "${COMPOSER_MEMORY_LIMIT}" | grep -q '\-1'
echo ' -> OK'

echo -n 'Composer should be available and at /usr/local/bin/composer'
command -v composer | grep -q "/usr/local/bin/composer"
echo ' -> OK'

echo -n 'Composer should be diagnosed as OK'
composer diagnose >/dev/null
echo ' -> OK'

echo -n 'Composer should be able to require package'
composer require antonmarin/traceable-pdo 2>/dev/null
echo ' -> OK'
