/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-17 10:55:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_warehouse_location
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_location`;
CREATE TABLE `t_warehouse_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wNo` varchar(16) NOT NULL,
  `wName` varchar(32) DEFAULT NULL,
  `wStatus` int(11) DEFAULT NULL,
  `wDisable` char(1) DEFAULT NULL,
  `wSummary` varchar(512) DEFAULT NULL,
  `wLog` varchar(16) DEFAULT NULL,
  `wLat` varchar(16) DEFAULT NULL,
  `wFullName` varchar(128) DEFAULT NULL,
  `wImage` varchar(128) DEFAULT NULL,
  `szDevIp` varchar(32) DEFAULT NULL,
  `szDevPort` varchar(32) DEFAULT NULL,
  `szDevUser` varchar(32) DEFAULT NULL,
  `szDevPwd` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000026 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_warehouse_location
-- ----------------------------
INSERT INTO `t_warehouse_location` VALUES ('1000002', '1000002', '岔河', '1', '1', '江苏省正场粮食直属库总面积32000平方米江苏省正场粮食直属库江苏省正场粮食直属库', '121.030049', '32.05173', '江苏省岔河粮食直属库', 'img/cangku/zhengchang.jpg', null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000003', '1000003', '马塘', '1', '1', '数字化管理', '121.25233', '32.188345', '江苏省马塘粮食直属库', 'img/cangku/qian.jpg', null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000008', '1000008', '栟茶', '1', '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000012', '1000012', '如东三角渡粮食库', '1', '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000021', '1000021', '新林粮站', '1', '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000022', '1000022', '孙窑粮站', '1', '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000023', '1000023', '凌河粮站', '1', '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000024', '1000024', '曹埠粮站', '1', '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `t_warehouse_location` VALUES ('1000025', '1000025', '石屏粮站', '1', '1', null, null, null, null, null, null, null, null, null);
