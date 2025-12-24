#!/bin/bash

# 手动配置区域
DB_NAME="hagobuy"
MYSQL_USER="root"
MYSQL_PASSWORD="123456"
THREADS=4  # 线程数

mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SET sql_log_bin=0;"

# 确保子进程能继承变量
export DB_NAME MYSQL_USER MYSQL_PASSWORD

find "$DB_NAME" -type f -path '*/data/*.sql' -print0 | \
    xargs -0 -P$THREADS -I{} bash -c '
        file="{}"
        echo "导入数据：$file"
        mysql -u$MYSQL_USER -p$MYSQL_PASSWORD "$DB_NAME" < "$file" 2>/dev/null
    '

mysql --default-character-set=utf8mb4 -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SET sql_log_bin=1;"
