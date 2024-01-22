FROM php:8.3.2-cli-alpine3.19

ARG LOCAL_USER_ID_ARG=82
ARG LOCAL_GROUP_ID_ARG=82

ENV LOCAL_USER_ID=${LOCAL_USER_ID_ARG} \
    LOCAL_GROUP_ID=${LOCAL_GROUP_ID_ARG} \
    COMPOSER_MEMORY_LIMIT=-1 \
    TZ=Asia/Yekaterinburg \
    XDEBUG_MODE="develop,debug,coverage"

RUN apk update && apk -U upgrade && apk add --no-cache shadow zip libzip-dev ca-certificates tzdata linux-headers $PHPIZE_DEPS \
    && update-ca-certificates \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install zip \
    && groupmod -g ${LOCAL_GROUP_ID} www-data && usermod -u ${LOCAL_USER_ID} -g ${LOCAL_GROUP_ID} www-data \
    && chown -R ${LOCAL_USER_ID}:${LOCAL_GROUP_ID} /home/www-data

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer \
    && mkdir -p /home/www-data/application

WORKDIR /home/www-data/application

USER www-data