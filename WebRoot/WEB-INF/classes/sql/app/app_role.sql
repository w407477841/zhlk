/*
Navicat MySQL Data Transfer

Source Server         : 192.168.0.166
Source Server Version : 50519
Source Host           : 192.168.0.166:3306
Source Database       : zhlk_app

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-10-31 09:52:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_role
-- ----------------------------
DROP TABLE IF EXISTS `app_role`;
CREATE TABLE `app_role` (
  `id` int(10) NOT NULL DEFAULT '0',
  `state` varchar(3) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `roleKey` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_role
-- ----------------------------
INSERT INTO `app_role` VALUES ('1', null, '管理员', 'admin', '管理员');
