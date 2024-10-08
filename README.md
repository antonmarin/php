# PHP image

[![dockeri.co](https://dockeri.co/image/antonmarin/php)](https://hub.docker.com/r/antonmarin/php/)

Basic php image with composer installed and xdebug installed but disabled.

## Goal and content motivation

library/php is great, but not enough. Almost every php project uses composer, as it
became standard to create php packages. And we often use xdebug while develop.
So it includes the latest composer and latest xdebug available at moment of build.

## Usage

### PHP

Use environment variable to alter php.ini settings:

- TZ=date.timezone
- PHP_INI_MEMORY_LIMIT
- PHP_INI_ERROR_REPORTING int from [Integer value calculator](https://maximivanov.github.io/php-error-reporting-calculator/)
- PHP_INI_DISPLAY_ERRORS 1/0
- PHP_INI_SESSION_USE_COOKIES 1/0

### Composer

Composer is built-in. Just use it as usual `composer ...` inside container.

Variables to set up Composer:

- COMPOSER_MEMORY_LIMIT

### Extensions

#### PDO

MySQL and PostgreSQL extensions installed and disabled.

To enable in cli `php -dextension=pdo_mysql.so` or `php -dextension=pdo_pgsql.so`.
To enable in fpm use `php-fpm -dextension=pdo_mysql.so` or `php-fpm -dextension=pdo_pgsql.so` to start container.

#### Xdebug

Xdebug is installed, but disabled. [Beginning from 7.3](https://xdebug.org/docs/compat) Xdebug3 is bundled.

To enable xdebug in cli just `php -dzend_extension=xdebug.so` or setup your IDE interpreter.
To enable xdebug in fpm use `php-fpm -d zend_extension=xdebug.so` command to start container.
Profiling and tracing files are stored at `/tmp`

Variables to setup Xdebug:

- [XDEBUG_CONFIG](https://xdebug.org/docs/all_settings#XDEBUG_CONFIG)
- PHP_INI_XDEBUG_REMOTE_HOST. Sets xdebug.remote_host for Xdebug2 or xdebug.client_host for Xdebug3
- For Jetbrains IDE: [PHP_IDE_CONFIG](https://blog.jetbrains.com/phpstorm/2012/03/new-in-4-0-easier-debugging-of-remote-php-command-line-scripts/)

##### Xdebug 3

To enable profiling add `-d xdebug.mode=profile` or `-d xdebug.mode=trace` to enable tracing.

##### Xdebug 2

To enable profiling add `-d xdebug.profiler_enable=On` and `-d xdebug.auto_trace=1` to enable tracing.

Notice that php built in server doesn't populate $_ENV to $_SERVER, so it doesn't
support [PHP_IDE_CONFIG](https://blog.jetbrains.com/phpstorm/2012/03/new-in-4-0-easier-debugging-of-remote-php-command-line-scripts/)
env variable to set up server mapping

### Examples

#### Manual run php cli

    docker run --rm \
        -e PHP_INI_SESSION_USE_COOKIES=0 \
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
          PHP_INI_SESSION_USE_COOKIES: 0
          PHP_INI_XDEBUG_REMOTE_HOST: {{YOUR_IP_ADDRESS}}
          PHP_IDE_CONFIG: serverName={{YOUR_APPLICATION_NAME}}
        command:
          - php-fpm
          - -d
          - zend_extension=xdebug.so

#### PhpStorm interpreter

[PHPStorm](https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html#on_demand_mode)
