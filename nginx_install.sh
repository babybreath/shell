#!/bin/sh

mkdir nginx_soft
filepath=$(cd "$(dirname "$0")"; pwd)
nginx_prefix=$filepath/nginx_soft

cd $nginx_prefix

pcreUrl=ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
zlibUrl=http://zlib.net/zlib-1.2.8.tar.gz
opensslUrl=http://www.openssl.org/source/openssl-1.0.1.tar.gz
nginxUrl=http://nginx.org/download/nginx-1.8.1.tar.gz

wget $pcreUrl

wget $zlibUrl

wget $opensslUrl

wget $nginxUrl

tar -zxvf pcre-8.38.tar.gz

tar -zxvf zlib-1.2.8.tar.gz

tar -zxvf openssl-1.0.1.tar.gz

tar -zxvf nginx-1.8.1.tar.gz

cd nginx-1.8.1

./configure 
--prefix=$nginx_prefix/nginx 
--with-http_ssl_module 
--with-openssl=$nginx_prefix/openssl-1.0.1 
--with-pcre=$nginx_prefix/pcre-8.38 
--with-zlib=$nginx_prefix/zlib-1.2.8

make & make install

