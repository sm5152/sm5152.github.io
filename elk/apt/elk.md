```shell
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | \
  sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

sudo tee /etc/apt/sources.list.d/elastic-8.x.list << 'EOF'
deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main
EOF

sudo apt update && sudo apt install -y elasticsearch kibana logstash

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
