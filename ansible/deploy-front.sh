#!/usr/bin/env bash

set -e

DIR="/www/wwwroot/project-name/"
SERVER_IP="hostip,"
SERVER_ENV="ansible_host_key_checking=false ansible_user=root"
if [ ! -z $SSH_PASSWORD ];then
    SERVER_ENV="ansible_host_key_checking=false ansible_user=root ansible_ssh_pass=$SSH_PASSWORD"
fi

# 构建静态文件并打包
if [ ! -f dist.zip ]; then
    # ./node_modules/.bin/vite build --config "./config/vite.config.prod.ts"
    # zip -r dist.zip dist -x "*node_modules/*" -x "*vendor/*"
    ./node_modules/.bin/vitepress build
    zip -r dist.zip .vitepress/dist/ -x "*node_modules/*" -x "*vendor/*"
fi

# 部署服务器
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m shell -a "chdir=/ mkdir -p ${DIR}"
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m shell -a "chattr -i ${DIR}/.user.ini || true; rm -f ${DIR}/{.user.ini,index.html,404.html,.htaccess} || true"
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m unarchive -a "src=./dist.zip dest=${DIR}"
time ansible all -i "${SERVER_IP}" -e "$SERVER_ENV" -m shell -a "chdir=${DIR} chown -R www:www ."

if [ -z $SSH_PASSWORD ];then
    # time cd aliyun-fc-demo/supply-demand-test/ && s deploy
    # time rm -rf dist/ dist.zip
    time rm -rf ./vitepress/dist/ dist.zip
fi
