FROM php:7.4.10-fpm

WORKDIR /var/www

# 删除 html 文件夹
RUN rm -rf /var/www/html

# 安装 composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm -f composer-setup.php \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# 安装 Git 和其他依赖
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git zip

# 复制配置文件
COPY ./php.production.ini "$PHP_INI_DIR/php.ini"