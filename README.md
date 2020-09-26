# php-composer
* 集成了 `composer` 的 `PHP` 官方镜像，为 `Laravel` 开发和部署设计
* 这是一个为 **生产环境** 设计的镜像

# PHP 官方镜像
* 版本: `php:7.4.10-fpm`
* 官方镜像中存在一些扩展，但是没有开启，列表如下：
```
bcmath bz2 calendar ctype curl dba dom enchant exif ffi fileinfo filter ftp gd gettext gmp hash iconv imap intl json ldap mbstring mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline reflection session shmop simplexml snmp soap sockets sodium spl standard sysvmsg sysvsem sysvshm tidy tokenizer xml xmlreader xmlrpc xmlwriter xsl zend_test zip
```
* 上述的部分已经编译到了 PHP 中，可以使用 `php -i` 查看
* 开启扩展使用镜像的内置命令:
```shell
docker-php-ext-install [-jN] [--ini-name file.ini] ext-name [ext-name ...]
```
* `laravel` 中需要，但是 **非默认** 开启的扩展如下:
    - bcmath
    - pdo_mysql

# 额外安装的工具
* git
* unzip

# 端口使用说明
* `9000`: `php-fpm` 默认开启的端口，通常需要暴露到宿主机

# php.ini 的修改部分
```ini
upload_max_filesize = 50M
post_max_size = 50M
```