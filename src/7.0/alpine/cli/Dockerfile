FROM composer:1 as composer
FROM php:7.0-cli-alpine

ENV HOME=/root

ENV TZ=Etc/UTC \
    PHP_INI_MEMORY_LIMIT=128M \
    PHP_INI_ERROR_REPORTING=22527 \
    PHP_INI_DISPLAY_ERRORS=0 \
    PHP_INI_SESSION_USE_COOKIES=1
RUN rm -f "${PHP_INI_DIR}"/php.ini*
COPY php.ini "${PHP_INI_DIR}"/

ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_MEMORY_LIMIT=-1
COPY --from=composer /usr/bin/composer /usr/local/bin/
COPY --from=composer /tmp/keys.dev.pub /tmp/keys.tags.pub ${HOME}/.composer/

# dependencies required for running "phpize"
# these get automatically installed and removed by "docker-php-ext-*" (unless they're already installed)
ENV PHPIZE_DEPS \
    autoconf \
    dpkg-dev dpkg \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    pkgconf \
    re2c

# hadolint ignore=DL3018
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    && \
    pecl install xdebug-2.8.1 \
    && \
    apk del --no-network .build-deps && \
    rm -rf /tmp/pear ~/.pearrc \
    && docker-php-ext-enable opcache

ENV PHP_INI_XDEBUG_REMOTE_HOST=localhost XDEBUG_VERSION=2
COPY xdebug/xdebug${XDEBUG_VERSION}.ini ${PHP_INI_DIR}/conf.d/xdebug.ini
