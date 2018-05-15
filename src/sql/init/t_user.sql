/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:02:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) DEFAULT NULL,
  `accountName` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `credentialsSalt` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `locked` varchar(3) DEFAULT '0',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deletestatus` int(1) DEFAULT '0' COMMENT '逻辑删除状态0:存在1:删除',
  `departmentid` int(10) DEFAULT NULL,
  `version` bigint(20) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('2', '超级管理员', 'root', '3711894f7a85b61e5ac26fdca24db0bb', 'bcfdeb05ff252cf3706111ae76f040af', '0000', '1', '2016-09-21 17:23:45', '0', '1', '0');
INSERT INTO `t_user` VALUES ('3', '管理员', 'admin', 'fcd8fdb49a7652846d7952966897f0bd', 'fe1d1b63ac401029080985ea297d44bc', '3434', '1', '2016-11-03 09:22:46', '0', '10', '1');
INSERT INTO `t_user` VALUES ('4', '业务管理', 'yewuguanli', 'a9d90fff811a6781e99558c6c26d22c5', '75adfab7a215f53c90a92963306de56c', null, '1', '2016-11-30 09:26:12', '0', null, '0');
INSERT INTO `t_user` VALUES ('5', '智能安防', 'zhinenganfang', '83a16cda6443d8a3cc400b1e9f2ac7be', 'bca500f3603829c6e3af2e337ba72309', null, '1', '2016-11-30 09:35:01', '0', null, '0');
INSERT INTO `t_user` VALUES ('6', '仓储智能化', 'cangchuzhinenghua', 'c3662a5ec5a72c9677ae8c29896fd665', 'de905dec6c743156aab4817f6685a4d2', null, '1', '2016-11-30 09:39:25', '0', null, '0');
INSERT INTO `t_user` VALUES ('7', '基础管理', 'jichuguanli', '3703ff54996adf7142701646939cba4f', 'b14597a96f33b1deee57f549b01b4710', null, '1', '2017-02-23 16:24:29', '0', null, '4');
