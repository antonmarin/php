#!/usr/bin/env sh

files="/tmp/tests/test_php.sh
/tmp/tests/test_composer.sh
/tmp/tests/test_xdebug.sh
/tmp/tests/test_fpm.sh"
for FILE in $files
do
  if ! sh "${FILE}"; then
    echo ' -> Failed'
    exit 1
  fi
done

# shellcheck disable=SC1091
. /etc/os-release
echo -e "\\e[32mTests with version ${PHP_VERSION}-fpm-${ID} successfull\\e[0m"
