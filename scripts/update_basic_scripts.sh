#!/bin/bash

function update_login_sql() {
    rm -rf /data/sql/login.sql



    # 生成 XML 内容
    cat <<EOF > /data/sql/login.sql
/*Automaticly generated in $(date), scripts by WACMK*/
/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50649
Source Host           : 127.0.0.1:3306
Source Database       : login

Target Server Type    : MYSQL
Target Server Version : 50649
File Encoding         : 65001

Date: 2020-10-27 21:30:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account_backflow
-- ----------------------------
DROP TABLE IF EXISTS `account_backflow`;
CREATE TABLE `account_backflow` (
  `openid` varchar(64) NOT NULL,
  `expiretime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of account_backflow
-- ----------------------------

-- ----------------------------
-- Table structure for banaccount
-- ----------------------------
DROP TABLE IF EXISTS `banaccount`;
CREATE TABLE `banaccount` (
  `openid` varchar(64) NOT NULL,
  `endtime` int(11) NOT NULL,
  `reason` blob NOT NULL,
  PRIMARY KEY (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of banaccount
-- ----------------------------

-- ----------------------------
-- Table structure for bespeak
-- ----------------------------
DROP TABLE IF EXISTS `bespeak`;
CREATE TABLE `bespeak` (
  `openid` varchar(64) NOT NULL,
  `serverid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`openid`,`serverid`),
  KEY `openid` (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of bespeak
-- ----------------------------

-- ----------------------------
-- Table structure for charge_back
-- ----------------------------
DROP TABLE IF EXISTS `charge_back`;
CREATE TABLE `charge_back` (
  `openid` varchar(64) NOT NULL,
  `serverid` int(10) unsigned DEFAULT NULL,
  `roleid` bigint(20) unsigned NOT NULL,
  `total_pay` int(10) unsigned NOT NULL,
  PRIMARY KEY (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of charge_back
-- ----------------------------

-- ----------------------------
-- Table structure for gateinfo
-- ----------------------------
DROP TABLE IF EXISTS `gateinfo`;
CREATE TABLE `gateinfo` (
  `server_id` int(11) NOT NULL COMMENT '服务器ID',
  `channel` varchar(64) NOT NULL COMMENT '渠道',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '设置状态',
  `is_open` int(11) NOT NULL DEFAULT '0' COMMENT '是否开启',
  `server_name` varchar(255) NOT NULL COMMENT '服务器名称',
  `zone_name` varchar(255) NOT NULL COMMENT '区名称',
  `ipaddr` varchar(255) NOT NULL COMMENT 'ip端口地址',
  `free_ipaddr` varchar(255) NOT NULL DEFAULT '',
  `register_account` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总注册帐号数',
  `online_role` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前在线角色数',
  `open_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '开服时间',
  `full_register_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '首次注册突破上限时间',
  `combine_serverid` int(10) unsigned NOT NULL,
  `backflow_level` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`server_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of gateinfo
-- ----------------------------
INSERT INTO `gateinfo` VALUES ('201', '2', '5', '1', '$SERVER_NAME', '$SERVER_REGION_NAME', '$SERVER_IP:$SERVER_PORT', '', '1', '1', '$SERVER_OPEN_TIME', '$SERVER_FULL_REGISTER_TIME', '0', '0');

-- ----------------------------
-- Table structure for gmaccount
-- ----------------------------
DROP TABLE IF EXISTS `gmaccount`;
CREATE TABLE `gmaccount` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(64) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of gmaccount
-- ----------------------------

-- ----------------------------
-- Table structure for iplist
-- ----------------------------
DROP TABLE IF EXISTS `iplist`;
CREATE TABLE `iplist` (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(64) NOT NULL,
  `ipbegin` varchar(64) NOT NULL,
  `ipend` varchar(64) NOT NULL,
  PRIMARY KEY (`_id`),
  KEY `platform` (`platform`,`ipbegin`,`ipend`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of iplist
-- ----------------------------

-- ----------------------------
-- Table structure for lastlogin
-- ----------------------------
DROP TABLE IF EXISTS `lastlogin`;
CREATE TABLE `lastlogin` (
  `userid` varchar(64) NOT NULL,
  `serverid` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of lastlogin
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `type` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `isopen` int(11) NOT NULL,
  `areaid` int(11) NOT NULL,
  `platid` int(11) NOT NULL,
  `content` blob NOT NULL,
  `updatetime` int(11) NOT NULL,
  PRIMARY KEY (`type`,`areaid`,`platid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for selfserver
-- ----------------------------
DROP TABLE IF EXISTS `selfserver`;
CREATE TABLE `selfserver` (
  `userid` varchar(64) NOT NULL,
  `serverid` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `userid` (`userid`,`serverid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of selfserver
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userid` varchar(64) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `proxy` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------

EOF

    echo "login.sql 更新完成"
}

function update_db_sh() {
    rm -rf /data/sql/db.sh

    # 生成 XML 内容
    cat <<EOF > /data/sql/db.sh
#!/bin/bash

# Automaticly generated in $(date), scripts by WACMK

mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD -e "create database if not exists $MYSQL_DB_DRAGON_NEST_ONLINE;";
mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD -e "create database if not exists $MYSQL_DB_GLOBALWORLD;";
mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD -e "create database if not exists $MYSQL_DB_LOGIN;";
mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD -e "create database if not exists $MYSQL_DB_WORLD;";

mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD  $MYSQL_DB_DRAGON_NEST_ONLINE < /data/sql/db_Dragon_Nest_online.sql
mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_GLOBALWORLD < /data/sql/globalworld.sql
mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_LOGIN < /data/sql/login.sql
mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DB_WORLD < /data/sql/world.sql

echo "数据库已导入成功。";

EOF

    chmod +x /data/sql/db.sh

    echo "db.sh 更新完成"
}

update_login_sql
update_db_sh

