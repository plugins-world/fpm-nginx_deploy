#FROM fpm-nginx:latest
FROM registry.cn-shenzhen.aliyuncs.com/mouyong/fpm-nginx:latest

MAINTAINER MouYong <mouyong@plugins-world.cn>

RUN  rm -rf /var/www/html

COPY . /var/www/html

RUN cd /var/www/html \
  && composer install \
  --optimize-autoloader \
  --ignore-platform-reqs \
  --prefer-dist \
  --no-interaction \
  --no-plugins \
  --no-scripts \
  --no-suggest

COPY ./deploy/app/supervisord-queue.conf /etc/supervisor/conf.d/queue.conf

COPY ./deploy/app/cron-run.sh /usr/local/bin/cron-run
COPY ./deploy/app/docker-run-fpm.sh /usr/local/bin/docker-run

RUN chown -R www-data:www-data /var/www && \
  chmod 0777 -R /var/www/html/bootstrap/cache /var/www/html/storage && \
  chmod +x /usr/local/bin/docker-run /usr/local/bin/cron-run /usr/local/bin/docker-php-entrypoint

WORKDIR /var/www/html

VOLUME /var/www/html
VOLUME /var/www/html/storage
VOLUME /var/www/html/public
