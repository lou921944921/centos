#!/bin/bash
yum -y update
yum -y install python-setuptools && easy_install pip 
pip -y install shadowsocks
echo '{
    "server": "0.0.0.0",
    "server_port": 8388,
    "local_port": 1080,
    "password": "123456",
    "timeout": 600,
    "method": "aes-256-cfb"
}' > /etc/ss-config.json
ssserver -c /etc/ss-config.json -d start
sed -i '2a /usr/local/bin/ssserver -c /etc/ss-config.json' /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
yum clean all
