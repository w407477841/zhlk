/*
Navicat MySQL Data Transfer

Source Server         : 192.168.0.166
Source Server Version : 50519
Source Host           : 192.168.0.166:3306
Source Database       : zhlk_app

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-10-31 09:52:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_permission
-- ----------------------------
DROP TABLE IF EXISTS `app_permission`;
CREATE TABLE `app_permission` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `resKey` varchar(50) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `resUrl` varchar(200) DEFAULT NULL,
  `level` int(4) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `ishide` int(3) DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  `methodName` varchar(20) DEFAULT '' COMMENT '对应 枚举中的methodName'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_permission
-- ----------------------------
INSERT INTO `app_permission` VALUES ('1', '仓储信息饼状图1', null, null, null, null, null, null, '0', null, '02,001');
INSERT INTO `app_permission` VALUES ('2', '仓储信息饼状图2', null, null, null, null, null, null, '0', null, '02,002');
INSERT INTO `app_permission` VALUES ('3', '质量信息展示', null, null, null, null, null, null, '0', null, '02,003');
INSERT INTO `app_permission` VALUES ('4', '作业记录展示', null, null, null, null, null, null, '0', null, '02,004');
INSERT INTO `app_permission` VALUES ('5', '站点列表', null, null, null, null, null, null, '0', null, '02,005');
INSERT INTO `app_permission` VALUES ('6', '综合展示', null, null, null, null, null, null, '0', null, '02,006');
INSERT INTO `app_permission` VALUES ('7', '仓号列表', null, null, null, null, null, null, '0', null, '02,007');
INSERT INTO `app_permission` VALUES ('8', '品种列表', null, null, null, null, null, null, '0', null, '02,008');
INSERT INTO `app_permission` VALUES ('9', '性质列表', null, null, null, null, null, null, '0', null, '02,009');
INSERT INTO `app_permission` VALUES ('10', '类别列表', null, null, null, null, null, null, '0', null, '02,010');
INSERT INTO `app_permission` VALUES ('11', '出入库记录', null, null, null, null, null, null, '0', null, '03,001');
INSERT INTO `app_permission` VALUES ('12', '粮温粮情', null, null, null, null, null, null, '0', null, '04,001');
INSERT INTO `app_permission` VALUES ('13', '粮情趋势', null, null, null, null, null, null, '0', null, '04,002');
INSERT INTO `app_permission` VALUES ('14', '药剂审批列表', null, null, null, null, null, null, '0', null, '06,001');
INSERT INTO `app_permission` VALUES ('15', '药剂审批操作', null, null, null, null, null, null, '0', null, '06,002');
INSERT INTO `app_permission` VALUES ('16', '出库审批列表', null, null, null, null, null, null, '0', null, '06,003');
INSERT INTO `app_permission` VALUES ('17', '出库审批操作', null, null, null, null, null, null, '0', null, '06,004');
INSERT INTO `app_permission` VALUES ('18', '实时库存统计', null, null, null, null, null, null, '0', null, '07,001');
INSERT INTO `app_permission` VALUES ('19', '当日出入库统计', null, null, null, null, null, null, '0', null, '07,002');
INSERT INTO `app_permission` VALUES ('20', '出入库统计', null, null, null, null, null, null, '0', null, '07,003');
INSERT INTO `app_permission` VALUES ('21', '传感器数据', null, null, null, null, null, null, '0', null, '07,004');
INSERT INTO `app_permission` VALUES ('22', '设备统计', null, null, null, null, null, null, '0', null, '07,005');
INSERT INTO `app_permission` VALUES ('23', '视频监控', null, null, null, null, null, null, '0', null, '暂无,暂无');
