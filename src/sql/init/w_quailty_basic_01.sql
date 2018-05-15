/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:04:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for w_quailty_basic_01
-- ----------------------------
DROP TABLE IF EXISTS `w_quailty_basic_01`;
CREATE TABLE `w_quailty_basic_01` (
  `Code` varchar(32) NOT NULL DEFAULT '0.00' COMMENT '质量编码',
  `CodeName` varchar(45) DEFAULT '0.00' COMMENT '名称',
  `Standard` varchar(45) DEFAULT '0.00' COMMENT '标准值,标准等级',
  `Min` varchar(45) DEFAULT '0.00' COMMENT '最小区间,最低等级',
  `Max` varchar(45) DEFAULT '0.00' COMMENT '最大区间,最高等级',
  `Step` varchar(45) DEFAULT '0.00' COMMENT '等级差',
  `Reduce` varchar(45) DEFAULT '0.00' COMMENT '扣量标准',
  `Reducing` varchar(45) DEFAULT '0.00' COMMENT '扣量值',
  `Promote` varchar(45) DEFAULT '0.00' COMMENT '增量幅度',
  `Promoting` varchar(45) DEFAULT '0.00' COMMENT '增量值',
  `Abbreviation` varchar(45) DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_quailty_basic_01
-- ----------------------------
INSERT INTO `w_quailty_basic_01` VALUES ('111401', '容重出糙', '750.00,3', '690.00,5', '830.00,1', '20.00', '0.00', '0.00', '0.00', '0.00', 'rz');
INSERT INTO `w_quailty_basic_01` VALUES ('111403', '水分', '12.50', '6.00', '26.00', '0.00', '0.50', '1.00', '2.50', '0.75', 'sf');
INSERT INTO `w_quailty_basic_01` VALUES ('111404', '杂质', '1.00', '0.00', '9.00', '0.00', '0.50', '1.50', '0.00', '0.75', 'zz');
INSERT INTO `w_quailty_basic_01` VALUES ('111405', '其中矿物质', '0.50', '0.00', '9.00', '0.00', '0.00', '0.75', '0.00', '0.00', 'kwz');
INSERT INTO `w_quailty_basic_01` VALUES ('111406', '不完善粒', '8.00', '0.00', '30.00', '2.00', '1.00', '0.50', '0.00', '0.00', 'bwsld');
INSERT INTO `w_quailty_basic_01` VALUES ('113200202', '容重出糙', '77.00,3', '69.00,5', '83.00,1', '2.00', '0.00', '0.00', '0.00', '0.00', 'rz');
INSERT INTO `w_quailty_basic_01` VALUES ('113200203', '水分', '14.50', '6.00', '26.00', '0.00', '0.50', '1.00', '2.50', '0.75', 'sf');
INSERT INTO `w_quailty_basic_01` VALUES ('113200204', '杂质', '1.00', '0.00', '9.00', '0.00', '0.50', '1.50', '0.00', '0.75', 'zz');
INSERT INTO `w_quailty_basic_01` VALUES ('113200207', '整精米', '55.00', '30.00', '80.00', '3.00', '1.00', '0.75', '0.00', '0.00', 'zjml');
INSERT INTO `w_quailty_basic_01` VALUES ('113200208', '谷外糙米', '2.00', '0.00', '50.00', '0.00', '2.00', '1.00', '0.00', '0.00', 'gwcm');
INSERT INTO `w_quailty_basic_01` VALUES ('113200209', '黄米粒', '1.00', '0.00', '50.00', '0.00', '1.00', '1.00', '0.00', '0.00', 'hl');
INSERT INTO `w_quailty_basic_01` VALUES ('113200210', '互混', '5.00', '0.00', '50.00', '0.00', '5.00', '1.00', '0.00', '0.00', 'hh');
