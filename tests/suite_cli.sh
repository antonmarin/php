#!/usr/bin/env sh

files="/tmp/tests/test_vars.sh
/tmp/tests/test_php.sh
/tmp/tests/test_composer.sh
/tmp/tests/test_xdebug${XDEBUG_VERSION}.sh"

# shellcheck disable=SC1091
. /etc/os-release

for FILE in $files
do
  if ! sh "${FILE}"; then
    echo ' -> Failed'
    echo -e "\\e[31mTests with version ${PHP_VERSION}-cli-${ID} failed\\e[0m"
    exit 1
  fi
done

echo -e "\\e[32mTests with version ${PHP_VERSION}-cli-${ID} successful\\e[0m"
