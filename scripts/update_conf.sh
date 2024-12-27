#!/bin/bash

function update_cs_conf() {
    rm -rf /data/lzg/bin/conf/cs_conf.xml

    # 生成 XML 内容
    cat <<EOF > /data/lzg/bin/conf/cs_conf.xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Automaticly generated in $(date), scripts by WACMK -->
<CenterServer name="center" id="100">

	<!-- app(qq, wechat), plat(ios, android) -->
	<AppPlat app="wechat"  plat="android"/>
	
	<Redis ip="$REDIS_HOST" port="$REDIS_PORT" password="$REDIS_PASSWORD" keysuffix=""/>

	<Listen>
		<peer ip="127.0.0.1" port="35888" handler="mslink" sendBufSize="1024000" recvBufSize="1024000"/>
	</Listen>

	<Connect>
		<peer ip="127.0.0.1" port="25003" handler="loginlink" sendBufSize="1024000" recvBufSize="1024000"/>
	</Connect>

	<!-- rolltype (day, hour) -->
	<LogType  file="1" console="1" rolltype="day"/>
	<LogLevel info="1" debug="1" warn="1" error="1" fatal="1"/>

	<RootPath dir="csconf"/>
	<KeepAlive  enabled="0"/>
</CenterServer>

EOF

    echo "cs_conf.xml 更新完成"
}

function update_ctrl_conf() {
    rm -rf /data/lzg/bin/conf/ctrl_conf.xml

    # 生成 XML 内容
    cat <<EOF > /data/lzg/bin/conf/ctrl_conf.xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Automaticly generated in $(date), scripts by WACMK -->
<ControlServer name="control" zone="1" id="201">
	<AppPlat app="" plat="" /> <!-- app(qq, wechat), plat(ios, android) -->
    <DB ip="$MYSQL_HOST" user="$MYSQL_USER" password="$MYSQL_PASSWORD" port="$MYSQL_PORT" database="$MYSQL_DB_WORLD"/>
	<Connect>
		<peer ip="127.0.0.1" handler="dblink" port="21065" sendBufSize="2048000" recvBufSize="2048000"/>
		<!-- LoginServer列表 -->
		<peer ip="127.0.0.1" handler="loginlink" port="25000" sendBufSize="1024000" recvBufSize="1024000"/>
	</Connect>

	<Listen>
		<peer ip="127.0.0.1" handler="gatelink" port="21025" sendBufSize="2048000" recvBufSize="2048000"/>
		<peer ip="127.0.0.1" handler="gslink" port="21045" sendBufSize="4096000" recvBufSize="4096000"/>
		<peer ip="127.0.0.1" handler="mslink" port="21080" sendBufSize="2048000" recvBufSize="2048000"/>
	</Listen>

	<!-- rolltype (day, hour) -->
	<LogType  file="1" console="1" rolltype="day"/>
	<LogLevel info="1" debug="1" warn="1" error="1" fatal="1"/>

	<Shm>
		<config name="scene" num="50000" />
		<config name="account" num="50000" />
		<config name="role" num="30000" />
	</Shm>

	<RootPath dir="gsconf"/>
	<RpcTimeout enabled="1"/>
</ControlServer>

EOF

    echo "ctrl_conf.xml 更新完成"
}

function update_db_conf() {
    rm -rf /data/lzg/bin/conf/db_conf.xml

    # 生成 XML 内容
    cat <<EOF > /data/lzg/bin/conf/db_conf.xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Automaticly generated in $(date), scripts by WACMK -->
<DBServer name="db" zone="1" id="201">

	<DB ip="$MYSQL_HOST" user="$MYSQL_USER" password="$MYSQL_PASSWORD" port="$MYSQL_PORT" database="$MYSQL_DB_WORLD" threads="6"/>
	<OnlineDB ip="$MYSQL_HOST" user="$MYSQL_USER" password="$MYSQL_PASSWORD" port="$MYSQL_PORT" database="$MYSQL_DB_DRAGON_NEST_ONLINE" threads="1"/>

	<Listen>
		<peer ip="127.0.0.1" handler="gslink" port="21050" sendBufSize="2048000" recvBufSize="2048000"/>
		<peer ip="127.0.0.1" handler="mslink" port="21060" sendBufSize="2048000" recvBufSize="2048000"/>
		<peer ip="127.0.0.1" handler="ctrllink" port="21065" sendBufSize="2048000" recvBufSize="2048000"/>
	</Listen>

	<!-- rolltype (day, hour) -->
	<LogType  file="1" console="1" rolltype="day"/>
	<LogLevel info="1" debug="1" warn="1" error="1" fatal="1"/>

	<RootPath dir="dbconf"/>
	<RpcTimeout enabled="1"/>
	<AutoCreateDB enabled="0"/>

	<MaxRegisterNum value="50000"/>
	<KeepAlive  enabled="0"/>
</DBServer>

EOF

    echo "db_conf.xml 更新完成"
}

function update_gs_conf() {
    rm -rf /data/lzg/bin/conf/gs_conf.xml

    # 生成 XML 内容
    cat <<EOF > /data/lzg/bin/conf/gs_conf.xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Automaticly generated in $(date), scripts by WACMK -->
<GameServer name="game" zone="1" id="201" debug="0" line="1" isBig5="0">
	<DB ip="$MYSQL_HOST" user="$MYSQL_USER" password="$MYSQL_PASSWORD" port="$MYSQL_PORT" database="$MYSQL_DB_WORLD"/>

	<Connect>
		<peer ip="127.0.0.1" handler="dblink" port="21050" sendBufSize="2048000" recvBufSize="2048000"/>
		<peer ip="127.0.0.1" handler="mslink" port="21030" sendBufSize="2048000" recvBufSize="2048000"/>
		<peer ip="127.0.0.1" handler="ctrllink" port="21045" sendBufSize="4096000" recvBufSize="4096000"/>
		<!-- <peer ip="127.0.0.1" handler="newloglink" port="10175" sendBufSize="2048000" recvBufSize="2048000"/> -->
	</Connect>

	<!-- rolltype (day, hour) -->
	<LogType  file="1" console="1" rolltype="day"/>
	<LogLevel info="1" debug="0" warn="1" error="1" fatal="1"/>

	<RootPath dir="gsconf"/>
	<RpcTimeout enabled="1"/>
	<TLogConfigFile path="serveronly/tlog_config.xml"/>
	<!-- 测试环境 msdktest.qq.com(外网) msdktest.tencent-cloud.net(内网) 正式环境（内网IDC）的gameSvr访问MSDK域名 msdk.tencent-cloud.net (TGW)  -->
	<SdkUrl link="http://msdktest.qq.com"/>
	<!-- http协议外网:   maasapi.game.qq.com/aas.fcg  12280
		http协议内网:   域名  maasapi.idip.tencent-cloud.net/aas.fcg  12280    L5   64201473:65536
		游戏server部署在腾讯云环境下请使用https服务：https://maasapi2.game.qq.com/aas.fcg		-->
	<AntiAddictionUrl link="http://127.0.0.1" />
	<!-- DataMore 个人成长职业生涯 数据查询URL 
	测试URL http://cgidev.datamore.qq.com/datamore/dragonnestinner/user_profile
	正式的URL ：http://dragonnest.tencent-cloud.net/datamore/dragonnestinner/user_profile  -->
	<DataMoreUrl link="http://cgidev.datamore.qq.com/datamore/dragonnestinner/user_profile" />
	
	<!-- GameWeixinUrl 微信福袋 数据查询URL 
	测试和正式同一url
	正式的URL ：http://game.weixin.qq.com/cgi-bin/actnew/getacturl -->
	<GameWeixinUrl link="http://game.weixin.qq.com/cgi-bin/actnew/getacturl" />
</GameServer>

EOF

    echo "gs_conf.xml 更新完成"
}

function update_login_conf() {
    rm -rf /data/lzg/bin/conf/login_conf.xml

    # 生成 XML 内容
    cat <<EOF > /data/lzg/bin/conf/login_conf.xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Automaticly generated in $(date), scripts by WACMK -->
<LoginServer name="login" id="100" platform="" useOpenID="0" debug="0"> <!-- platform: aqq, awx, iqq, iwx, iguest -->
	<DB ip="$MYSQL_HOST" user="$MYSQL_USER" password="$MYSQL_PASSWORD" port="$MYSQL_PORT" database="$MYSQL_DB_LOGIN"/>

	<Connect>	
		<!-- peer ip="127.0.0.1" handler="idiplink" port="29001" sendBufSize="1024000" recvBufSize="1024000"/ -->	
	</Connect>

	<Listen>
		<peer ip="127.0.0.1" handler="ctrllink" port="25000" sendBufSize="1024000" recvBufSize="1024000"/>
		<peer ip="0.0.0.0" handler="clientlink" port="25001" sendBufSize="0" recvBufSize="0"/>
		<!-- peer ip="0.0.0.0" handler="gmtoollink" port="25002" sendBufSize="0" recvBufSize="0"/ -->
		<!-- <peer ip="127.0.0.1" handler="cslink" port="25003" sendBufSize="1024000" recvBufSize="1024000"/> -->
		<peer ip="127.0.0.1" handler="mslink" port="28000" sendBufSize="1024000" recvBufSize="1024000"/>
		<peer ip="127.0.0.1" handler="worldlink" port="28001" sendBufSize="1024000" recvBufSize="1024000"/>
	</Listen>

	<!-- onLineFull 在线人数达到多少服务器爆满 registerSmooth 注册数小于多少是流畅 registerFull 注册数大于多少是爆满 介于registerSmooth和registerFull之间是拥挤 -->
	<ServerState onlineFull="7000"  registerSmooth="20000" registerFull="30000" />

	<RecommendZone name="推薦服" />

	<!-- rolltype (day, hour) -->
	<LogType  file="1" console="1" rolltype="day"/>
	<LogLevel info="1" debug="1" warn="1" error="1" fatal="1"/>

	<RootPath dir="loginconf"/>
	<MsdkUrl link="http://msdktest.qq.com"/>
	<!-- Funplus登录验证地址 测试环境为http://passport-dev.funplusgame.com/server_api.php -->
	<FunplusUrl link="http://127.0.0.1"/>
	<KakaoUrl link="http://127.0.0.1"/>
	<KunlunUrl link="http://127.0.0.1"/>	
	<LoginControl max="50000" />
	<!-- <MsdkUrl link="http://msdktest.tencent-cloud.ne"/> -->
	<!-- <MsdkUrl link="http://msdk.qq.com"/> -->
	<!-- <MsdkUrl link="http://mocksvr.oa.com"/> -->
	
	<KeepAlive  enabled="0"/>
</LoginServer>

EOF

    echo "login_conf.xml 更新完成"
}

function update_ms_conf() {
    rm -rf /data/lzg/bin/conf/ms_conf.xml

    # 生成 XML 内容
    cat <<EOF > /data/lzg/bin/conf/ms_conf.xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Automaticly generated in $(date), scripts by WACMK -->
<MasterServer name="master" zone="1" id="201" debug="0">
    <AppPlat app="" plat="" /> <!-- app(qq, wechat), plat(ios, android) -->
    <DB ip="$MYSQL_HOST" user="$MYSQL_USER" password="$MYSQL_PASSWORD" port="$MYSQL_PORT" database="$MYSQL_DB_WORLD"/>
    <Redis ip="$REDIS_HOST" port="$REDIS_PORT" password="$REDIS_PASSWORD" keysuffix=""/>

    <Connect>
        <peer ip="127.0.0.1" handler="dblink" port="21060" sendBufSize="2048000" recvBufSize="2048000"/>
        <peer ip="127.0.0.1" handler="ctrllink" port="21080" sendBufSize="1024000" recvBufSize="1024000"/>
        <peer ip="127.0.0.1" handler="worldlink" port="31001" sendBufSize="1024000" recvBufSize="1024000"/>        
        <peer ip="127.0.0.1" handler="teamlink" port="41001" sendBufSize="1024000" recvBufSize="1024000"/>
        <peer ip="$SERVER_IP" handler="idiplink" port="$ID_IP_LINK_PORT" sendBufSize="2048000" recvBufSize="2048000"/>
        <!-- CenterServer列表 --> 
        <!--<peer ip="127.0.0.1" handler="centerlink" port="35888" sendBufSize="1024000" recvBufSize="1024000"/> -->        

        <!-- LoginServer列表 -->
        <peer ip="127.0.0.1" handler="loginlink" port="28000" sendBufSize="1024000" recvBufSize="1024000"/>
    </Connect>

    <Listen>
        <peer ip="127.0.0.1" handler="gatelink" port="21020" sendBufSize="2048000" recvBufSize="2048000"/>
        <peer ip="127.0.0.1" handler="gslink" port="21030" sendBufSize="2048000" recvBufSize="2048000"/>
        <!-- peer ip="127.0.0.1" handler="gmtoollink" port="12890" sendBufSize="0" recvBufSize="0"/ -->
    </Listen>

    <LogType  file="1" console="1" rolltype="day"/>
    <LogLevel info="1" debug="1" warn="1" error="1" fatal="1"/>

    <RootPath dir="gsconf"/>
    <RpcTimeout enabled="1"/>
    <FM enabled="1"/>
    <TLogConfigFile path="serveronly/tlog_config.xml"/>

    <!-- paydebug(沙箱或现网环境) 0：现网 1：沙箱 没有该字段默认为沙箱环境-->
    <!-- paydelaytest(延迟测试) 0:正常 1：延迟，谨慎使用，正式环境不能打开延迟，仅用于测试用-->
    <!--<PayUrl link="http://msdktest.qq.com" slavelink=""  count="10" paydebug="1" paydelaytest="0"/>-->
    <PayUrl link="http://127.0.0.1" slavelink=""  count="10" paydebug="1" paydelaytest="0"/>
    <CreateOrderUrl link="http://127.0.0.1/"/>
    <FunplusBindUrl link="http://127.0.0.1"/>
    <VerifyOrderUrl link="http://127.0.0.1"/>
    <!-- MsdkUrl idc正式:msdk.tencent-cloud.net  idc测试:msdktest.tencent-cloud.net  外网正式:msdk.qq.com  外网测试:msdktest.qq.com -->
    <MsdkUrl link="http://msdktest.qq.com"/>
    <!--<MsdkUrl link="http://127.0.0.1"/>-->
    <!-- 信鸽地址 不要加http -->
    <!--<XingeUrl link="openapi.xg.qq.com"/>-->
    <XingeUrl link="http://openapi.xg.qq.com"/>
</MasterServer>

EOF

    echo "ms_conf.xml 更新完成"
}

function update_world_conf() {
    rm -rf /data/lzg/bin/conf/world_conf.xml

    # 生成 XML 内容
    cat <<EOF > /data/lzg/bin/conf/world_conf.xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Automaticly generated in $(date), scripts by WACMK -->
<WorldServer name="world" id="1000">
	<DB ip="$MYSQL_HOST" user="$MYSQL_USER" password="$MYSQL_PASSWORD" port="$MYSQL_PORT" database="$MYSQL_DB_GLOBALWORLD" threads="3"/>

	<Connect>	
		<peer ip="127.0.0.1" handler="loginlink" port="28001" sendBufSize="1024000" recvBufSize="1024000"/>
	</Connect>

	<Listen>
		<peer ip="127.0.0.1" handler="mslink" port="31001" sendBufSize="1024000" recvBufSize="1024000"/>
		<peer ip="127.0.0.1" handler="gslink" port="31002" sendBufSize="1024000" recvBufSize="1024000"/>
		<peer ip="127.0.0.1" handler="rslink" port="31003" sendBufSize="1024000" recvBufSize="1024000"/>
		<!-- peer ip="0.0.0.0" handler="gmtoollink" port="31004" sendBufSize="512000" recvBufSize="512000"/ -->
		<peer ip="127.0.0.1" handler="teamlink" port="31005" sendBufSize="1024000" recvBufSize="1024000"/>
	</Listen>

	<!-- rolltype (day, hour) -->
	<LogType  file="1" console="1" rolltype="day"/>
	<LogLevel info="1" debug="1" warn="1" error="1" fatal="1"/>

	<RootPath dir="gsconf"/>
	<RpcTimeout enabled="1"/>
	<KeepAlive  enabled="0"/>
</WorldServer>

EOF

    echo "world_conf.xml 更新完成"
}

# 调用函数生成配置文件
update_cs_conf
update_ctrl_conf
update_db_conf
update_gs_conf
update_login_conf
update_ms_conf
update_world_conf

