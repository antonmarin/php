# PHP image 

[![dockeri.co](https://dockeri.co/image/antonmarin/php)](https://hub.docker.com/r/antonmarin/php/)

Basic php image with composer installed and xdebug installed but disabled.

## Goal and content motivation

library/php is great, but not enough. Almost every php project uses composer, as it
became standard to create php packages. And we often use xdebug while develop.
So it includes latest composer and latest xdebug available at moment of build.

## Usage

### PHP

Use environment variable to alter php.ini settings:

- TZ=date.timezone
- PHP_INI_MEMORY_LIMIT
- PHP_INI_ERROR_REPORTING int from [Integer value calculator](https://maximivanov.github.io/php-error-reporting-calculator/)
- PHP_INI_DISPLAY_ERRORS

### Composer

Composer is built-in. Just use it as usual `composer ...` inside container
Variables to setup Composer:

- COMPOSER_MEMORY_LIMIT

### Xdebug

Xdebug is installed, but disabled. 
To enable xdebug in cli just `php -dzend_extension=xdebug.so` or setup your IDE interpreter.
To enable xdebug in fpm use `php-fpm -d zend_extension=xdebug.so` command to start container.
To enable profiling add `-d xdebug.profiler_enable=On` and `-d xdebug.auto_trace=1` to enable tracing.
Profiling and tracing files are stored at `/tmp`
Variables to setup Xdebug:

- [XDEBUG_CONFIG](https://xdebug.org/docs/remote)
- PHP_INI_XDEBUG_REMOTE_HOST

### Examples

#### Manual run php cli

    docker run --rm \
        -e PHP_INI_XDEBUG_REMOTE_HOST=host.docker.internal \
        antonmarin/php:7.4-alpine-cli \
        php -dzend_extension=xdebug.so -i

#### Use composer

    docker run --rm antonmarin/php:7.4-alpine-cli composer show --platform 

#### docker-compose

    services:
      php:
        image: antonmarin/php:7.4-alpine-fpm
        environment:
          XDEBUG_CONFIG: remote_host={{YOUR_IP_ADDRESS}}
          PHP_IDE_CONFIG: serverName={{YOUR_APPLICATION_NAME}}
        command:
          - php-fpm
          - -d
          - zend_extension=xdebug.so

#### PhpStorm interpreter

[PHPStorm](https://www.jetbrains.com/help/phpstorm/2019.3/php-interpreters.html) 
section "Debugger extension" for example.
