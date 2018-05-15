/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:01:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_contrast_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `t_contrast_warehouse`;
CREATE TABLE `t_contrast_warehouse` (
  `cangfangbianhao` varchar(3) DEFAULT NULL COMMENT '仓房编号',
  `huoweibianhao` varchar(3) DEFAULT NULL COMMENT '货位编号',
  `warehose_id` int(11) NOT NULL,
  PRIMARY KEY (`warehose_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_contrast_warehouse
-- ----------------------------
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000002001');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000002002');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '001', '1000002003');
INSERT INTO `t_contrast_warehouse` VALUES ('004', '002', '1000002004');
INSERT INTO `t_contrast_warehouse` VALUES ('005', '001', '1000002005');
INSERT INTO `t_contrast_warehouse` VALUES ('006', '002', '1000002006');
INSERT INTO `t_contrast_warehouse` VALUES ('007', '001', '1000002007');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000003001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000003002');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000003003');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '004', '1000003004');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '005', '1000003005');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '006', '1000003006');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000003007');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000003008');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '003', '1000003009');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '004', '1000003010');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '005', '1000003011');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000008001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000008002');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000008003');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000008004');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000008005');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '003', '1000008006');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '001', '1000008007');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '002', '1000008008');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '003', '1000008009');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '004', '1000008010');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '005', '1000008011');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000012001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000012002');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000012003');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '004', '1000012004');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '005', '1000012005');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000012006');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000012007');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000021001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000021002');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000021003');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000021006');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000021007');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000021008');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000022001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000022002');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000022003');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '004', '1000022004');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000022005');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000022006');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '003', '1000022007');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '004', '1000022008');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '001', '1000022009');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '002', '1000022010');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '003', '1000022011');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '004', '1000022012');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000023001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000023002');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000023003');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000023004');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000023005');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '003', '1000023006');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '001', '1000023007');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '002', '1000023008');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '003', '1000023009');
INSERT INTO `t_contrast_warehouse` VALUES ('004', '001', '1000023010');
INSERT INTO `t_contrast_warehouse` VALUES ('004', '002', '1000023011');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000024001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000024002');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000024003');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000024004');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '001', '1000024005');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '002', '1000024006');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '001', '1000025001');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '002', '1000025002');
INSERT INTO `t_contrast_warehouse` VALUES ('001', '003', '1000025003');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000025004');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '002', '1000025005');
INSERT INTO `t_contrast_warehouse` VALUES ('002', '001', '1000025006');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '002', '1000025007');
INSERT INTO `t_contrast_warehouse` VALUES ('003', '003', '1000025008');
INSERT INTO `t_contrast_warehouse` VALUES ('004', '001', '1000025009');
INSERT INTO `t_contrast_warehouse` VALUES ('004', '002', '1000025010');
