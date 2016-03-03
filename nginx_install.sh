#!/bin/sh

# 变量申明
filepath=$(cd "$(dirname "$0")"; pwd)
nginx_prefix=$filepath/nginx_dir

pcreVersion=pcre-8.38
pcreVersionNumber=8.38
zlibVersion=zlib-1.2.8
opensslVersion=openssl-1.0.2g
nginxVersion=nginx-1.8.1

pcreUrl=http://jaist.dl.sourceforge.net/project/pcre/pcre/$pcreVersionNumber/$pcreVersion.tar.gz
zlibUrl=http://zlib.net/$zlibVersion.tar.gz
opensslUrl=http://www.openssl.org/source/$opensslVersion.tar.gz
nginxUrl=http://nginx.org/download/$nginxVersion.tar.gz

mkdir $nginx_prefix
cd $nginx_prefix


echo "获取pcre源码"
wget $pcreUrl
echo "获取zlib源码"
wget $zlibUrl
echo "获取openssl源码"
wget $opensslUrl
echo "获取nginx源码"
wget $nginxUrl
echo "解压pcre源码"
tar -zxf $pcreVersion.tar.gz
echo "解压zlib源码"
tar -zxf $zlibVersion.tar.gz
echo "解压openssl源码"
tar -zxf $opensslVersion.tar.gz
echo "解压nginx源码"
tar -zxf $nginxVersion.tar.gz


cd $nginxVersion
echo "开始安装nginx"
./configure --prefix=$nginx_prefix/nginx --with-http_ssl_module --with-openssl=$nginx_prefix/$opensslVersion --with-pcre=$nginx_prefix/$pcreVersion --with-zlib=$nginx_prefix/$zlibVersion

make & make install

