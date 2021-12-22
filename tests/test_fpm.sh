#!/usr/bin/env sh
set -eu

apk --update add fcgi

echo '9000 port should be opened'
nc -zv fpm 9000

echo 'php-fpm config should be valid'
php-fpm -t

echo -n 'xdebug should be enabled if zend_extension=xdebug.so is passed to cmd'
php-fpm -d zend_extension=xdebug.so -m | grep -q "xdebug"
echo ' -> OK'

echo -n 'xdebug should be disabled if zend_extension=xdebug.so is not passed to cmd'
php-fpm -m | grep -qv "xdebug"
echo ' -> OK'

echo 'Received test default result:'
TEST_RESULT_DEFAULT=$(SCRIPT_FILENAME=/var/www/html/test.php \
DOCUMENT_ROOT=/var/www/html/ \
PATH_INFO=/var/www/html/test.php \
REQUEST_METHOD=GET \
cgi-fcgi -bind -connect fpm:9000)
echo "$TEST_RESULT_DEFAULT"
echo 'Received test alternative result:'
TEST_RESULT_ALTERNATIVE=$(SCRIPT_FILENAME=/var/www/html/test.php \
DOCUMENT_ROOT=/var/www/html/ \
PATH_INFO=/var/www/html/test.php \
REQUEST_METHOD=GET \
cgi-fcgi -bind -connect fpm-alternative:9000)
echo "$TEST_RESULT_ALTERNATIVE"

echo -n 'fcgi should be available'
REQUEST_METHOD=GET \
echo "$TEST_RESULT_DEFAULT" | grep -q 'X-Powered-By: PHP'
echo ' -> OK'

echo -n 'xdebug should not be loaded by default'
echo "$TEST_RESULT_DEFAULT" | grep -q '"xdebug loaded":false'
echo ' -> OK'

echo -n 'xdebug should be loaded by command'
echo "$TEST_RESULT_ALTERNATIVE" | grep -q '"xdebug loaded":true'
echo ' -> OK'

echo -n 'session cookies should be enabled by default'
echo "$TEST_RESULT_DEFAULT" | grep -q '"session cookies enabled":"1"'
echo ' -> OK'

echo -n 'session cookies should be disabled when PHP_INI_SESSION_USE_COOKIES=0'
echo "$TEST_RESULT_ALTERNATIVE" | grep -q '"session cookies enabled":"0"'
echo ' -> OK'
