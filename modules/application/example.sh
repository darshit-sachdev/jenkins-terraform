#!/bin/bash
apt-get update
apt-get -y install net-tools nginx
apt install git-all
git clone https://github.com/bhaumik-crest/vue-projects.git
cd /var/www/html
sudo rm index.html
sudo cp -r /vue-projects/MonsterGame/. ./
