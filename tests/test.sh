#!/usr/bin/env sh

for FILE in /tmp/tests/test_*.sh; do
  if ! sh "${FILE}"; then
    echo ' -> Failed'
    exit 1
  fi
done
