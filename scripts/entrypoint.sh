#!/bin/bash

function cleanup() {
    kill -s SIGTERM $!
    exit 0
}

: "${MYSQL_HOST:-db}"
: "${MYSQL_USER:-root}"
: "${MYSQL_PASSWORD:-123456}"
: "${MYSQL_PORT:-3306}"
: "${MYSQL_DB_LOGIN:-login}"
: "${MYSQL_DB_WORLD:-world}"
: "${MYSQL_DB_GLOBALWORLD:-globalworld}"
: "${MYSQL_DB_DRAGON_NEST_ONLINE:-db_Dragon_Nest_online}"
: "${REDIS_HOST:-redis}"
: "${REDIS_PORT:-6379}"
: "${REDIS_PASSWORD:-iguozicc}"
: "${SERVER_IP:?SERVER_IP 环境变量未设置}"
: "${SERVER_PORT:-10201}"
: "${SERVER_NAME:-WACMKDragonNest}"
: "${SERVER_REGION_NAME:-WACMKDragonNest}"
: "${SERVER_OPEN_TIME:-2020-04-01 16:00:00}"
: "${SERVER_FULL_REGISTER_TIME:-2020-04-01 16:10:00}"
: "${ID_IP_LINK_PORT:-58003}"

echo "<< WACMK 龙之谷手游服务端 >>"
if [ "$INIT_MODE" = "true" ]; then
    echo "【初始化模式】"
    echo "初始化服务端文件中...（注：如果修改过服务端，将会被重置为初始版本）"
    unzip server.zip
    chmod -R 777 /data
    echo "初始化脚本文件中...（注：已有的用户数据将被删除）"
    /scripts/update_basic_scripts.sh
    echo "初始化脚本文件创建完成，开始初始化数据库"
    /data/sql/db.sh
    mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD  $MYSQL_DB_GLOBALWORLD -e "insert into masterid values (1);";
    echo "数据库初始化完成，开始更新配置文件"
    /scripts/update_conf.sh
    echo "配置文件更新完成"
    echo "初始化完成。请将 INIT_MODE 设置为 false，以退出初始化模式。（该模式将不会启动服务）"
else
    # 检查是否为配置更新模式
    if [ "$UPDATE_MODE" = "true" ]; then
        echo "【配置更新模式】"
        /scripts/update_conf.sh
        /data/sql/db.sh
        mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_LOGIN -e "update \`gateinfo\` set \`ipaddr\` = '$SERVER_IP:$SERVER_PORT' where \`server_id\` = 201;";
        echo "配置文件更新完成"
    fi

    # 启动服务
    echo "【启动服务端 - 单节点模式】"
    /scripts/wacmk_dn.sh start
fi

trap cleanup SIGINT SIGTERM

while [ 1 ]; do
    sleep 60 &
    wait $!
done

