FROM php:5.6-cli-alpine

ENV HOME=/root

ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/
COPY --from=composer:latest /tmp/keys.dev.pub /tmp/keys.tags.pub ${HOME}/.composer/
