#!/bin/bash   
yum -y update
yum -y install  gcc
wget http://www.boutell.com/rinetd/http/rinetd.tar.gz 
tar zxvf rinetd.tar.gz 
cd rinetd 
mkdir -p /usr/man/man8
make && make install
echo  '0.0.0.0 443 192.184.12.180 443' > /etc/rinetd.conf
/usr/sbin/rinetd -c /etc/rinetd.conf
sed -i '1a /usr/sbin/rinetd -c /etc/rinetd.conf' /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
