/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:00:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_code
-- ----------------------------
DROP TABLE IF EXISTS `t_code`;
CREATE TABLE `t_code` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_code
-- ----------------------------
INSERT INTO `t_code` VALUES ('9', '部门');
INSERT INTO `t_code` VALUES ('10', '粮食等级');
INSERT INTO `t_code` VALUES ('11', '粮食性质');
INSERT INTO `t_code` VALUES ('12', '粮食品种');
INSERT INTO `t_code` VALUES ('13', '仓房厫间类型');
INSERT INTO `t_code` VALUES ('14', '收支指标');
INSERT INTO `t_code` VALUES ('15', '害虫类型');
INSERT INTO `t_code` VALUES ('16', '药品编码');
INSERT INTO `t_code` VALUES ('17', '熏蒸方式');
INSERT INTO `t_code` VALUES ('18', '通风类型编码');
INSERT INTO `t_code` VALUES ('19', '通风方式编码');
INSERT INTO `t_code` VALUES ('20', '通风目的编码');
INSERT INTO `t_code` VALUES ('21', '通风机械编码');
INSERT INTO `t_code` VALUES ('22', '计量单位编码');
INSERT INTO `t_code` VALUES ('23', '设备状态编码');
INSERT INTO `t_code` VALUES ('24', '设备类型分类编码');
INSERT INTO `t_code` VALUES ('25', '药品业务类型分类编码');
INSERT INTO `t_code` VALUES ('26', '包装方式');
INSERT INTO `t_code` VALUES ('27', '粮食类别');
