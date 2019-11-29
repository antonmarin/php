#!/usr/bin/env sh

for FILE in /tmp/tests/test_*.sh; do
  if ! sh "${FILE}"; then
    echo ' -> Failed'
    exit 1
  fi
done

# shellcheck disable=SC1091
. /etc/os-release
echo -e "\\e[32mTests with version ${PHP_VERSION}-${ID} successfull\\e[0m"
