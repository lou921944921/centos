#!/bin/bash
touch /etc/ss-config.json  
echo '{
    "server": "0.0.0.0",
    "local_port": 1080,
    "port_password":
    {
    "137":"123456",
    "138":"123456",
    "139":"123456"
    },
    "timeout": 600,
    "method": "aes-256-cfb"
}' > /etc/ss-config.json
chmod 755 /etc/ss-config.json
yum -y update
yum -y install python-setuptools && easy_install pip 
pip install shadowsocks
ssserver -c /etc/ss-config.json -d start
sed -i '2a ssserver -c /etc/ss-config.json -d start' /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
yum clean all
