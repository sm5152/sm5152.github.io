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

sudo dnf install -y --enablerepo=aliyun-elastic-stack kibana

echo "⚙️ 配置 Kibana..."
sudo sed -i '/^#*\s*server\.host:/c\server.host: "0.0.0.0"' /etc/kibana/kibana.yml
sudo sed -i '/^#*\s*i18n\.locale:/c\i18n.locale: "zh-CN"' /etc/kibana/kibana.yml

echo "🚀 启动并设置服务开机自启..."
sudo systemctl enable --now kibana
```

### 需先将证书上传到用户目录，[安全相关](https://www.elastic.co/guide/en/kibana/8.17/using-kibana-with-security.html)

```shell
sudo install -o kibana -g kibana -m 750 -d /etc/kibana/certs
sudo install -o kibana -g kibana -m 640 ~/http_ca.crt /etc/kibana/certs/
sudo sed -i '/^#*\s*elasticsearch\.hosts:/c\elasticsearch.hosts: ["https://10.211.55.37:9200"]' /etc/kibana/kibana.yml
sudo sed -i '/^#*\s*elasticsearch\.username:/c\elasticsearch.username: "kibana_system"' /etc/kibana/kibana.yml
sudo sed -i '/^#*\s*elasticsearch\.password:/c\elasticsearch.password: "pass"' /etc/kibana/kibana.yml
sudo sed -i '/^#*\s*elasticsearch\.ssl\.certificateAuthorities:/c\elasticsearch.ssl.certificateAuthorities: [ "/etc/kibana/certs/http_ca.crt" ]' /etc/kibana/kibana.yml
sudo systemctl restart kibana
```
