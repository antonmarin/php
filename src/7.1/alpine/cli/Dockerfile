FROM composer:1 as composer
FROM php:7.1-cli-alpine

ENV HOME=/root

ENV TZ=Etc/UTC \
    PHP_INI_MEMORY_LIMIT=128M \
    PHP_INI_ERROR_REPORTING=22527 \
    PHP_INI_DISPLAY_ERRORS=0
RUN rm -f "${PHP_INI_DIR}"/php.ini*
COPY php.ini "${PHP_INI_DIR}"/

ENV COMPOSER_ALLOW_SUPERUSER 1
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
    pecl install xdebug \
    && \
    apk del --no-network .build-deps && \
    rm -rf /tmp/pear ~/.pearrc

ENV PHP_INI_XDEBUG_REMOTE_HOST=localhost
COPY xdebug.ini ${PHP_INI_DIR}/conf.d/
