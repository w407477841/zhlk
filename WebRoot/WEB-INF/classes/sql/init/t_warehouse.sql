/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:03:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse`;
CREATE TABLE `t_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wNo` varchar(16) NOT NULL,
  `wName` varchar(32) DEFAULT NULL,
  `wHeight` int(11) DEFAULT NULL,
  `wColumn` int(11) DEFAULT NULL,
  `wRow` int(11) DEFAULT NULL,
  `wLocation` int(11) DEFAULT NULL,
  `wStatus` int(11) DEFAULT NULL,
  `wDisable` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_warehouse_whlocation` (`wLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=1000025011 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_warehouse
-- ----------------------------
INSERT INTO `t_warehouse` VALUES ('1000002001', 'f0101', '仓库1', '4', '8', '6', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002002', 'f0102', '仓库2', '4', '8', '6', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002003', 'f0103', '仓库3', '4', '8', '6', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002004', 'f0104', '仓库4', '4', '8', '6', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002005', 'f0105', '仓库5', '3', '7', '6', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002006', 'f0106', '仓库6', '3', '8', '6', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002007', 'f0107', '仓库7', '4', '6', '7', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002008', 'f0108', '仓库8', '4', '6', '7', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002009', 'f0109', '仓库9', '4', '6', '7', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000002010', 'f0110', '仓库10', '5', '7', '7', '1000002', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003001', '1号仓', '仓库1', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003002', '2号仓', '仓库2', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003003', '3号仓', '仓库3', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003004', '4号仓', '仓库4', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003005', '5号仓', '仓库5', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003006', '6号仓', '仓库6', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003007', '7号仓', '仓库7', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003008', '8号仓', '仓库8', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003009', '9号仓', '仓库9', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003010', '10号仓', '仓库10', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000003011', '11号仓', '仓库11', '4', '5', '6', '1000003', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008001', 'P1', '仓库1', '4', '7', '6', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008002', 'P2', '仓库2', '4', '7', '6', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008003', 'P3', '仓库3', '4', '7', '6', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008004', 'P4', '仓库4', '4', '7', '6', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008005', 'P5', '仓库5', '4', '7', '6', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008006', 'P6', '仓库6', '4', '7', '6', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008007', 'P7', '仓库7', '4', '5', '5', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008008', 'P8', '仓库8', '4', '5', '5', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008009', 'P9', '仓库9', '4', '4', '5', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008010', 'P10', '仓库10', '4', '4', '5', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000008011', 'P11', '仓库11', '4', '4', '5', '1000008', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000012001', 'sjd1', '仓库1', '4', '5', '6', '1000012', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000012002', 'sjd2', '仓库2', '4', '5', '6', '1000012', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000012003', 'sjd3', '仓库3', '4', '5', '6', '1000012', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000012004', 'sjd4', '仓库4', '4', '5', '6', '1000012', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000012005', 'sjd5', '仓库5', '4', '5', '6', '1000012', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000012006', 'sjd6', '仓库6', '4', '5', '6', '1000012', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000012007', 'sjd7', '仓库7', '4', '5', '6', '1000012', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000021006', 'xl6', '仓库6', '4', '5', '6', '1000021', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000021007', 'xl7', '仓库7', '4', '5', '6', '1000021', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000021008', 'xl8', '仓库8', '4', '5', '6', '1000021', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022001', 'sy1', '仓库1', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022002', 'sy2', '仓库2', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022003', 'sy3', '仓库3', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022004', 'sy4', '仓库4', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022005', 'sy5', '仓库5', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022006', 'sy6', '仓库6', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022007', 'sy7', '仓库7', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022008', 'sy8', '仓库8', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022009', 'sy9', '仓库9', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022010', 'sy10', '仓库10', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022011', 'sy11', '仓库11', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000022012', 'sy12', '仓库12', '4', '5', '6', '1000022', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023001', 'lh1', '仓库1', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023002', 'lh2', '仓库2', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023003', 'lh3', '仓库3', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023004', 'lh4', '仓库4', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023005', 'lh5', '仓库5', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023006', 'lh6', '仓库6', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023007', 'lh7', '仓库7', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023008', 'lh8', '仓库8', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023009', 'lh9', '仓库9', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023010', 'lh10', '仓库10', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000023011', 'lh11', '仓库11', '4', '5', '6', '1000023', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000024001', 'cb1', '仓库1', '4', '5', '6', '1000024', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000024002', 'cb2', '仓库2', '4', '5', '6', '1000024', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000024003', 'cb3', '仓库3', '4', '5', '6', '1000024', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000024004', 'cb4', '仓库4', '4', '5', '6', '1000024', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000024005', 'cb5', '仓库5', '4', '5', '6', '1000024', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000024006', 'cb6', '仓库6', '4', '5', '6', '1000024', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025001', 'sp1', '仓库1', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025002', 'sp2', '仓库2', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025003', 'sp3', '仓库3', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025004', 'sp4', '仓库4', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025005', 'sp5', '仓库5', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025006', 'sp6', '仓库6', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025007', 'sp7', '仓库7', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025008', 'sp8', '仓库8', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025009', 'sp9', '仓库9', '4', '5', '6', '1000025', '1', '1');
INSERT INTO `t_warehouse` VALUES ('1000025010', 'sp10', '仓库10', '4', '5', '6', '1000025', '1', '1');
