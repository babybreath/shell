#!/bin/sh

# 变量申明
node_prefix=/usr/node/v4.4.3

rm -fr ${node_prefix} && mkdir -p ${node_prefix}
cd ${node_prefix}

wget http://nodejs.org/dist/v4.4.3/node-v4.4.3-linux-x64.tar.gz

tar -xvf node-v4.4.3-linux-x64.tar.gz

echo "export PATH=${node_prefix}/node-v4.4.3-linux-x64/bin:\$PATH" >> ~/.bash_profile &&
export PATH=${node_prefix}/node-v4.4.3-linux-x64/bin:$PATH

echo "npm install pm2 -g"
npm install pm2 -g