/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:01:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_contrast_location
-- ----------------------------
DROP TABLE IF EXISTS `t_contrast_location`;
CREATE TABLE `t_contrast_location` (
  `tongyixinyongdaima` varchar(10) DEFAULT NULL COMMENT '统一信用代码',
  `kuqubianma` varchar(3) DEFAULT NULL COMMENT '库区编码',
  `location_no` varchar(10) NOT NULL COMMENT '库点编码',
  `qiyemingcheng` varchar(50) DEFAULT NULL COMMENT '企业名称',
  PRIMARY KEY (`location_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_contrast_location
-- ----------------------------
INSERT INTO `t_contrast_location` VALUES ('690266497', '001', '1000002', '岔河');
INSERT INTO `t_contrast_location` VALUES ('138651543', '001', '1000003', '马塘');
INSERT INTO `t_contrast_location` VALUES ('138651615', '001', '1000008', '栟茶');
INSERT INTO `t_contrast_location` VALUES ('138651615', '002', '1000012', '栟茶');
INSERT INTO `t_contrast_location` VALUES ('138651615', '003', '1000021', '栟茶');
INSERT INTO `t_contrast_location` VALUES ('138651543', '002', '1000022', '马塘');
INSERT INTO `t_contrast_location` VALUES ('138651543', '003', '1000023', '马塘');
INSERT INTO `t_contrast_location` VALUES ('138651543', '004', '1000024', '马塘');
INSERT INTO `t_contrast_location` VALUES ('138651543', '005', '1000025', '马塘');
