/*
Navicat MySQL Data Transfer

Source Server         : 192.168.0.166
Source Server Version : 50519
Source Host           : 192.168.0.166:3306
Source Database       : zhlk_app

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-10-31 09:52:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_token
-- ----------------------------
DROP TABLE IF EXISTS `app_token`;
CREATE TABLE `app_token` (
  `userId` int(11) NOT NULL,
  `token` varchar(64) DEFAULT NULL,
  `ctime` varchar(20) DEFAULT NULL,
  `endday` varchar(10) DEFAULT '' COMMENT 'token到期时间 格式2014-01-10',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_token
-- ----------------------------
INSERT INTO `app_token` VALUES ('3', '2a3f0dcc334f41eeb4db961b9f0feb45', '2017-10-31 09:44:37', '2017-11-30');
