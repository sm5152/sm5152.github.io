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

sudo dnf install -y --enablerepo=aliyun-elastic-stack elasticsearch kibana logstash
sudo systemctl disable firewalld
#sudo firewall-cmd --permanent --add-port={9200,9300,5601}/tcp && sudo firewall-cmd --reload
#sudo firewall-cmd --list-ports --permanent

echo "⚙️ 配置 Elasticsearch..."
sudo sed -i '/^#*\s*network\.host:/c\network.host: 0.0.0.0' /etc/elasticsearch/elasticsearch.yml

echo "⚙️ 配置 Kibana..."
sudo sed -i '/^#*\s*server\.host:/c\server.host: "0.0.0.0"' /etc/kibana/kibana.yml
sudo sed -i '/^#*\s*i18n\.locale:/c\i18n.locale: "zh-CN"' /etc/kibana/kibana.yml

echo "⚙️ 配置 Logstash..."
wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar
sudo mv mysql-connector-java-8.0.30.jar /usr/share/logstash/logstash-core/lib/jars/

echo "🚀 启动并设置服务开机自启..."
sudo systemctl enable --now elasticsearch
sudo systemctl enable --now kibana
sudo systemctl enable --now logstash
```
