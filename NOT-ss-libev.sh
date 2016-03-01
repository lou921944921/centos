#!/bin/bash
yum -y update
yum -y install git gcc openssl-devel
echo  '[librehat-shadowsocks]
name=Copr repo for shadowsocks owned by librehat
baseurl=https://copr-be.cloud.fedoraproject.org/results/librehat/shadowsocks/epel-7-$basearch/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/librehat/shadowsocks/pubkey.gpg
enabled=1
enabled_metadata=1' > /etc/yum.repos.d/shadowsocks-libev.repo
yum -y install shadowsocks-libev
echo '{
    "server": "0.0.0.0",
    "server_port": 18999,
    "local_port": 1080,
    "password": "lyj123456",
    "timeout": 600,
    "method": "aes-256-cfb",
}' > /etc/ss-config.json

/usr/local/bin/ss-server -c /etc/ss-config.json
sed -i '2a /usr/local/bin/ss-server -c /etc/shadowsocks-libev/config.json' /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local
yum clean all
