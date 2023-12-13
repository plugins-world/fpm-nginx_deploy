FROM php:8.2-fpm

MAINTAINER MouYong <mouyong@plugins-world.cn>

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANGUAGE=C.UTF-8

# 安装基础依赖，基础工具
RUN apt-get update && apt-get upgrade -y &&  \
  pecl channel-update pecl.php.net && \
  apt-get install -yqq --no-install-recommends \
  libz-dev \
  libpq-dev \
  libssl-dev \
  nginx \
  wget \
  vim \
  supervisor \
  net-tools \
  curl \
  procps \
  cron

# 复制php.ini文件，开启php扩展包
RUN docker-php-source extract

# 复制php.ini文件，开启php扩展包
# RUN cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini
COPY php/php.ini /usr/local/etc/php/php.ini
COPY php/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# 安装必备包
RUN docker-php-ext-install pdo_mysql bcmath opcache

# gd
RUN apt-get install -y \
  libfreetype-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd

# zip
RUN apt-get install -y libzip-dev && \
  docker-php-ext-configure zip && \
  docker-php-ext-install zip && \
  php -m | grep -q 'zip'

# bz2
RUN apt-get -y install libbz2-dev && \
  docker-php-ext-install bz2

# redis
RUN pecl install -o -f redis && \
  rm -rf /tmp/pear && \
  docker-php-ext-enable redis

# swoole
RUN pecl install -o -f swoole && \
  docker-php-ext-enable swoole

# xlswriter
RUN pecl install -o -f xlswriter && \
  docker-php-ext-enable xlswriter

# 删除安装完的源码包
RUN docker-php-source delete && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/www/html/*

# 初始化自定义启动脚本
COPY ./docker-run.sh /usr/local/bin/docker-run
# nginx 使用supervisor托管
COPY ./supervosprd-nginx.conf /etc/supervisor/conf.d/nginx.conf
# php-fpm 使用supervisor托管
COPY ./supervosprd-php-fpm.conf /etc/supervisor/conf.d/php-fpm.conf
# 覆盖 nginx 默认配置
COPY ./nginx-default.conf /etc/nginx/sites-enabled/default
# 修改容器启动命令
COPY ./docker-php-entrypoint.sh /usr/local/bin/docker-php-entrypoint

RUN chmod +x /usr/local/bin/docker-run /usr/local/bin/docker-php-entrypoint

# composer
RUN wget https://mirrors.aliyun.com/composer/composer.phar && \
  chmod +x composer.phar && \
  mv composer.phar /usr/local/bin/composer && \
  echo "composer download successful"

WORKDIR /var/www/html/public

RUN echo "<?php phpinfo();" > /var/www/html/public/index.php \
  && echo "<h1>Hello World!</h1>" > /var/www/html/public/index.html

RUN service supervisor start

EXPOSE 80
