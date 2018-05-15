/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:35:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_role_res
-- ----------------------------
DROP TABLE IF EXISTS `t_role_res`;
CREATE TABLE `t_role_res` (
  `resId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`resId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_role_res
-- ----------------------------
INSERT INTO `t_role_res` VALUES ('1', '1');
INSERT INTO `t_role_res` VALUES ('2', '1');
INSERT INTO `t_role_res` VALUES ('3', '1');
INSERT INTO `t_role_res` VALUES ('25', '1');
INSERT INTO `t_role_res` VALUES ('26', '1');
INSERT INTO `t_role_res` VALUES ('27', '1');
INSERT INTO `t_role_res` VALUES ('28', '1');
INSERT INTO `t_role_res` VALUES ('37', '1');
INSERT INTO `t_role_res` VALUES ('52', '1');
INSERT INTO `t_role_res` VALUES ('53', '1');
INSERT INTO `t_role_res` VALUES ('54', '1');
INSERT INTO `t_role_res` VALUES ('56', '1');
INSERT INTO `t_role_res` VALUES ('57', '1');
INSERT INTO `t_role_res` VALUES ('58', '1');
INSERT INTO `t_role_res` VALUES ('59', '1');
INSERT INTO `t_role_res` VALUES ('60', '1');
INSERT INTO `t_role_res` VALUES ('247', '1');
