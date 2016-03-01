
#安装
yum install git gcc openssl-devel
git clone https://github.com/madeye/shadowsocks-libev.git
cd shadowsocks-libev
./configure && make
make install
#配置
mkdir -p /etc/shadowsocks
cat << EOF > /etc/shadowsocks/config.json
{
 "server":"0.0.0.0",
 "server_port":10000,
 "local_address": "127.0.0.1",
 "local_port":1080,
 "password":"yourpasswd",
 "timeout":300,
 "method":"aes-192-cfb",
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
ExecStart=/usr/local/bin/ss-server -c /etc/shadowsocks/config.json
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
#启动
systemctl enable shadowsocks
systemctl start shadowsocks
