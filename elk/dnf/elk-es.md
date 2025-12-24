```shell
sudo tee /etc/yum.repos.d/aliyun-elastic-stack.repo << 'EOF'
[aliyun-elastic-stack]
name=Aliyun Elastic Stack 8.x
baseurl=https://mirrors.aliyun.com/elasticstack/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF

sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

sudo dnf install -y --enablerepo=aliyun-elastic-stack elasticsearch

echo "⚙️ 配置 Elasticsearch..."
sudo sed -i '/^#*\s*network\.host:/c\network.host: 0.0.0.0' /etc/elasticsearch/elasticsearch.yml

echo "🚀 启动并设置服务开机自启..."
sudo systemctl enable --now elasticsearch
```

```shell
echo "⚙️ 导出 CA 证书到用户目录..."
sudo install -o hmms -g hmms -m 640 /etc/elasticsearch/certs/http_ca.crt ~
echo "⚙️ 重置 kibana_system 密码..."
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system
```
