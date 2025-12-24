#!/bin/bash

# 定义变量
DB_NAME="hagobuy"
MYSQL_USER="root"
MYSQL_PASSWORD="123456"

# 遍历所有表的 structure.sql 文件并导入
find "$DB_NAME" -name "structure.sql" | while IFS= read -r STRUCTURE_FILE; do
  echo "正在导入表结构：$STRUCTURE_FILE"
  mysql --default-character-set=utf8mb4 -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$DB_NAME" < "$STRUCTURE_FILE" 2>/dev/null
done
