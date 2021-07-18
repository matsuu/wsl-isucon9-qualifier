#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y ansible curl git 

git clone --depth=1 https://github.com/matsuu/ansible-isucon9-qualify.git
cd ansible-isucon9-qualify
ansible-playbook --connection=local -i webapp, standalone.yml
cd ..
rm -rf ansible-isucon9-qualify
apt-get remove -y --purge ansible
apt-get autoremove -y
#
