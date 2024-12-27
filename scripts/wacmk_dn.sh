#!/bin/bash

function StartServer()
{
	echo starting $2 ...
	echo start $2 on screen session $1

	ret=`screen -ls | grep $1`
	if [ $? -ne 0 ]; then
		screen -dmS $1
	else
		echo "try kill $2 ..."
		screen -S $1 -p 0 -X stuff $'\003'
	fi

	screen -S $1 -p 0 -X stuff "chmod +x $2$(printf \\r)"
	screen -S $1 -p 0 -X stuff "./$2 $3$(printf \\r)"
	echo $2 started
	echo ""
}

function StopServer()
{
	screen_pid=`screen -ls | grep $1`;
	if [ ${#screen_pid} -eq 0 ]; then
		echo "No session $1"
		return
	fi

	echo stopping $2 ...
	screen -S $1 -p 0 -X stuff $'\003'

	sleep 1
	screen -S $1 -p 0 -X quit
	echo kill screen session $1
	echo ""
}

function start() {
    cd /data/lzg/bin
    chmod +x loginserver versionserver centerserver worldserver routerserver crossgameserver teamserver
    
    echo "基础模块启动中..."

    echo "启动 loginserver，日志 loginserver.log"
    nohup ./loginserver conf/login_conf.xml >> /logs/loginserver.log 2>&1 &
    sleep 2

    echo "启动 versionserver，日志 versionserver.log"
    nohup ./versionserver conf/version_conf.xml >> /logs/versionserver.log 2>&1 &
    sleep 2

    echo "启动 centerserver，日志 centerserver.log"
    nohup ./centerserver conf/cs_conf.xml >> /logs/centerserver.log 2>&1 &
    sleep 2

    echo "启动 worldserver，日志 worldserver.log"
    nohup ./worldserver conf/world_conf.xml >> /logs/worldserver.log 2>&1 &
    sleep 2

    echo "跨区模块启动中"

    echo "启动 routerserver，日志 routerserver.log"
    nohup ./routerserver conf/router_conf.xml >> /logs/routerserver.log 2>&1 &
    sleep 2

    echo "启动 crossgameserver，日志 crossgameserver.log"
    nohup ./crossgameserver conf/gs_cross_conf.xml >> /logs/crossgameserver.log 2>&1 &
    sleep 2

    echo "启动 teamserver，日志 teamserver.log"
    nohup ./teamserver conf/team_conf.xml >> /logs/teamserver.log 2>&1 &
    sleep 2

    echo "启动游戏服务"

    tag=s1

    StartServer ${tag}_db dbserver "conf/db_conf.xml"
    StartServer ${tag}_gs gameserver "conf/gs_conf.xml"
    StartServer ${tag}_gt gateserver "conf/gate_conf.xml"
    StartServer ${tag}_ms masterserver "conf/ms_conf.xml"
    StartServer ${tag}_ns controlserver "conf/ctrl_conf.xml"

    echo "服务启动完成"
}

function stop() {
    cd /data/lzg/bin

    tag=s1

    StopServer ${tag}_gt gateserver
    StopServer ${tag}_ms masterserver
    StopServer ${tag}_ns controlserver
    StopServer ${tag}_gs gameserver
    StopServer ${tag}_db dbserver

    pkill -9 loginserver
    pkill -9 versionserver
    pkill -9 worldserver
    pkill -9 routerserver
    pkill -9 crossgameserver
    pkill -9 centerserver
    pkill -9 teamserver
    echo "服务已停止"
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac

