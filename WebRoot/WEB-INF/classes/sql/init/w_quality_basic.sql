/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:04:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for w_quality_basic
-- ----------------------------
DROP TABLE IF EXISTS `w_quality_basic`;
CREATE TABLE `w_quality_basic` (
  `Code` varchar(10) NOT NULL COMMENT '品种编码',
  `Name` varchar(45) DEFAULT NULL COMMENT '品种名称',
  `DiyName` varchar(45) DEFAULT NULL COMMENT '自定义名称',
  `Abbreviation` varchar(45) DEFAULT NULL COMMENT '缩写',
  `SalePrice` varchar(45) DEFAULT NULL,
  `BuyPrice` varchar(45) DEFAULT NULL COMMENT '收购单价',
  `StepPrice` varchar(45) DEFAULT NULL COMMENT '等级差价',
  `Level` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of w_quality_basic
-- ----------------------------
INSERT INTO `w_quality_basic` VALUES ('1114', '混合小麦', '混合小麦', 'HHXM', '0.00', '118.00', '2.00', '3');
INSERT INTO `w_quality_basic` VALUES ('1132002', '晚粳稻谷', '晚粳稻谷', 'WJDG', '0.00', '155.00', '2.00', '3');
