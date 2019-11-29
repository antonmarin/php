# PHP image 

Basic php image with composer installed and xdebug installed but disabled.

## Goal and content motivation

library/php is great, but not enough. Almost every php project uses composer, as it
became standard to create php packages. And we often use xdebug while develop, so
it is included. So it includes latest composer and latest xdebug available at
moment of build.

## Usage

### PHP

Use environment variable to alter php.ini settings:

- variables whould be here

### Composer

Composer is built-in. Just use it as usual `composer ...` inside container

### Xdebug

Xdebug is installed, but disabled. 
To enable xdebug in cli just `php -dzend_extension=xdebug.so` or setup your IDE interpreter.

[PHPStorm](https://www.jetbrains.com/help/phpstorm/2019.3/php-interpreters.html) 
section "Debugger extension" for example.

Variables to setup Xdebug:

- PHP_INI_XDEBUG_REMOTE_HOST
