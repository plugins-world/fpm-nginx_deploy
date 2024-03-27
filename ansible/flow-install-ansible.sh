# input your command here

set -ex

cat /etc/issue

# export SSH_PASSWORD=${TENCENT_SERVER_1_SSH_PASSWORD}

apt-get update && apt-get install -y software-properties-common && apt-add-repository --yes --update ppa:ansible/ansible && apt-get install -y ansible

yarn install

./deploy.sh
