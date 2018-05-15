/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-12-19 10:19:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_warehouse_archives_his
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_archives_his`;
CREATE TABLE `t_warehouse_archives_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wId` int(11) DEFAULT NULL,
  `waHeatInsulator` varchar(32) DEFAULT NULL,
  `waWindow` int(11) NOT NULL DEFAULT '0',
  `waWarehouseType` varchar(32) DEFAULT NULL,
  `waDoorNumber` int(11) NOT NULL DEFAULT '0',
  `waStructure` varchar(32) DEFAULT NULL,
  `waAeration` varchar(32) DEFAULT NULL,
  `waFumigate` varchar(32) DEFAULT NULL,
  `waConstructDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `waDesignCapacity` decimal(20,0) DEFAULT NULL,
  `waDesignHeight` float NOT NULL DEFAULT '0',
  `waInnerLong` float NOT NULL DEFAULT '0',
  `waInnerWidth` float NOT NULL DEFAULT '0',
  `waStoreman` int(11) DEFAULT NULL,
  `waSequence` varchar(32) DEFAULT NULL,
  `waDataOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT '1',
  `wahUser` int(11) DEFAULT NULL,
  `wahSQL` text NOT NULL,
  `wahType` varchar(32) NOT NULL DEFAULT '',
  `wahOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
