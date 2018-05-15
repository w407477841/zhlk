/*
Navicat MySQL Data Transfer

Source Server         : 192.168.0.166
Source Server Version : 50519
Source Host           : 192.168.0.166:3306
Source Database       : zhlk_app

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-10-31 09:53:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_user_role
-- ----------------------------
DROP TABLE IF EXISTS `app_user_role`;
CREATE TABLE `app_user_role` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_user_role
-- ----------------------------
INSERT INTO `app_user_role` VALUES ('3', '1');
INSERT INTO `app_user_role` VALUES ('4', '1');
INSERT INTO `app_user_role` VALUES ('5', '1');
INSERT INTO `app_user_role` VALUES ('6', '1');
INSERT INTO `app_user_role` VALUES ('7', '1');
