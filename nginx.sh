#!/bin/bash   
yum -y update
yum install -y gcc gcc-c++
yum -y install zlib zlib-devel pcre pcre-devel openssl openssl-devel
wget http://nginx.org/download/nginx-1.9.14.tar.gz
tar -zxvf nginx-1.9.14.tar.gz
cd nginx-1.9.14
./configure --prefix=/etc/nginx  --with-stream  && make && make install
sed -i '$a stream {
    upstream warframe {
        server 192.184.12.180:443           max_fails=3 fail_timeout=30s;
    }


    server {
        listen 443;
        proxy_connect_timeout 30s;
        proxy_timeout 30s;
        proxy_pass warframe;
    }

}' /etc/nginx/conf/nginx.conf
/etc/nginx/sbin/nginx -c /etc/nginx/conf/nginx.conf
sed -i '1a /etc/nginx/sbin/nginx -c /etc/nginx/conf/nginx.conf' /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
yum clean all

