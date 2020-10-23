FROM php:7.2.33-fpm

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
    && apt-get install -y git zip procps unixodbc-dev gnupg vim cron rsyslog \
    # 取消 rsyslog.conf 对 cron 的注释
    && sed -i 's/^#cron/cron/' /etc/rsyslog.conf

# 安装 SQL Server ODBC driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && sed -i 's,^\(MinProtocol[ ]*=\).*,\1'TLSv1.0',g' /etc/ssl/openssl.cnf \
    && sed -i 's,^\(CipherString[ ]*=\).*,\1'DEFAULT@SECLEVEL=1',g' /etc/ssl/openssl.cnf


# 安装 PHP 扩展
RUN docker-php-ext-install bcmath pdo_mysql \
    && pecl install sqlsrv pdo_sqlsrv
    
# 复制配置文件
COPY ./php.production.ini "$PHP_INI_DIR/php.ini"