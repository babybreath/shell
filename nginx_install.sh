#!/bin/sh

# yum install -y gcc

# 创建CA的私钥
# openssl genrsa -out ca.key 2048
# 创建CA自签名证书
# openssl req -x509 -new -nodes -key ca.key -subj "/CN=localhost" -days 36500 -out ca.crt

# 变量申明
filepath=$(cd "$(dirname "$0")"; pwd)
nginx_prefix=$filepath/Nginx
tempPath=$(pwd)/temp

# pcre-8.40 出错
pcreVersion=pcre-8.39
pcreVersionNumber=8.39
zlibVersion=zlib-1.2.11
opensslVersion=openssl-1.0.2k
nginxVersion=nginx-1.12.0

pcreUrl=http://jaist.dl.sourceforge.net/project/pcre/pcre/${pcreVersionNumber}/${pcreVersion}.tar.gz
zlibUrl=http://zlib.net/${zlibVersion}.tar.gz
opensslUrl=http://www.openssl.org/source/${opensslVersion}.tar.gz
nginxUrl=http://nginx.org/download/${nginxVersion}.tar.gz

mkdir $nginx_prefix
mkdir $tempPath
cd $tempPath

echo "获取pcre源码"
wget $pcreUrl
echo "获取zlib源码"
wget $zlibUrl
echo "获取openssl源码"
wget $opensslUrl
echo "获取nginx源码"
wget $nginxUrl
echo "解压pcre源码"
tar -zxf ${pcreVersion}.tar.gz
echo "解压zlib源码"
tar -zxf ${zlibVersion}.tar.gz
echo "解压openssl源码"
tar -zxf ${opensslVersion}.tar.gz
echo "解压nginx源码"
tar -zxf ${nginxVersion}.tar.gz


cd $nginxVersion
echo "开始安装nginx"
./configure --prefix=${nginx_prefix} --with-http_ssl_module --with-http_v2_module --with-openssl=${tempPath}/${opensslVersion} --with-pcre=${tempPath}/${pcreVersion} --with-zlib=${tempPath}/${zlibVersion}

make & make install
