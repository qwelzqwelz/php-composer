FROM php:7.1.33-fpm

# 配置文件
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# 安装 composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm -f composer-setup.php \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/