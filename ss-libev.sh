#!/bin/bash
#安装
yum -y update
yum -y install net-tools
yum -y install git gcc openssl-devel
yum -y install gcc automake autoconf libtool make
git clone https://github.com/madeye/shadowsocks-libev.git
cd shadowsocks-libev
./configure && make
make install
#配置
cat << EOF > /etc/ss-config.json
{
 "server":"0.0.0.0",
 "server_port":8388,
 "local_address": "127.0.0.1",
 "local_port":1080,
 "password":"123456",
 "timeout":600,
 "method":"aes-256-cfb",
 "fast_open": false,
 "workers": 1
}
EOF
#运行  如果服务端口小于1024，则需要改为user=root
cat << EOF > /usr/lib/systemd/system/shadowsocks.service
[Unit]
Description=ShadowSocks service
After=syslog.target network.target auditd.service

[Service]
Type=simple
User=nobody
ExecStart=/usr/local/bin/ss-server -c /etc/ss-config.json
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
#启动
systemctl enable shadowsocks
systemctl start shadowsocks
#清理
yum clean all
