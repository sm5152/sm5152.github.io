## [elasticsearch](https://www.elastic.co/downloads/elasticsearch)

## [kibana](https://www.elastic.co/downloads/kibana)

## [logstash](https://www.elastic.co/downloads/logstash)

## [阿里云镜像](https://developer.aliyun.com/mirror/elasticstack)

```shell
sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
sudo /usr/share/kibana/bin/kibana-verification-code
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
```

## [input-jdbc](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-jdbc.html)

## [output-elasticsearch](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-elasticsearch.html)

```shell
sudo install -o logstash -g logstash -m 750 -d /etc/logstash/certs
sudo install -o logstash -g logstash -m 640 /etc/elasticsearch/certs/http_ca.crt /etc/logstash/certs/
```

```shell
sudo tee /etc/logstash/conf.d/hagobuy_admin.conf << 'EOF'
input {
    jdbc {
        id => "hagobuy_admin-cmf_user"
        add_field => { "[@metadata][jdbc_id]" => "hagobuy_admin-cmf_user" }
        jdbc_driver_library => "/usr/share/logstash/logstash-core/lib/jars/mysql-connector-java-8.0.30.jar"
        jdbc_driver_class => "com.mysql.cj.jdbc.Driver"
        jdbc_connection_string => "jdbc:mysql://10.211.55.2:3306/hagobuy_admin?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true"
        jdbc_user => "es"
        jdbc_password => "123456"
        schedule => "* * * * *"
        jdbc_paging_enabled => true
        jdbc_page_size => 10000
        statement => "SELECT * FROM cmf_user WHERE update_time > :sql_last_value ORDER BY update_time ASC"
        use_column_value => true
        tracking_column => "update_time"
        tracking_column_type => "numeric"
        jdbc_pool_timeout => 60
        jdbc_validate_connection => true
        jdbc_validation_timeout => 30
        jdbc_default_timezone => "Asia/Shanghai"
        last_run_metadata_path => "/var/lib/logstash/jdbc_last_run-hagobuy_admin-cmf_user"
    }
}
output {
    if [@metadata][jdbc_id] == "hagobuy_admin-cmf_user" {
        elasticsearch {
            hosts => ["https://10.211.55.27:9200"]
            index => "%{[@metadata][jdbc_id]}"
            api_key => "dwHp6ZUBDQc73QPqwnNE:TYVWEeYQTXi6nocY8xE_nQ"
            ssl_enabled => true
            ssl_certificate_authorities => "/etc/logstash/certs/http_ca.crt"
        }
    }
}
EOF

sudo tee /etc/logstash/conf.d/hagobuy.conf << 'EOF'
input {
    jdbc {
        id => "hagobuy-hb_tp_goods"
        add_field => { "[@metadata][jdbc_id]" => "hagobuy-hb_tp_goods" }
        jdbc_driver_library => "/usr/share/logstash/logstash-core/lib/jars/mysql-connector-java-8.0.30.jar"
        jdbc_driver_class => "com.mysql.cj.jdbc.Driver"
        jdbc_connection_string => "jdbc:mysql://10.211.55.2:3306/hagobuy?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true"
        jdbc_user => "es"
        jdbc_password => "123456"
        schedule => "* * * * *"
        jdbc_paging_enabled => true
        jdbc_page_size => 10000
        statement => "SELECT id,title,url,update_time FROM hb_tp_goods WHERE update_time > :sql_last_value ORDER BY update_time ASC"
        use_column_value => true
        tracking_column => "update_time"
        tracking_column_type => "numeric"
        jdbc_pool_timeout => 60
        jdbc_validate_connection => true
        jdbc_validation_timeout => 30
        jdbc_default_timezone => "Asia/Shanghai"
        last_run_metadata_path => "/var/lib/logstash/jdbc_last_run-hagobuy-hb_tp_goods"
    }
}
output {
    if [@metadata][jdbc_id] == "hagobuy-hb_tp_goods" {
        elasticsearch {
            hosts => ["https://10.211.55.27:9200"]
            index => "%{[@metadata][jdbc_id]}"
            api_key => "dwHp6ZUBDQc73QPqwnNE:TYVWEeYQTXi6nocY8xE_nQ"
            ssl_enabled => true
            ssl_certificate_authorities => "/etc/logstash/certs/http_ca.crt"
        }
    }
}
EOF

sudo systemctl restart logstash
```

### 调试用

```shell
sudo pkill -9 -f logstash
sudo systemctl stop logstash
sudo rm -v /var/lib/logstash/jdbc_last_run-*
sudo rm -v /var/log/logstash/logstash-plain.log
sudo rm -v /etc/logstash/conf.d/*
```
