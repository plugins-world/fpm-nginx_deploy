#!/usr/bin/env bash

set -e

DIR="/www/wwwroot/project-name/"
SERVER_IP="hostip,"
SERVER_ENV="ansible_host_key_checking=false ansible_user=root"
if [ ! -z $SSH_PASSWORD ];then
    SERVER_ENV="ansible_host_key_checking=false ansible_user=root ansible_ssh_pass=$SSH_PASSWORD"
fi

# 更新代码，安装依赖，执行迁移，更改权限
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m shell -a "chdir=${DIR} git pull origin master"
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m shell -a "chdir=${DIR} composer --no-interaction install -vvv"
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m shell -a "chdir=${DIR} php artisan migrate"
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m shell -a "chdir=${DIR} chown -R www:www ."
