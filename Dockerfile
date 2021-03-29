FROM php:7.2.33-fpm

WORKDIR /var/www

# 删除 html 文件夹
RUN rm -rf /var/www/html

# 安装 composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm -f composer-setup.php \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# 安装工具
# - git
# - zip
# - vim
# - procps: ps 进程命令
# - iputils-ping: ping 命令
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git zip vim procps iputils-ping

# 安装 cron 
RUN apt-get install -y cron rsyslog \
    # 取消 rsyslog.conf 对 cron 的注释
    && sed -i 's/^#cron/cron/' /etc/rsyslog.conf

# 下载 php-cs-fixer
RUN curl -L https://cs.symfony.com/download/php-cs-fixer-v2.phar -o php-cs-fixer \
    && chmod a+x php-cs-fixer \
    && mv php-cs-fixer /usr/local/bin/php-cs-fixer

# 安装/开启 PHP 扩展
# - xdebug
# - pdo_mysql
# - bcmath : laravel 必须
RUN docker-php-ext-install bcmath pdo_mysql \
    && pecl install xdebug

# 复制配置文件
COPY ./php.development.ini "$PHP_INI_DIR/php.ini"