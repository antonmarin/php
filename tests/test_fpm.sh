#!/usr/bin/env sh
set -eu

echo '9000 port should be opened'
nc -zv fpm 9000

echo 'php-fpm config should be valid'
php-fpm -t

echo -n 'xdebug should be enabled if zend_extension=xdebug.so is passed to cmd'
php-fpm -d zend_extension=xdebug.so -i | grep -q "xdebug support => enabled"
echo ' -> OK'

echo -n 'xdebug should be disabled if zend_extension=xdebug.so is not passed to cmd'
set +e
php-fpm -i | grep -q "xdebug support => enabled"
ret=$?
set -e
if [ $ret -ne 0 ]; then
  echo ' -> OK'
else
  exit 1
fi

apk --update add fcgi

echo -n 'fcgi should be available'
REQUEST_METHOD=GET \
cgi-fcgi -bind -connect fpm:9000 | grep -q 'X-Powered-By: PHP'
echo ' -> OK'

echo -n 'xdebug should not be loaded by default'
SCRIPT_FILENAME=/tmp/tests/test.php \
DOCUMENT_ROOT=/tmp/tests/ \
PATH_INFO=/tmp/tests/test.php \
REQUEST_METHOD=GET \
cgi-fcgi -bind -connect fpm:9000 | grep -q '"xdebug loaded":false'
echo ' -> OK'

echo -n 'xdebug should be loaded by command'
SCRIPT_FILENAME=/tmp/tests/test.php \
DOCUMENT_ROOT=/tmp/tests/ \
PATH_INFO=/tmp/tests/test.php \
REQUEST_METHOD=GET \
cgi-fcgi -bind -connect fpm-xdebug-by-command:9000 | grep -q '"xdebug loaded":true'
echo ' -> OK'
