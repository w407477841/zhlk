/*
Navicat MySQL Data Transfer

Source Server         : 192.168.0.166
Source Server Version : 50519
Source Host           : 192.168.0.166:3306
Source Database       : zhlk_app

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-10-31 09:52:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `app_role_permission`;
CREATE TABLE `app_role_permission` (
  `resId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_role_permission
-- ----------------------------
INSERT INTO `app_role_permission` VALUES ('1', '1');
INSERT INTO `app_role_permission` VALUES ('2', '1');
INSERT INTO `app_role_permission` VALUES ('3', '1');
INSERT INTO `app_role_permission` VALUES ('4', '1');
INSERT INTO `app_role_permission` VALUES ('6', '1');
INSERT INTO `app_role_permission` VALUES ('11', '1');
INSERT INTO `app_role_permission` VALUES ('12', '1');
INSERT INTO `app_role_permission` VALUES ('13', '1');
INSERT INTO `app_role_permission` VALUES ('14', '1');
INSERT INTO `app_role_permission` VALUES ('16', '1');
INSERT INTO `app_role_permission` VALUES ('18', '1');
INSERT INTO `app_role_permission` VALUES ('19', '1');
INSERT INTO `app_role_permission` VALUES ('20', '1');
INSERT INTO `app_role_permission` VALUES ('21', '1');
INSERT INTO `app_role_permission` VALUES ('22', '1');
INSERT INTO `app_role_permission` VALUES ('23', '1');
