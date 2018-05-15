/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 12:19:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_appointment_grain
-- ----------------------------
DROP TABLE IF EXISTS `t_appointment_grain`;
CREATE TABLE `t_appointment_grain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agBill` varchar(16) NOT NULL COMMENT '预约号',
  `agIDCard` varchar(18) NOT NULL COMMENT '身份证',
  `agName` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `agVariety` int(11) NOT NULL COMMENT '品种',
  `agNumber` float NOT NULL DEFAULT '0' COMMENT '数量',
  `agAppointmentDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '预约日期',
  `agAddress` varchar(128) NOT NULL DEFAULT '' COMMENT '地址',
  `agAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加日期',
  `agDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='预约缴粮';

-- ----------------------------
-- Table structure for t_appointment_grain_his
-- ----------------------------
DROP TABLE IF EXISTS `t_appointment_grain_his`;
CREATE TABLE `t_appointment_grain_his` (
  `id` int(11) DEFAULT NULL,
  `agBill` varchar(16) NOT NULL COMMENT '预约号',
  `agIDCard` varchar(18) NOT NULL COMMENT '身份证',
  `agName` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `agVariety` int(11) NOT NULL COMMENT '品种',
  `agNumber` float NOT NULL DEFAULT '0' COMMENT '数量',
  `agAppointmentDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '预约日期',
  `agAddress` varchar(128) NOT NULL DEFAULT '' COMMENT '地址',
  `agAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加日期',
  `agDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `aghUser` int(11) DEFAULT NULL COMMENT '操作者',
  `aghSQL` varchar(512) NOT NULL DEFAULT '' COMMENT '操作语句',
  `aghType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `aghOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预约缴粮操作历史';

-- ----------------------------
-- Table structure for t_bankroll_balance
-- ----------------------------
DROP TABLE IF EXISTS `t_bankroll_balance`;
CREATE TABLE `t_bankroll_balance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bbBill` varchar(32) NOT NULL,
  `bbName` varchar(32) NOT NULL DEFAULT '',
  `bbPlateNumber` varchar(16) NOT NULL DEFAULT '',
  `bbAssortment` varchar(32) NOT NULL DEFAULT '',
  `bbQuality` varchar(32) NOT NULL DEFAULT '',
  `bbGrade` varchar(32) NOT NULL DEFAULT '',
  `bbPrice` float NOT NULL DEFAULT '0',
  `bbSettleNumber` float NOT NULL DEFAULT '0',
  `bbSettleSum` float NOT NULL DEFAULT '0',
  `bbSettleStatus` varchar(32) NOT NULL DEFAULT '',
  `bbSettleDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `bbSettleCategory` varchar(32) NOT NULL DEFAULT '',
  `bbAccount` varchar(32) NOT NULL DEFAULT '',
  `bbSettlePerson` varchar(32) NOT NULL DEFAULT '',
  `bbDataOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bbBill` (`bbBill`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_bankroll_balance_his
-- ----------------------------
DROP TABLE IF EXISTS `t_bankroll_balance_his`;
CREATE TABLE `t_bankroll_balance_his` (
  `id` int(11) DEFAULT NULL,
  `bbBill` varchar(32) NOT NULL,
  `bbName` varchar(32) NOT NULL DEFAULT '',
  `bbPlateNumber` varchar(16) NOT NULL DEFAULT '',
  `bbAssortment` varchar(32) NOT NULL DEFAULT '',
  `bbQuality` varchar(32) NOT NULL DEFAULT '',
  `bbGrade` varchar(32) NOT NULL DEFAULT '',
  `bbPrice` float NOT NULL DEFAULT '0',
  `bbSettleNumber` float NOT NULL DEFAULT '0',
  `bbSettleSum` float NOT NULL DEFAULT '0',
  `bbSettleStatus` varchar(32) NOT NULL DEFAULT '',
  `bbSettleDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `bbSettleCategory` varchar(32) NOT NULL DEFAULT '',
  `bbAccount` varchar(32) NOT NULL DEFAULT '',
  `bbSettlePerson` varchar(32) NOT NULL DEFAULT '',
  `bbDataOperator` int(11) DEFAULT NULL,
  `bbhUser` int(11) DEFAULT NULL,
  `bbhSQL` text NOT NULL,
  `bbhType` varchar(32) NOT NULL DEFAULT '',
  `bbhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `version` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_bankroll_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_bankroll_plan`;
CREATE TABLE `t_bankroll_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bpBill` varchar(32) NOT NULL,
  `bpGrandPerson` varchar(32) NOT NULL DEFAULT '',
  `bpUpperMoney` varchar(64) NOT NULL DEFAULT '',
  `bpLowerMoney` int(11) NOT NULL DEFAULT '0',
  `bpPayee` varchar(32) NOT NULL DEFAULT '',
  `bpAccount` varchar(32) NOT NULL DEFAULT '',
  `bpUse` varchar(128) NOT NULL DEFAULT '',
  `bpGrandDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '0',
  `bpDataOperator` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bpBill` (`bpBill`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_bankroll_plan_his
-- ----------------------------
DROP TABLE IF EXISTS `t_bankroll_plan_his`;
CREATE TABLE `t_bankroll_plan_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bpBill` varchar(32) DEFAULT NULL,
  `bpGrandPerson` varchar(32) NOT NULL DEFAULT '',
  `bpUpperMoney` varchar(64) NOT NULL DEFAULT '',
  `bpLowerMoney` int(11) NOT NULL DEFAULT '0',
  `bpPayee` varchar(32) NOT NULL DEFAULT '',
  `bpAccount` varchar(32) NOT NULL DEFAULT '',
  `bpUse` varchar(128) NOT NULL DEFAULT '',
  `bpGrandDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '0',
  `bpDataOperator` int(11) DEFAULT NULL,
  `bphUser` int(11) DEFAULT NULL,
  `bphSQL` text NOT NULL,
  `bphType` varchar(32) NOT NULL DEFAULT '',
  `bphOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_business_agreement
-- ----------------------------
DROP TABLE IF EXISTS `t_business_agreement`;
CREATE TABLE `t_business_agreement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agreementID` varchar(50) DEFAULT NULL COMMENT '合同编号',
  `soldOnes` varchar(255) DEFAULT NULL COMMENT '出卖人',
  `buyOnes` varchar(255) DEFAULT NULL COMMENT '买售人',
  `signTime` varchar(22) DEFAULT NULL COMMENT '签合同时间',
  `planedActiviteTime` varchar(22) DEFAULT NULL COMMENT '计划履行合同时间',
  `realActiviteTime` varchar(22) DEFAULT NULL COMMENT '实际履行合同的时间',
  `signPlace` varchar(255) DEFAULT NULL COMMENT '签合同地点',
  `breed` varchar(255) DEFAULT NULL COMMENT '品种',
  `amounts` varchar(255) DEFAULT NULL COMMENT '数量(公斤)',
  `houseID` int(11) DEFAULT NULL COMMENT '仓号',
  `level` varchar(255) DEFAULT NULL COMMENT '等级',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `property` varchar(255) DEFAULT NULL COMMENT '粮食性质',
  `results` varchar(255) DEFAULT NULL COMMENT '履行结果',
  `templates` varchar(255) DEFAULT NULL COMMENT '合同模板',
  `states` varchar(5) DEFAULT '0' COMMENT '合同的 状态 0 未上传 1已上传',
  `location` varchar(255) DEFAULT NULL COMMENT '库点id',
  `files` varchar(255) DEFAULT NULL COMMENT '对应 t-common-file 的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_business_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_business_plan`;
CREATE TABLE `t_business_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `planId` varchar(20) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL COMMENT '粮食品种',
  `newPlanedAmount` varchar(255) DEFAULT NULL COMMENT '新增计划数量',
  `totalAmount` varchar(255) DEFAULT NULL,
  `turnPlannedAmount` varchar(255) DEFAULT NULL COMMENT '已完成的计划数量',
  `completedAmount` varchar(255) DEFAULT NULL COMMENT '已完成的数量',
  `type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `achieveYear` varchar(255) DEFAULT '' COMMENT '收货年份',
  `planedPrice` varchar(10) DEFAULT '' COMMENT '元/公斤',
  `planedTimeStart` varchar(20) DEFAULT NULL COMMENT '开始时间',
  `planedTimeEnd` varchar(20) DEFAULT NULL COMMENT '开始时间',
  `quailty` varchar(255) DEFAULT NULL COMMENT '质量',
  `department` varchar(255) DEFAULT NULL COMMENT '下达单位',
  `files` varchar(255) DEFAULT NULL COMMENT '上传的文件',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注',
  `planType` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL COMMENT '库点名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_business_plan_jiakong
-- ----------------------------
DROP TABLE IF EXISTS `t_business_plan_jiakong`;
CREATE TABLE `t_business_plan_jiakong` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `breed` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `days` varchar(255) DEFAULT NULL,
  `timestart` varchar(20) DEFAULT NULL,
  `timeend` varchar(20) DEFAULT NULL,
  `files` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL COMMENT '所属粮库',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_business_supply_company
-- ----------------------------
DROP TABLE IF EXISTS `t_business_supply_company`;
CREATE TABLE `t_business_supply_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '单位名称',
  `address` varchar(255) DEFAULT NULL COMMENT '通讯地址',
  `concator` varchar(255) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `message` varchar(255) DEFAULT NULL COMMENT '资信情况',
  `shougoubianhao` varchar(255) DEFAULT NULL COMMENT '收购许可证编号',
  `shengchanbianhao` varchar(255) DEFAULT NULL COMMENT '生产许可证编号',
  `weishengbianhao` varchar(255) DEFAULT NULL COMMENT '卫生许可证编号',
  `yingyezhizhao` varchar(255) DEFAULT NULL COMMENT '企业法人营业执照注册号',
  `icon` varchar(255) DEFAULT NULL COMMENT '注册商标',
  `standard` varchar(255) DEFAULT NULL COMMENT '企业(商)品采用的主要标准',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_business_supply_individual
-- ----------------------------
DROP TABLE IF EXISTS `t_business_supply_individual`;
CREATE TABLE `t_business_supply_individual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '客户名字',
  `ranges` varchar(255) DEFAULT NULL COMMENT '业务范围',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `concator` varchar(255) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `representer` varchar(255) DEFAULT NULL COMMENT '业务代表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_cangkudianwei
-- ----------------------------
DROP TABLE IF EXISTS `t_cangkudianwei`;
CREATE TABLE `t_cangkudianwei` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `cLeft` varchar(20) DEFAULT NULL,
  `cTop` varchar(20) DEFAULT NULL,
  `location_id` int(10) DEFAULT NULL,
  `lx` int(2) DEFAULT '1' COMMENT '1 仓库点位   ；2仓外传感器点位',
  `warehouse_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_chuanganqi
-- ----------------------------
DROP TABLE IF EXISTS `t_chuanganqi`;
CREATE TABLE `t_chuanganqi` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cIp` varchar(20) DEFAULT NULL COMMENT 'IP地址',
  `cPort` varchar(10) DEFAULT NULL COMMENT '端口',
  `lx` varchar(30) DEFAULT NULL COMMENT '类型',
  `zl` varchar(16) DEFAULT NULL COMMENT '指令',
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `cangkudianwei_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_chuanganqi_baojing
-- ----------------------------
DROP TABLE IF EXISTS `t_chuanganqi_baojing`;
CREATE TABLE `t_chuanganqi_baojing` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `common` varchar(200) DEFAULT NULL,
  `cjsj` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_chuanganqi_data
-- ----------------------------
DROP TABLE IF EXISTS `t_chuanganqi_data`;
CREATE TABLE `t_chuanganqi_data` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `chuanganqi_id` int(10) DEFAULT NULL,
  `datas` varchar(30) DEFAULT NULL,
  `cjsj` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_code
-- ----------------------------
DROP TABLE IF EXISTS `t_code`;
CREATE TABLE `t_code` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for t_codeitem
-- ----------------------------
DROP TABLE IF EXISTS `t_codeitem`;
CREATE TABLE `t_codeitem` (
  `id` int(20) DEFAULT NULL,
  `parentId` int(20) DEFAULT NULL,
  `codeid` int(10) DEFAULT NULL,
  `value` int(20) NOT NULL AUTO_INCREMENT,
  `text` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for t_common_file
-- ----------------------------
DROP TABLE IF EXISTS `t_common_file`;
CREATE TABLE `t_common_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(100) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
-- Table structure for t_credit_note
-- ----------------------------
DROP TABLE IF EXISTS `t_credit_note`;
CREATE TABLE `t_credit_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cnCustomName` varchar(32) NOT NULL DEFAULT '' COMMENT '客户姓名',
  `cnWId` int(11) DEFAULT NULL COMMENT '仓号',
  `cnYear` char(4) NOT NULL COMMENT '收获年度',
  `cnProperty` int(11) NOT NULL COMMENT '性质',
  `cnVariety` int(11) NOT NULL COMMENT '品种',
  `cnPayment` float NOT NULL DEFAULT '0' COMMENT '货款(元)',
  `cnMoneyDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '付款日期',
  `cnAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加日期',
  `cnDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='收款通知单';

-- ----------------------------
-- Table structure for t_credit_note_his
-- ----------------------------
DROP TABLE IF EXISTS `t_credit_note_his`;
CREATE TABLE `t_credit_note_his` (
  `id` int(11) DEFAULT NULL,
  `cnCustomName` varchar(32) NOT NULL DEFAULT '' COMMENT '客户姓名',
  `cnWId` int(11) DEFAULT NULL COMMENT '仓号',
  `cnYear` char(4) NOT NULL COMMENT '收获年度',
  `cnProperty` int(11) NOT NULL COMMENT '性质',
  `cnVariety` int(11) NOT NULL COMMENT '品种',
  `cnPayment` float NOT NULL DEFAULT '0' COMMENT '货款(元)',
  `cnMoneyDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '付款日期',
  `cnAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加日期',
  `cnDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `cnhUser` int(11) DEFAULT NULL COMMENT '操作者',
  `cnhSQL` varchar(512) NOT NULL DEFAULT '' COMMENT '操作语句',
  `cnhType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `cnhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收款通知单操作记录';

-- ----------------------------
-- Table structure for t_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `t_enterprise`;
CREATE TABLE `t_enterprise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eName` varchar(50) DEFAULT NULL COMMENT '企业名称',
  `eGroupCode` varchar(20) DEFAULT NULL COMMENT '组织机构代码',
  `eAddrCode` varchar(20) DEFAULT NULL COMMENT '行政区划代码',
  `eLocation` varchar(50) DEFAULT NULL COMMENT '通讯地址',
  `ePerson` varchar(30) DEFAULT NULL COMMENT '法人名称',
  `ePhone` varchar(20) DEFAULT NULL COMMENT '电话',
  `eCredit` varchar(20) DEFAULT NULL COMMENT '资信情况',
  `eNature` varchar(10) DEFAULT NULL COMMENT '企业性质',
  `eClassify` varchar(10) DEFAULT NULL COMMENT '企业经营类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_getout_storage_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_apply`;
CREATE TABLE `t_getout_storage_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gsaApplyBill` varchar(32) NOT NULL DEFAULT '' COMMENT '申请单编号',
  `gsaSendOutDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发货时间',
  `gsaPurchaser` varchar(32) NOT NULL DEFAULT '' COMMENT '买受人',
  `gsaAgreementBill` int(11) NOT NULL COMMENT '合同号',
  `gsaPaymentSituation` varchar(16) NOT NULL DEFAULT '未到账' COMMENT '货款到账情况',
  `gsaPlanOutWeight` float NOT NULL DEFAULT '0' COMMENT '计划出库数量',
  `gsaWId` int(11) NOT NULL COMMENT '发货仓号',
  `gsaCurrentWeight` float NOT NULL DEFAULT '0' COMMENT '当前数量',
  `gsaApplyPerson` varchar(32) NOT NULL DEFAULT '' COMMENT '申请人',
  `gsaApplyDepartment` int(11) NOT NULL COMMENT '申请部门',
  `gsaTransferTools` varchar(64) NOT NULL DEFAULT '' COMMENT '运输工具',
  `gsaProcess` varchar(32) NOT NULL DEFAULT '保存' COMMENT '申请状态',
  `gsaRemark` varchar(128) NOT NULL DEFAULT '' COMMENT '审核备注',
  `gsaAuditor` int(11) DEFAULT NULL COMMENT '审批人',
  `gsaAuditingDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审批时间',
  `gsaAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `gsaDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='出库申请';

-- ----------------------------
-- Table structure for t_getout_storage_apply_his
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_apply_his`;
CREATE TABLE `t_getout_storage_apply_his` (
  `id` int(11) DEFAULT NULL,
  `gsaApplyBill` varchar(32) NOT NULL DEFAULT '' COMMENT '申请单编号',
  `gsaSendOutDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '发货时间',
  `gsaPurchaser` varchar(32) NOT NULL DEFAULT '' COMMENT '买受人',
  `gsaAgreementBill` int(11) NOT NULL COMMENT '合同号',
  `gsaPaymentSituation` varchar(16) NOT NULL DEFAULT '未到账' COMMENT '货款到账情况',
  `gsaPlanOutWeight` float NOT NULL DEFAULT '0' COMMENT '计划出库数量',
  `gsaWId` int(11) NOT NULL COMMENT '发货仓号',
  `gsaCurrentWeight` float NOT NULL DEFAULT '0' COMMENT '当前数量',
  `gsaApplyPerson` varchar(32) NOT NULL DEFAULT '' COMMENT '申请人',
  `gsaApplyDepartment` int(11) NOT NULL COMMENT '申请部门',
  `gsaTransferTools` varchar(64) NOT NULL DEFAULT '' COMMENT '运输工具',
  `gsaProcess` varchar(32) NOT NULL DEFAULT '保存' COMMENT '申请状态',
  `gsaRemark` varchar(128) NOT NULL DEFAULT '' COMMENT '审核备注',
  `gsaAuditor` int(11) DEFAULT NULL COMMENT '审批人',
  `gsaAuditingDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审批时间',
  `gsaAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `gsaDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `gsahUser` int(11) DEFAULT NULL COMMENT '操作者',
  `gsahSQL` text COMMENT '操作语句',
  `gsahType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `gsahOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_getout_storage_apply_transfer_tools
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_apply_transfer_tools`;
CREATE TABLE `t_getout_storage_apply_transfer_tools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gsaaNo` varchar(16) NOT NULL DEFAULT '' COMMENT '车船号',
  `gsaaWeight` varchar(32) NOT NULL DEFAULT '' COMMENT '车船吨位',
  `gsaaDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='需方运输工具';

-- ----------------------------
-- Table structure for t_getout_storage_auditing
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_auditing`;
CREATE TABLE `t_getout_storage_auditing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gsaApplyBill` varchar(32) NOT NULL DEFAULT '' COMMENT '申请编号',
  `gsaAuditor` int(11) NOT NULL COMMENT '审核人',
  `gsaAuditingDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核日期',
  `gsaProcess` varchar(32) NOT NULL DEFAULT '' COMMENT '审核结果',
  `gsaRemark` varchar(128) NOT NULL DEFAULT '' COMMENT '审批意见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='出库申请审批记录';

-- ----------------------------
-- Table structure for t_getout_storage_loss
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_loss`;
CREATE TABLE `t_getout_storage_loss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gslWId` int(11) NOT NULL COMMENT '仓号',
  `gslCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `gslPutInDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '进仓时间',
  `gslGetOutDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出仓日期',
  `gslSaveDays` int(11) NOT NULL DEFAULT '0' COMMENT '保管天数',
  `gslPutInFluid` float NOT NULL DEFAULT '0' COMMENT '进仓水分',
  `gslPutInImpurity` float NOT NULL DEFAULT '0' COMMENT '进仓杂质',
  `gslPutInWeight` float NOT NULL DEFAULT '0' COMMENT '进仓数量',
  `gslGetOutFluid` float NOT NULL DEFAULT '0' COMMENT '出库水分',
  `gslGetOutImpurity` float NOT NULL DEFAULT '0' COMMENT '出库杂质',
  `gslGetOutWeight` float NOT NULL DEFAULT '0' COMMENT '出库数量',
  `gslTotalReduce` float NOT NULL DEFAULT '0' COMMENT '总损耗量',
  `gslLossRate` float NOT NULL DEFAULT '0' COMMENT '保管自然耗比率',
  `gslLossWeight` float NOT NULL DEFAULT '0' COMMENT '保管自然耗数量',
  `gslCleanUpWeight` float NOT NULL DEFAULT '0' COMMENT '整理水杂耗数量',
  `gslOverrateWeight` float NOT NULL DEFAULT '0' COMMENT '超定额耗损',
  `gslOverflowWeight` float NOT NULL DEFAULT '0' COMMENT '溢余',
  `gslAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `gslDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_getout_storage_loss_his
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_loss_his`;
CREATE TABLE `t_getout_storage_loss_his` (
  `id` int(11) DEFAULT NULL,
  `gslWId` int(11) NOT NULL COMMENT '仓号',
  `gslCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `gslPutInDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '进仓时间',
  `gslGetOutDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '出仓日期',
  `gslSaveDays` int(11) NOT NULL DEFAULT '0' COMMENT '保管天数',
  `gslPutInFluid` float NOT NULL DEFAULT '0' COMMENT '进仓水分',
  `gslPutInImpurity` float NOT NULL DEFAULT '0' COMMENT '进仓杂质',
  `gslPutInWeight` float NOT NULL DEFAULT '0' COMMENT '进仓数量',
  `gslGetOutFluid` float NOT NULL DEFAULT '0' COMMENT '出库水分',
  `gslGetOutImpurity` float NOT NULL DEFAULT '0' COMMENT '出库杂质',
  `gslGetOutWeight` float NOT NULL DEFAULT '0' COMMENT '出库数量',
  `gslTotalReduce` float NOT NULL DEFAULT '0' COMMENT '总损耗量',
  `gslLossRate` float NOT NULL DEFAULT '0' COMMENT '保管自然耗比率',
  `gslLossWeight` float NOT NULL DEFAULT '0' COMMENT '保管自然耗数量',
  `gslCleanUpWeight` float NOT NULL DEFAULT '0' COMMENT '整理水杂耗数量',
  `gslOverrateWeight` float NOT NULL DEFAULT '0' COMMENT '超定额耗损',
  `gslOverflowWeight` float NOT NULL DEFAULT '0' COMMENT '溢余',
  `gslAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `gslDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `gslhUser` int(11) DEFAULT NULL COMMENT '操作者',
  `gslhSQL` text NOT NULL COMMENT '操作语句',
  `gslhType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `gslhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_getout_storage_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_plan`;
CREATE TABLE `t_getout_storage_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gspFileName` varchar(64) NOT NULL DEFAULT '' COMMENT '文件名称',
  `gspWId` int(11) NOT NULL COMMENT '仓号',
  `gspVariety` varchar(32) NOT NULL COMMENT '粮食性质',
  `gspCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `gspWeight` float NOT NULL COMMENT '数量(公斤)',
  `gspBeginDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `gspEndDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `gspContent` varchar(512) NOT NULL DEFAULT '' COMMENT '内容',
  `gspAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `gspDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_getout_storage_plan_his
-- ----------------------------
DROP TABLE IF EXISTS `t_getout_storage_plan_his`;
CREATE TABLE `t_getout_storage_plan_his` (
  `id` int(11) DEFAULT NULL,
  `gspFileName` varchar(64) NOT NULL DEFAULT '' COMMENT '文件名称',
  `gspWId` int(11) NOT NULL COMMENT '仓号',
  `gspVariety` varchar(32) NOT NULL COMMENT '粮食性质',
  `gspCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `gspWeight` float NOT NULL COMMENT '数量(公斤)',
  `gspBeginDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '开始时间',
  `gspEndDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `gspContent` varchar(512) NOT NULL DEFAULT '' COMMENT '内容',
  `gspAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `gspDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `gsphUser` int(11) DEFAULT NULL COMMENT '操作者',
  `gsphSQL` text NOT NULL COMMENT '操作语句',
  `gsphType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `gsphOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_info_release
-- ----------------------------
DROP TABLE IF EXISTS `t_info_release`;
CREATE TABLE `t_info_release` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `irType` int(11) DEFAULT NULL COMMENT '信息类型',
  `irTitle` varchar(128) NOT NULL DEFAULT '' COMMENT '信息标题',
  `irContent` text COMMENT '信息内容',
  `irAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加日期',
  `irLevel` int(11) NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `irDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='信息发布';

-- ----------------------------
-- Table structure for t_info_release_his
-- ----------------------------
DROP TABLE IF EXISTS `t_info_release_his`;
CREATE TABLE `t_info_release_his` (
  `id` int(11) DEFAULT NULL,
  `irType` int(11) DEFAULT NULL COMMENT '信息类型',
  `irTitle` varchar(128) DEFAULT NULL COMMENT '信息标题',
  `irContent` text COMMENT '信息内容',
  `irAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加日期',
  `irLevel` int(11) NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `irDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) DEFAULT NULL,
  `irhUser` int(11) DEFAULT NULL COMMENT '操作者',
  `irhSQL` varchar(512) NOT NULL DEFAULT '' COMMENT '操作语句',
  `irhType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `irhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息发布历史记录';

-- ----------------------------
-- Table structure for t_info_type
-- ----------------------------
DROP TABLE IF EXISTS `t_info_type`;
CREATE TABLE `t_info_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itName` varchar(64) NOT NULL DEFAULT '' COMMENT '类型名称',
  `itParentId` int(11) NOT NULL DEFAULT '1' COMMENT '所属父类',
  `itAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加日期',
  `itDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='信息类型';

-- ----------------------------
-- Table structure for t_instorage
-- ----------------------------
DROP TABLE IF EXISTS `t_instorage`;
CREATE TABLE `t_instorage` (
  `ID` varchar(64) NOT NULL COMMENT '流水单号',
  `Owner` varchar(45) DEFAULT NULL COMMENT '货主姓名',
  `Identity` varchar(45) DEFAULT NULL COMMENT '身份证号码',
  `Phone` varchar(45) DEFAULT NULL COMMENT '手机号',
  `Address` varchar(45) DEFAULT NULL COMMENT '联系地址',
  `Category` varchar(45) DEFAULT NULL COMMENT '粮食类别',
  `Breed` varchar(45) DEFAULT NULL COMMENT '粮食品种',
  `Property` varchar(45) DEFAULT NULL COMMENT '粮食的性质',
  `CarID` varchar(20) DEFAULT NULL COMMENT '车(船)号',
  `StorageID` varchar(5) DEFAULT NULL COMMENT '入库号',
  `useCar` varchar(4) DEFAULT '0' COMMENT '0:不使用,1使用',
  `State` varchar(5) DEFAULT NULL COMMENT '流水状态 \n1:入库\n2:出库\n3:称重结束\n4:结算',
  `CreateTime` datetime DEFAULT NULL COMMENT '创建时间',
  `PayTime` varchar(45) DEFAULT NULL,
  `inorout` varchar(45) DEFAULT '' COMMENT '1入库 0出库',
  `Payway` varchar(255) DEFAULT NULL COMMENT '结算类型 1现金 2转账',
  `JSY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库流水表';

-- ----------------------------
-- Table structure for t_instorage_register
-- ----------------------------
DROP TABLE IF EXISTS `t_instorage_register`;
CREATE TABLE `t_instorage_register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `codeName` varchar(255) DEFAULT NULL,
  `bornDate` datetime DEFAULT NULL,
  `storageWay` varchar(255) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `amounts` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `bornPlace` varchar(255) DEFAULT NULL,
  `bornYear` varchar(255) DEFAULT NULL,
  `inDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_interface_data_config
-- ----------------------------
DROP TABLE IF EXISTS `t_interface_data_config`;
CREATE TABLE `t_interface_data_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idcTableName` varchar(32) NOT NULL COMMENT '数据表名称',
  `idcPrimaryKey` varchar(32) NOT NULL DEFAULT '' COMMENT '查询的字段名',
  `idcPrimaryValue` varchar(32) NOT NULL DEFAULT '' COMMENT '查询的数据值',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='数据上报接口-数据配置';

-- ----------------------------
-- Table structure for t_large_equipment
-- ----------------------------
DROP TABLE IF EXISTS `t_large_equipment`;
CREATE TABLE `t_large_equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leNo` varchar(32) DEFAULT NULL,
  `leName` varchar(64) NOT NULL DEFAULT '',
  `leStandard` varchar(32) NOT NULL DEFAULT '',
  `leWorth` float NOT NULL DEFAULT '0',
  `leMotorsNumber` int(11) NOT NULL DEFAULT '0',
  `lePower` float NOT NULL DEFAULT '0',
  `leTelephone` varchar(16) NOT NULL DEFAULT '',
  `leZipCode` char(6) NOT NULL DEFAULT '',
  `leUsedDate` timestamp NULL DEFAULT NULL,
  `leLocation` varchar(32) NOT NULL DEFAULT '',
  `leManufacturingUnit` varchar(128) NOT NULL DEFAULT '',
  `leManufacturingAddress` varchar(128) NOT NULL DEFAULT '',
  `leSon` varchar(256) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL DEFAULT '1',
  `leDataOperator` int(11) DEFAULT NULL,
  `leType` int(11) NOT NULL,
  `leUnit` int(11) NOT NULL,
  `leAddDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `leNo` (`leNo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_large_equipment_appendix
-- ----------------------------
DROP TABLE IF EXISTS `t_large_equipment_appendix`;
CREATE TABLE `t_large_equipment_appendix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leaName` varchar(64) NOT NULL DEFAULT '',
  `leaStandard` varchar(32) NOT NULL DEFAULT '',
  `leaNumber` int(11) NOT NULL DEFAULT '0',
  `version` int(11) NOT NULL DEFAULT '1',
  `leaDataOperator` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_large_equipment_his
-- ----------------------------
DROP TABLE IF EXISTS `t_large_equipment_his`;
CREATE TABLE `t_large_equipment_his` (
  `id` int(11) DEFAULT NULL,
  `leNo` varchar(32) DEFAULT NULL,
  `leName` varchar(64) NOT NULL DEFAULT '',
  `leStandard` varchar(32) NOT NULL DEFAULT '',
  `leWorth` float NOT NULL DEFAULT '0',
  `leMotorsNumber` int(11) NOT NULL DEFAULT '0',
  `lePower` float NOT NULL DEFAULT '0',
  `leTelephone` varchar(16) NOT NULL DEFAULT '',
  `leZipCode` char(6) NOT NULL DEFAULT '',
  `leUsedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `leLocation` varchar(32) NOT NULL DEFAULT '',
  `leManufacturingUnit` varchar(128) NOT NULL DEFAULT '',
  `leManufacturingAddress` varchar(128) NOT NULL DEFAULT '',
  `leSon` varchar(256) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL DEFAULT '1',
  `leDataOperator` int(11) DEFAULT NULL,
  `lehUser` int(11) DEFAULT NULL,
  `lehSQL` text NOT NULL,
  `lehType` varchar(32) NOT NULL DEFAULT '',
  `lehOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `leType` int(11) DEFAULT NULL,
  `leUnit` int(11) DEFAULT NULL,
  `leAddDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_large_equipment_repair
-- ----------------------------
DROP TABLE IF EXISTS `t_large_equipment_repair`;
CREATE TABLE `t_large_equipment_repair` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leId` int(11) DEFAULT NULL,
  `lerContent` varchar(256) NOT NULL DEFAULT '',
  `lerRepairDate` varchar(16) NOT NULL DEFAULT '',
  `lerRepairUser` varchar(32) NOT NULL DEFAULT '',
  `lerAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `lerDataOperator` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_large_equipment_repair_his
-- ----------------------------
DROP TABLE IF EXISTS `t_large_equipment_repair_his`;
CREATE TABLE `t_large_equipment_repair_his` (
  `id` int(11) DEFAULT NULL,
  `leId` int(11) DEFAULT NULL,
  `lerContent` varchar(256) NOT NULL DEFAULT '',
  `lerRepairDate` varchar(16) NOT NULL DEFAULT '',
  `lerRepairUser` varchar(32) NOT NULL DEFAULT '',
  `lerAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `lerDataOperator` int(11) DEFAULT NULL,
  `lerhUser` int(11) DEFAULT NULL,
  `lerhSQL` text NOT NULL,
  `lerhType` varchar(32) NOT NULL DEFAULT '',
  `lerhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_large_equipment_wreck
-- ----------------------------
DROP TABLE IF EXISTS `t_large_equipment_wreck`;
CREATE TABLE `t_large_equipment_wreck` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `leId` int(11) DEFAULT NULL,
  `lewCause` varchar(256) NOT NULL DEFAULT '',
  `lewDate` varchar(15) NOT NULL DEFAULT '',
  `lewAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `lewDataOperator` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_large_equipment_wreck_his
-- ----------------------------
DROP TABLE IF EXISTS `t_large_equipment_wreck_his`;
CREATE TABLE `t_large_equipment_wreck_his` (
  `id` int(11) DEFAULT NULL,
  `leId` int(11) DEFAULT NULL,
  `lewCause` varchar(256) NOT NULL DEFAULT '',
  `lewDate` varchar(15) NOT NULL DEFAULT '',
  `lewAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `version` int(11) NOT NULL DEFAULT '1',
  `lewDataOperator` int(11) DEFAULT NULL,
  `lewhUser` int(11) DEFAULT NULL,
  `lewhSQL` text NOT NULL,
  `lewhType` varchar(32) NOT NULL DEFAULT '',
  `lewhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_library_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_library_detail`;
CREATE TABLE `t_library_detail` (
  `id` varchar(255) DEFAULT NULL,
  `data_Time` varchar(25) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `warehouse` varchar(255) DEFAULT NULL,
  `storageid` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `total_weight` double DEFAULT NULL,
  `car_weight` double DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `blii` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountName` varchar(30) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `methods` varchar(100) DEFAULT NULL,
  `actionTime` varchar(30) DEFAULT NULL,
  `userIP` varchar(30) DEFAULT NULL,
  `operTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for t_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_login_log`;
CREATE TABLE `t_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `accountName` varchar(20) DEFAULT NULL,
  `loginTime` varchar(20) DEFAULT NULL,
  `loginIP` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_user_loginlist` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for t_medicament_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_apply`;
CREATE TABLE `t_medicament_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maBill` varchar(32) NOT NULL,
  `maMrId` int(11) DEFAULT NULL,
  `maName` varchar(128) NOT NULL DEFAULT '',
  `maBrand` varchar(128) NOT NULL DEFAULT '',
  `maPage` int(11) NOT NULL,
  `maStandard` varchar(64) NOT NULL DEFAULT '',
  `maUnit` varchar(128) NOT NULL DEFAULT '',
  `maApplyDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `maManufactureDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `maProductCompany` varchar(128) NOT NULL DEFAULT '',
  `maQuantity` int(11) NOT NULL DEFAULT '0',
  `maApplicant` varchar(64) NOT NULL DEFAULT '',
  `maAuditor` int(11) DEFAULT NULL,
  `maProcess` varchar(16) NOT NULL DEFAULT '',
  `maUsed` varchar(256) NOT NULL DEFAULT '',
  `maOpinion` varchar(256) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL DEFAULT '1',
  `maAuditingDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `maDataOperator` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `maBill` (`maBill`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_apply_his
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_apply_his`;
CREATE TABLE `t_medicament_apply_his` (
  `id` int(11) DEFAULT NULL,
  `maBill` varchar(32) NOT NULL,
  `maMrId` int(11) DEFAULT NULL,
  `maName` varchar(128) NOT NULL DEFAULT '',
  `maBrand` varchar(128) NOT NULL DEFAULT '',
  `maPage` int(11) NOT NULL,
  `maStandard` varchar(64) NOT NULL DEFAULT '',
  `maUnit` varchar(128) NOT NULL DEFAULT '',
  `maApplyDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `maManufactureDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `maProductCompany` varchar(128) NOT NULL DEFAULT '',
  `maQuantity` int(11) NOT NULL DEFAULT '0',
  `maApplicant` varchar(64) NOT NULL DEFAULT '',
  `maAuditor` int(11) DEFAULT NULL,
  `maProcess` varchar(16) NOT NULL DEFAULT '',
  `maUsed` varchar(256) NOT NULL DEFAULT '',
  `maOpinion` varchar(256) NOT NULL DEFAULT '',
  `maAuditingDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `maDataOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `mahUser` int(11) DEFAULT NULL,
  `mahSQL` text NOT NULL,
  `mahType` varchar(32) NOT NULL DEFAULT '',
  `mahOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_auditing
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_auditing`;
CREATE TABLE `t_medicament_auditing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maBill` varchar(32) DEFAULT NULL,
  `maAuditor` int(11) DEFAULT NULL,
  `maAuditingDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `maResult` varchar(128) DEFAULT NULL,
  `maOpinion` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_dispose
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_dispose`;
CREATE TABLE `t_medicament_dispose` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mdWarehouseId` int(11) DEFAULT NULL,
  `mdFumigateDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `mdBeginDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mdNumber` int(11) NOT NULL DEFAULT '0',
  `mdParticipant` varchar(64) NOT NULL DEFAULT '',
  `mdProcessMode` varchar(128) NOT NULL DEFAULT '',
  `mdOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mdDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_dispose_his
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_dispose_his`;
CREATE TABLE `t_medicament_dispose_his` (
  `id` int(11) DEFAULT NULL,
  `mdWarehouseId` int(11) DEFAULT NULL,
  `mdFumigateDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mdBeginDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mdNumber` int(11) NOT NULL DEFAULT '0',
  `mdParticipant` varchar(64) NOT NULL DEFAULT '',
  `mdProcessMode` varchar(128) NOT NULL DEFAULT '',
  `mdOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mdDataOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `mdhUser` int(11) DEFAULT NULL,
  `mdhSQL` text NOT NULL,
  `mdhType` varchar(32) NOT NULL DEFAULT '',
  `mdhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_repository
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_repository`;
CREATE TABLE `t_medicament_repository` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mrName` varchar(128) NOT NULL DEFAULT '',
  `mrBrand` varchar(128) NOT NULL DEFAULT '',
  `mrPage` int(11) NOT NULL,
  `mrStandard` varchar(64) NOT NULL DEFAULT '',
  `mrPrice` float NOT NULL DEFAULT '0',
  `mrNumber` int(11) NOT NULL DEFAULT '0',
  `mrUnit` varchar(128) NOT NULL DEFAULT '',
  `mrManufactureDate` timestamp NULL DEFAULT NULL,
  `mrProductCompany` varchar(128) NOT NULL DEFAULT '',
  `mrOperator` varchar(64) NOT NULL DEFAULT '',
  `mrAuditor` varchar(64) NOT NULL DEFAULT '',
  `mrRemark` varchar(256) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL DEFAULT '1',
  `mrDataOperator` int(11) DEFAULT NULL,
  `mrDrug` int(11) DEFAULT NULL,
  `addDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_repository_his
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_repository_his`;
CREATE TABLE `t_medicament_repository_his` (
  `id` int(11) DEFAULT NULL,
  `mrName` varchar(128) NOT NULL DEFAULT '',
  `mrBrand` varchar(128) NOT NULL DEFAULT '',
  `mrPage` int(11) NOT NULL,
  `mrStandard` varchar(64) NOT NULL DEFAULT '',
  `mrPrice` float NOT NULL DEFAULT '0',
  `mrNumber` int(11) NOT NULL DEFAULT '0',
  `mrUnit` varchar(128) NOT NULL DEFAULT '',
  `mrManufactureDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mrProductCompany` varchar(128) NOT NULL,
  `mrOperator` varchar(64) NOT NULL DEFAULT '',
  `mrAuditor` varchar(64) NOT NULL DEFAULT '',
  `mrRemark` varchar(256) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL DEFAULT '1',
  `mrDataOperator` int(11) DEFAULT NULL,
  `mrhUser` int(11) DEFAULT NULL,
  `mrhSQL` text NOT NULL,
  `mrhType` varchar(32) NOT NULL DEFAULT '',
  `mrhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mrDrug` int(11) DEFAULT NULL,
  `addDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_used
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_used`;
CREATE TABLE `t_medicament_used` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mrId` int(11) DEFAULT NULL,
  `muName` varchar(128) NOT NULL DEFAULT '',
  `muBrand` varchar(128) NOT NULL DEFAULT '',
  `muPage` int(11) NOT NULL,
  `muStandard` varchar(64) NOT NULL DEFAULT '',
  `muPrice` float NOT NULL DEFAULT '0',
  `muNumber` int(11) NOT NULL DEFAULT '0',
  `muUnit` varchar(128) NOT NULL DEFAULT '',
  `muUsedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `muManufactureDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `muProductCompany` varchar(128) NOT NULL DEFAULT '',
  `muQuantity` int(11) NOT NULL DEFAULT '0',
  `muApplicant` varchar(64) NOT NULL DEFAULT '',
  `muAuditor` varchar(64) NOT NULL DEFAULT '',
  `muSupervisor` varchar(64) NOT NULL DEFAULT '',
  `muUsed` varchar(256) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL DEFAULT '1',
  `muDataOperator` int(11) DEFAULT NULL,
  `muDrug` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_medicament_used_his
-- ----------------------------
DROP TABLE IF EXISTS `t_medicament_used_his`;
CREATE TABLE `t_medicament_used_his` (
  `id` int(11) DEFAULT NULL,
  `mrid` int(11) DEFAULT NULL,
  `muName` varchar(128) NOT NULL DEFAULT '',
  `muBrand` varchar(128) NOT NULL DEFAULT '',
  `muPage` int(11) NOT NULL,
  `muStandard` varchar(64) NOT NULL DEFAULT '',
  `muPrice` float NOT NULL DEFAULT '0',
  `muNumber` int(11) NOT NULL DEFAULT '0',
  `muUnit` varchar(128) NOT NULL DEFAULT '',
  `muUsedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `muManufactureDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `muProductCompany` varchar(128) NOT NULL,
  `muQuantity` int(11) NOT NULL DEFAULT '0',
  `muApplicant` varchar(64) NOT NULL DEFAULT '',
  `muAuditor` varchar(64) NOT NULL DEFAULT '',
  `muSupervisor` varchar(64) NOT NULL DEFAULT '',
  `muUsed` varchar(256) NOT NULL DEFAULT '',
  `version` int(11) NOT NULL DEFAULT '1',
  `muDataOperator` int(11) DEFAULT NULL,
  `muhUser` int(11) DEFAULT NULL,
  `muhSQL` text NOT NULL,
  `muhType` varchar(32) NOT NULL DEFAULT '',
  `muhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `muDrug` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_outstorage_register
-- ----------------------------
DROP TABLE IF EXISTS `t_outstorage_register`;
CREATE TABLE `t_outstorage_register` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(50) DEFAULT NULL,
  `roomName` varchar(255) DEFAULT NULL,
  `positionName` varchar(255) DEFAULT NULL,
  `outDate` datetime DEFAULT NULL,
  `amounts` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_person_archives
-- ----------------------------
DROP TABLE IF EXISTS `t_person_archives`;
CREATE TABLE `t_person_archives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paName` varchar(32) NOT NULL DEFAULT '',
  `paSex` char(2) NOT NULL DEFAULT '男',
  `paTelephone` varchar(16) NOT NULL DEFAULT '',
  `paEmail` varchar(64) NOT NULL DEFAULT '',
  `paOfficePhone` varchar(16) NOT NULL DEFAULT '',
  `paNation` varchar(32) NOT NULL DEFAULT '',
  `paQQ` varchar(12) NOT NULL DEFAULT '',
  `paBirthday` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `paDegree` varchar(32) NOT NULL DEFAULT '',
  `paHealth` varchar(32) NOT NULL,
  `paWorkLicence` varchar(32) NOT NULL,
  `paDepartment` varchar(32) NOT NULL DEFAULT '',
  `paDuty` varchar(32) NOT NULL DEFAULT '',
  `paDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `paHealth` (`paHealth`),
  UNIQUE KEY `paWorkLicence` (`paWorkLicence`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_person_archives_his
-- ----------------------------
DROP TABLE IF EXISTS `t_person_archives_his`;
CREATE TABLE `t_person_archives_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paName` varchar(32) NOT NULL DEFAULT '',
  `paSex` char(2) NOT NULL DEFAULT '男',
  `paTelephone` varchar(16) NOT NULL DEFAULT '',
  `paEmail` varchar(64) NOT NULL DEFAULT '',
  `paOfficePhone` varchar(16) NOT NULL DEFAULT '',
  `paNation` varchar(32) NOT NULL DEFAULT '',
  `paQQ` varchar(12) NOT NULL DEFAULT '',
  `paBirthday` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `paDegree` varchar(32) NOT NULL DEFAULT '',
  `paHealth` varchar(32) NOT NULL,
  `paWorkLicence` varchar(32) NOT NULL,
  `paDepartment` varchar(32) NOT NULL DEFAULT '',
  `paDuty` varchar(32) NOT NULL DEFAULT '',
  `paDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `pahUser` int(11) DEFAULT NULL,
  `pahSQL` text NOT NULL,
  `pahType` varchar(32) NOT NULL DEFAULT '',
  `pahOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_policy_query
-- ----------------------------
DROP TABLE IF EXISTS `t_policy_query`;
CREATE TABLE `t_policy_query` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pqType` int(11) DEFAULT NULL COMMENT '文章类型',
  `pqTitle` varchar(128) NOT NULL DEFAULT '' COMMENT '文章标题',
  `pqContent` text COMMENT '文章内容',
  `pqAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加日期',
  `pqLevel` int(11) NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `pqDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='政策查询';

-- ----------------------------
-- Table structure for t_policy_query_his
-- ----------------------------
DROP TABLE IF EXISTS `t_policy_query_his`;
CREATE TABLE `t_policy_query_his` (
  `id` int(11) NOT NULL,
  `pqType` int(11) DEFAULT NULL COMMENT '文章类型',
  `pqTitle` varchar(128) NOT NULL DEFAULT '' COMMENT '文章标题',
  `pqContent` text COMMENT '文章内容',
  `pqAddDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加日期',
  `pqLevel` int(11) NOT NULL DEFAULT '0' COMMENT '显示顺序',
  `pqDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `pqhUser` int(11) DEFAULT NULL COMMENT '操作者',
  `pqhSQL` varchar(512) NOT NULL DEFAULT '' COMMENT '操作语句',
  `pqhType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `pqhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='政策查询操作历史';

-- ----------------------------
-- Table structure for t_print_templet
-- ----------------------------
DROP TABLE IF EXISTS `t_print_templet`;
CREATE TABLE `t_print_templet` (
  `id` int(10) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `value` varchar(20000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_putin_storage_loss
-- ----------------------------
DROP TABLE IF EXISTS `t_putin_storage_loss`;
CREATE TABLE `t_putin_storage_loss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pslWId` int(11) NOT NULL COMMENT '仓号',
  `pslCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `pslPutInDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '进仓时间',
  `pslPutInFluid` float NOT NULL DEFAULT '0' COMMENT '进仓水分',
  `pslPutInImpurity` float NOT NULL DEFAULT '0' COMMENT '进仓杂质',
  `pslPutInWeight` float NOT NULL DEFAULT '0' COMMENT '进仓数量',
  `pslCleanUpFluid` float NOT NULL DEFAULT '0' COMMENT '整理后水分',
  `pslCleanUpImpurity` float NOT NULL DEFAULT '0' COMMENT '整理后杂质',
  `pslCleanUpWeight` float NOT NULL DEFAULT '0' COMMENT '整理后数量',
  `pslFluidReduce` float NOT NULL DEFAULT '0' COMMENT '水分减量',
  `pslImpurityReduce` float NOT NULL DEFAULT '0' COMMENT '去杂减量',
  `pslTotalReduce` float NOT NULL DEFAULT '0' COMMENT '总损耗量',
  `pslAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `pslDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_putin_storage_loss_his
-- ----------------------------
DROP TABLE IF EXISTS `t_putin_storage_loss_his`;
CREATE TABLE `t_putin_storage_loss_his` (
  `id` int(11) DEFAULT NULL,
  `pslWId` int(11) NOT NULL COMMENT '仓号',
  `pslCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `pslPutInDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '进仓时间',
  `pslPutInFluid` float NOT NULL DEFAULT '0' COMMENT '进仓水分',
  `pslPutInImpurity` float NOT NULL DEFAULT '0' COMMENT '进仓杂质',
  `pslPutInWeight` float NOT NULL DEFAULT '0' COMMENT '进仓数量',
  `pslCleanUpFluid` float NOT NULL DEFAULT '0' COMMENT '整理后水分',
  `pslCleanUpImpurity` float NOT NULL DEFAULT '0' COMMENT '整理后杂质',
  `pslCleanUpWeight` float NOT NULL DEFAULT '0' COMMENT '整理后数量',
  `pslFluidReduce` float NOT NULL DEFAULT '0' COMMENT '水分减量',
  `pslImpurityReduce` float NOT NULL DEFAULT '0' COMMENT '去杂减量',
  `pslTotalReduce` float NOT NULL DEFAULT '0' COMMENT '总损耗量',
  `pslAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `pslDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `pslhUser` int(11) DEFAULT NULL COMMENT '操作者',
  `pslhSQL` text NOT NULL COMMENT '操作语句',
  `pslhType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `pslhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_putin_storage_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_putin_storage_plan`;
CREATE TABLE `t_putin_storage_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pspFileName` varchar(64) NOT NULL DEFAULT '' COMMENT '文件名称',
  `pspWId` int(11) NOT NULL COMMENT '仓号',
  `pspVariety` varchar(32) NOT NULL COMMENT '粮食性质',
  `pspCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `pspWeight` float NOT NULL COMMENT '数量(公斤)',
  `pspBeginDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
  `pspEndDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `pspContent` varchar(512) NOT NULL DEFAULT '' COMMENT '内容',
  `pspAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `pspDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_putin_storage_plan_his
-- ----------------------------
DROP TABLE IF EXISTS `t_putin_storage_plan_his`;
CREATE TABLE `t_putin_storage_plan_his` (
  `id` int(11) DEFAULT NULL,
  `pspFileName` varchar(64) NOT NULL DEFAULT '' COMMENT '文件名称',
  `pspWId` int(11) NOT NULL COMMENT '仓号',
  `pspVariety` varchar(32) NOT NULL COMMENT '粮食性质',
  `pspCategory` varchar(32) NOT NULL COMMENT '粮食品种',
  `pspWeight` float NOT NULL COMMENT '数量(公斤)',
  `pspBeginDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '开始时间',
  `pspEndDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `pspContent` varchar(512) NOT NULL DEFAULT '' COMMENT '内容',
  `pspAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `pspDataOperator` int(11) DEFAULT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `psphUser` int(11) DEFAULT NULL COMMENT '操作者',
  `psphSQL` text NOT NULL COMMENT '操作语句',
  `psphType` varchar(32) NOT NULL DEFAULT '' COMMENT '操作类型：增加，修改，删除',
  `psphOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_qualitative
-- ----------------------------
DROP TABLE IF EXISTS `t_qualitative`;
CREATE TABLE `t_qualitative` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `qChangeTime` varchar(20) DEFAULT NULL COMMENT '转换时间',
  `qOldQualitative` int(10) DEFAULT NULL COMMENT '原性质',
  `qNewQualitative` int(10) DEFAULT NULL COMMENT '转换后性质',
  `qComment` varchar(200) DEFAULT NULL COMMENT '备注',
  `warehouse_id` int(10) DEFAULT NULL COMMENT '仓库',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='定性管理表';

-- ----------------------------
-- Table structure for t_qualitychain_buymsg
-- ----------------------------
DROP TABLE IF EXISTS `t_qualitychain_buymsg`;
CREATE TABLE `t_qualitychain_buymsg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(255) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `carid` varchar(255) DEFAULT NULL,
  `weights` varchar(255) DEFAULT NULL,
  `price` varchar(10) DEFAULT NULL,
  `dates` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_qualitychain_instance_quality
-- ----------------------------
DROP TABLE IF EXISTS `t_qualitychain_instance_quality`;
CREATE TABLE `t_qualitychain_instance_quality` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(255) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `dates` datetime DEFAULT NULL,
  `amounts` varchar(255) DEFAULT NULL,
  `bornDate` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `qualityid` varchar(255) DEFAULT NULL COMMENT '1对1关联w_quality',
  `inorout` int(255) DEFAULT '0' COMMENT '0粮油入库统舱记录,  1粮油出库出库统仓记录 2库存质量检测记录 3零星样品检验记录',
  `department` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL COMMENT '样品来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_qualitychain_sell_msg
-- ----------------------------
DROP TABLE IF EXISTS `t_qualitychain_sell_msg`;
CREATE TABLE `t_qualitychain_sell_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(255) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `property` varchar(255) DEFAULT NULL,
  `weights` varchar(20) DEFAULT NULL,
  `price` varchar(20) DEFAULT NULL,
  `dates` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_qualitychain_storemsg
-- ----------------------------
DROP TABLE IF EXISTS `t_qualitychain_storemsg`;
CREATE TABLE `t_qualitychain_storemsg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `stime` datetime DEFAULT NULL,
  `etime` datetime DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_remind
-- ----------------------------
DROP TABLE IF EXISTS `t_remind`;
CREATE TABLE `t_remind` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `objectId` int(10) DEFAULT NULL,
  `objectType` varchar(50) DEFAULT NULL,
  `userId` int(10) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isReaded` int(1) DEFAULT '0' COMMENT '是否已读 默认0 未读     ；  1已读',
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_resources
-- ----------------------------
DROP TABLE IF EXISTS `t_resources`;
CREATE TABLE `t_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `resKey` varchar(50) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `resUrl` varchar(200) DEFAULT NULL,
  `level` int(4) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `ishide` int(3) DEFAULT '0',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for t_res_user
-- ----------------------------
DROP TABLE IF EXISTS `t_res_user`;
CREATE TABLE `t_res_user` (
  `resId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`resId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `state` varchar(3) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `roleKey` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

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
-- Table structure for t_shipindianwei
-- ----------------------------
DROP TABLE IF EXISTS `t_shipindianwei`;
CREATE TABLE `t_shipindianwei` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sLeft` varchar(20) DEFAULT NULL,
  `top` varchar(20) DEFAULT NULL,
  `location_id` int(10) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `ipNum` int(10) DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `port` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_storage_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_detail`;
CREATE TABLE `t_storage_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sdLevel` varchar(10) DEFAULT NULL,
  `sdMoisture` float DEFAULT NULL,
  `sdImpurity` float DEFAULT NULL,
  `sdUnitweight` float DEFAULT NULL,
  `sdUnsoundgrain` float DEFAULT NULL,
  `sdYellowrice` float DEFAULT NULL,
  `sdHeadricerate` float DEFAULT NULL,
  `sdBrownricerate` float DEFAULT NULL,
  `sdHuskedriceinpeddy` float DEFAULT NULL,
  `version` int(11) DEFAULT '0',
  `storage_id` int(10) DEFAULT NULL COMMENT '对应t_storag_info',
  `sdYear` varchar(10) DEFAULT NULL COMMENT '收货年度',
  `sdPack` varchar(10) DEFAULT NULL COMMENT '包装方式',
  `sdPrice` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='仓库质检信息  一个仓库对应一条记录';

-- ----------------------------
-- Table structure for t_storage_record_aircold
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_record_aircold`;
CREATE TABLE `t_storage_record_aircold` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(50) DEFAULT NULL,
  `houseid` varchar(50) DEFAULT NULL,
  `breed` varchar(50) DEFAULT NULL,
  `devicetype` int(50) DEFAULT NULL COMMENT '空调型号',
  `amount` varchar(50) DEFAULT NULL COMMENT '数量',
  `deviceAmount` varchar(50) DEFAULT NULL COMMENT '空调数量',
  `thick` varchar(50) DEFAULT NULL COMMENT '粮层厚度',
  `height` varchar(50) DEFAULT NULL COMMENT '粮层高度',
  `devicePower` varchar(50) DEFAULT NULL COMMENT '单个空调的功率',
  `totlePower` varchar(50) DEFAULT NULL COMMENT '空调总功率',
  `times` varchar(50) DEFAULT NULL COMMENT '开始时间',
  `timee` varchar(50) DEFAULT NULL COMMENT '结束时间',
  `timeTotal` varchar(50) DEFAULT NULL COMMENT '累计降温时间',
  `temperatureMax` varchar(50) DEFAULT NULL COMMENT '大气温度',
  `temperatureMin` varchar(50) DEFAULT NULL COMMENT '大气温度',
  `temperatureAvg` varchar(50) DEFAULT NULL COMMENT '大气温度',
  `wetMax` varchar(50) DEFAULT NULL COMMENT '湿度',
  `wetMin` varchar(50) DEFAULT NULL COMMENT '湿度',
  `wetAvg` varchar(50) DEFAULT NULL COMMENT '湿度',
  `ftemperatureMax_b` varchar(50) DEFAULT NULL COMMENT '通风前粮温',
  `ftemperatureMin_b` varchar(50) DEFAULT NULL COMMENT '通风前粮温',
  `ftemperatureAvg_b` varchar(50) DEFAULT NULL COMMENT '通风前粮温',
  `ftemperature_ladderMax_b` varchar(50) DEFAULT NULL COMMENT '通风前最大梯度',
  `ftemperatureMax_a` varchar(50) DEFAULT NULL COMMENT '通风后粮温',
  `ftemperatureMin_a` varchar(50) DEFAULT NULL COMMENT '通风后粮温',
  `ftemperatureAvg_a` varchar(50) DEFAULT NULL COMMENT '通风后粮温',
  `ftemperature_ladderMax_a` varchar(50) DEFAULT NULL COMMENT '通风后最大梯度',
  `elecAmount` varchar(50) DEFAULT NULL COMMENT '总耗电量',
  `elecAmountPerHour` varchar(50) DEFAULT NULL COMMENT '单位能耗',
  `comment` varchar(50) DEFAULT NULL,
  `charge` varchar(50) DEFAULT NULL COMMENT '负责人',
  `operator` varchar(50) DEFAULT NULL COMMENT '操作人',
  `timecreate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='\r\n\r\n业务管理-存储管理-作业管理-作业记录-空调冷却记录';

-- ----------------------------
-- Table structure for t_storage_record_cold
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_record_cold`;
CREATE TABLE `t_storage_record_cold` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(11) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL COMMENT '等级',
  `water` varchar(255) DEFAULT NULL COMMENT '水分',
  `zazhi` varchar(255) DEFAULT NULL COMMENT '杂志',
  `amount` varchar(255) DEFAULT NULL COMMENT '数量 单位吨',
  `houseType` varchar(255) DEFAULT NULL COMMENT '仓型',
  `length` varchar(50) DEFAULT NULL COMMENT '跨度',
  `thick` varchar(255) DEFAULT NULL COMMENT '厚度',
  `volume` varchar(255) DEFAULT NULL COMMENT '体积',
  `type` varchar(255) DEFAULT NULL COMMENT '风网类型',
  `strength` varchar(255) DEFAULT NULL COMMENT '风网总阻力',
  `windAmount` varchar(255) DEFAULT NULL COMMENT '总风量',
  `mType` varchar(255) DEFAULT NULL COMMENT '冷却机型号',
  `mAmount` varchar(255) DEFAULT NULL COMMENT '台数',
  `power` varchar(255) DEFAULT NULL COMMENT '总功率',
  `windPerVolume` varchar(255) DEFAULT NULL COMMENT '单位通风量',
  `purpose` varchar(255) DEFAULT NULL COMMENT '通风目的',
  `times` varchar(50) DEFAULT NULL COMMENT '开始时间',
  `timee` varchar(50) DEFAULT NULL COMMENT '结束时间',
  `timeLasts` varchar(50) DEFAULT NULL COMMENT '持续时间',
  `temperature_1` varchar(255) DEFAULT NULL COMMENT '大气温度',
  `wet_1` varchar(255) DEFAULT NULL COMMENT '大气湿度',
  `ftemperature_b_1` varchar(255) DEFAULT NULL COMMENT '通风前粮温',
  `ftemperature_a_1` varchar(255) DEFAULT NULL COMMENT '通风后粮温',
  `water_b_1` varchar(255) DEFAULT NULL COMMENT '冷却前水分',
  `water_a_1` varchar(255) DEFAULT NULL COMMENT '冷却后水分',
  `thickness_1` varchar(255) DEFAULT NULL COMMENT '粮温梯度',
  `water_1` varchar(255) DEFAULT NULL COMMENT '水分梯度',
  `temperature_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `wet_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `ftemperature_b_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `ftemperature_a_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `water_b_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `water_a_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `thickness_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `water_2` varchar(255) DEFAULT NULL COMMENT '第二阶段..',
  `temperature_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `wet_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `ftemperature_b_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `ftemperature_a_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `water_b_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `water_a_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `thickness_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `water_3` varchar(255) DEFAULT NULL COMMENT '第3阶段..',
  `windTemperature` varchar(255) DEFAULT NULL COMMENT '冷却送风温度（设定值/检测值）',
  `wetTemperature` varchar(255) DEFAULT NULL COMMENT '冷却送风湿度（设定值/检测值)',
  `capacity` varchar(255) DEFAULT NULL COMMENT '实际冷却处理能力（t/24h)',
  `elecAmount` varchar(255) DEFAULT NULL COMMENT '总电耗（KW.h）',
  `elecAmountPerHour` varchar(255) DEFAULT NULL COMMENT '单位能耗（KW.h/℃.t)',
  `comment` varchar(255) DEFAULT NULL COMMENT '备注',
  `chargeOne` varchar(255) DEFAULT NULL COMMENT '科室负责人：',
  `recordOne` varchar(255) DEFAULT NULL COMMENT '记录人：',
  `timecreate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='存储管理-作业管理-作业记录-冷却记录草\r\n';

-- ----------------------------
-- Table structure for t_storage_record_steam
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_record_steam`;
CREATE TABLE `t_storage_record_steam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(11) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '0常规熏蒸 1环流熏蒸',
  `amount` varchar(255) DEFAULT NULL COMMENT '数量',
  `names` varchar(255) DEFAULT NULL COMMENT '药剂名称',
  `medicineType` varchar(255) DEFAULT NULL COMMENT '药剂类型与纯度',
  `water` varchar(255) DEFAULT NULL COMMENT '水分百分比',
  `methods` varchar(255) DEFAULT NULL COMMENT '用药方法',
  `zazhi` varchar(255) DEFAULT NULL COMMENT '杂志百分百',
  `persons` varchar(255) DEFAULT NULL COMMENT '食药人数',
  `weather` varchar(255) DEFAULT NULL COMMENT '天气',
  `times` varchar(50) DEFAULT NULL COMMENT '开始时间',
  `timee` varchar(50) DEFAULT NULL COMMENT '结束时间',
  `temperature` varchar(255) DEFAULT NULL COMMENT '气温',
  `way` varchar(255) DEFAULT NULL COMMENT '密闭方式',
  `houseTemperature` varchar(255) DEFAULT NULL COMMENT '仓温',
  `days` varchar(255) DEFAULT NULL COMMENT '密闭时间',
  `foodTotle` varchar(255) DEFAULT NULL COMMENT '粮堆合计',
  `spaceTotle` varchar(255) DEFAULT NULL COMMENT '空间合计',
  `sumTotal` varchar(255) DEFAULT NULL COMMENT '体积合计',
  `foodMedicine` varchar(255) DEFAULT NULL COMMENT '粮堆用药量',
  `spaceMedicine` varchar(255) DEFAULT NULL COMMENT '空间用药量',
  `sumMedicine` varchar(255) DEFAULT NULL COMMENT '总用药量',
  `insects_before` varchar(255) DEFAULT NULL COMMENT '熏蒸前主要虫害',
  `insects_amount_before` varchar(255) DEFAULT NULL COMMENT '熏蒸前害虫密度',
  `insects_amount_after` varchar(255) DEFAULT NULL COMMENT '熏蒸后害虫密度',
  `killingPercent` varchar(255) DEFAULT NULL COMMENT '杀虫;率',
  `buildDays` varchar(255) DEFAULT NULL COMMENT '取样培养天数',
  `steamOne` varchar(255) DEFAULT NULL COMMENT '熏蒸人',
  `safetyOne` varchar(255) DEFAULT NULL COMMENT '安全员',
  `recordOne` varchar(255) DEFAULT NULL COMMENT '记录员',
  `comment` varchar(255) DEFAULT NULL,
  `timecreate` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `lastDate` varchar(50) DEFAULT NULL COMMENT '上次熏蒸日期',
  `thickness` varchar(255) DEFAULT NULL COMMENT '设定施药浓度（ml/m3）',
  `tamount` varchar(255) DEFAULT NULL COMMENT '理论施药量（g/m3）',
  `firstAmount` varchar(255) DEFAULT NULL COMMENT '第一次用药总量(Kg)',
  `hours` varchar(255) DEFAULT NULL COMMENT '环流时间（h）',
  `firstfillTime` varchar(50) DEFAULT NULL COMMENT '第一次补药日期',
  `ftemperature_max` varchar(255) DEFAULT NULL COMMENT '粮温',
  `ftemperature_min` varchar(255) DEFAULT NULL COMMENT '粮温',
  `ftemperature_avg` varchar(255) DEFAULT NULL COMMENT '粮温',
  `firstfillAmount` varchar(255) DEFAULT NULL COMMENT '第一次补药量（Kg）',
  `lastfillAmount` varchar(255) DEFAULT NULL COMMENT '最后一次补药量（Kg）',
  `lastfillDate` varchar(50) DEFAULT NULL COMMENT '最后一次补药日期',
  `fillTimes` varchar(50) DEFAULT NULL COMMENT '总补药次数（次）',
  `fillAmounts` varchar(255) DEFAULT NULL COMMENT '总补药量（Kg）',
  `acturalAmounts` varchar(255) DEFAULT NULL COMMENT '实际总用药量（Kg）',
  `openDate` varchar(255) DEFAULT NULL COMMENT '散气日期',
  `openWay` varchar(255) DEFAULT NULL COMMENT '散气方式',
  `openDays` varchar(255) DEFAULT NULL COMMENT '散气时间（天）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='存储管理-作业管理-作业记录-熏蒸记录';

-- ----------------------------
-- Table structure for t_storage_record_wind
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_record_wind`;
CREATE TABLE `t_storage_record_wind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  `houseid` varchar(255) DEFAULT NULL,
  `breed` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL COMMENT '数量单位吨',
  `purpose` varchar(255) DEFAULT NULL COMMENT '通风目的',
  `thick` varchar(255) DEFAULT NULL COMMENT '粮层厚度',
  `devicetype` varchar(255) DEFAULT NULL COMMENT '风机型号',
  `deviceP` varchar(255) DEFAULT NULL COMMENT '单个风机的功率',
  `nettype` varchar(255) DEFAULT NULL COMMENT '风网类型',
  `netPa` varchar(255) DEFAULT NULL COMMENT '风网总阻力',
  `windamount` varchar(255) DEFAULT NULL COMMENT '总风量',
  `deviceamount` varchar(255) DEFAULT NULL COMMENT '风机数量',
  `windtype` varchar(255) DEFAULT NULL COMMENT '送风方式(吸/压)',
  `windperH` varchar(255) DEFAULT NULL COMMENT '单位通风量',
  `times` varchar(50) DEFAULT NULL COMMENT '开始时间',
  `timee` varchar(50) DEFAULT NULL COMMENT '结束时间',
  `timeTotal` varchar(50) DEFAULT NULL COMMENT '累计通风时间',
  `temperatureMax` varchar(255) DEFAULT NULL COMMENT '大气温度',
  `temperatureMin` varchar(255) DEFAULT NULL COMMENT '大气温度',
  `temperatureAvg` varchar(255) DEFAULT NULL COMMENT '大气温度',
  `wetMax` varchar(255) DEFAULT NULL COMMENT '湿度',
  `wetMin` varchar(255) DEFAULT NULL COMMENT '湿度',
  `wetAvg` varchar(255) DEFAULT NULL COMMENT '湿度',
  `ftemperatureMax_b` varchar(255) DEFAULT NULL COMMENT '通风前粮温',
  `ftemperatureMin_b` varchar(255) DEFAULT NULL COMMENT '通风前粮温',
  `ftemperatureAvg_b` varchar(255) DEFAULT NULL COMMENT '通风前粮温',
  `ftemperature_ladderMax_b` varchar(255) DEFAULT NULL COMMENT '通风前最大梯度',
  `waterMax_b` varchar(255) DEFAULT NULL COMMENT '通风前水分',
  `waterMin_b` varchar(255) DEFAULT NULL COMMENT '通风前水分',
  `waterAvg_b` varchar(255) DEFAULT NULL COMMENT '通风前水分',
  `water_ladderMax_b` varchar(255) DEFAULT NULL COMMENT '通风前水分最大梯度',
  `ftemperatureMax_a` varchar(255) DEFAULT NULL COMMENT '通风后粮温',
  `ftemperatureMin_a` varchar(255) DEFAULT NULL COMMENT '通风后粮温',
  `ftemperatureAvg_a` varchar(255) DEFAULT NULL COMMENT '通风后粮温',
  `ftemperature_ladderMax_a` varchar(255) DEFAULT NULL COMMENT '通风后最大梯度',
  `waterMax_a` varchar(255) DEFAULT NULL COMMENT '通风后水分',
  `waterMin_a` varchar(255) DEFAULT NULL COMMENT '通风后水分',
  `waterAvg_a` varchar(255) DEFAULT NULL COMMENT '通风后水分',
  `water_ladderMax_a` varchar(255) DEFAULT NULL COMMENT '通风后水分最大梯度',
  `elecAmount` varchar(255) DEFAULT NULL COMMENT '总耗电量',
  `elecAmountPerHour` varchar(255) DEFAULT NULL COMMENT '单位能耗',
  `comment` varchar(255) DEFAULT NULL,
  `charge` varchar(255) DEFAULT NULL COMMENT '负责人',
  `operator` varchar(255) DEFAULT NULL COMMENT '操作人',
  `timecreate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='\r\n\r\n业务管理-存储管理-作业管理-作业记录-通风记录';

-- ----------------------------
-- Table structure for t_storage_steam_present
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_steam_present`;
CREATE TABLE `t_storage_steam_present` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charge` varchar(255) DEFAULT NULL COMMENT '负责人',
  `cconcator` varchar(255) DEFAULT NULL COMMENT '联系电话(负责人)',
  `east` varchar(255) DEFAULT NULL COMMENT '警戒距离-东(米)',
  `south` varchar(255) DEFAULT NULL COMMENT '警戒距离-南(米)',
  `west` varchar(255) DEFAULT NULL COMMENT '警戒距离-西(米)',
  `north` varchar(255) DEFAULT NULL COMMENT '警戒距离-北(米)：',
  `filler` varchar(255) DEFAULT NULL COMMENT '填表人',
  `fconcator` varchar(255) DEFAULT NULL COMMENT '联系电话(填表人)',
  `email` varchar(255) DEFAULT NULL COMMENT '电子信箱(填表人)',
  `mName` varchar(255) DEFAULT NULL COMMENT '药剂名称',
  `mType` varchar(255) DEFAULT NULL COMMENT '类型/型号',
  `mDate` varchar(50) DEFAULT NULL COMMENT '有效期至',
  `mPlace` varchar(255) DEFAULT NULL COMMENT '暂存地点',
  `mAmount` varchar(255) DEFAULT NULL COMMENT '领取数量',
  `mPerson` varchar(255) DEFAULT NULL COMMENT '领取人',
  `mTime` varchar(255) DEFAULT NULL COMMENT '领取时间',
  `mUseAmount` varchar(255) DEFAULT NULL COMMENT '施药量(kg)',
  `mWay` varchar(255) DEFAULT NULL COMMENT '施药设备及方式',
  `mComment` varchar(255) DEFAULT NULL COMMENT '药剂残渣  ',
  `peopleMsg` text COMMENT '熏蒸人员信息',
  `targetMsg` text COMMENT '熏蒸对象信息',
  `timeCreate` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `status` varchar(255) NOT NULL DEFAULT '0' COMMENT '备案状态0 未上传  ,1 已上传',
  `files` varchar(255) DEFAULT NULL COMMENT '关联t_commons_file sid',
  PRIMARY KEY (`id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_storage_weighting
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_weighting`;
CREATE TABLE `t_storage_weighting` (
  `ID` varchar(64) NOT NULL COMMENT '流水单号',
  `CarID` varchar(45) DEFAULT NULL COMMENT '车编号',
  `TotalWeight` varchar(45) DEFAULT NULL COMMENT '毛重',
  `CarWeight` varchar(45) DEFAULT NULL COMMENT '皮重',
  `TotalWeightingTime` varchar(45) DEFAULT NULL COMMENT '称毛重时间',
  `CarWeightingTime` varchar(45) DEFAULT NULL COMMENT '称皮重时间',
  `Flag` varchar(45) NOT NULL DEFAULT '1',
  `lastweight` varchar(45) NOT NULL DEFAULT '0' COMMENT '1表示最后一次称重',
  `Sid` varchar(64) DEFAULT NULL,
  `SBY` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='称重表';

-- ----------------------------
-- Table structure for t_storage_work_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_work_plan`;
CREATE TABLE `t_storage_work_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `times` varchar(255) DEFAULT NULL,
  `timee` varchar(255) DEFAULT NULL,
  `projectid` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `ctime` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_storage_work_project
-- ----------------------------
DROP TABLE IF EXISTS `t_storage_work_project`;
CREATE TABLE `t_storage_work_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL COMMENT '0:通风,1熏蒸 2冷却',
  `location` varchar(255) DEFAULT NULL COMMENT '库点位置',
  `houseid` varchar(255) DEFAULT NULL COMMENT '仓号',
  `breed` varchar(255) DEFAULT NULL COMMENT '粮食种类',
  `amount` varchar(255) DEFAULT NULL COMMENT '单位公斤',
  `temperature` varchar(255) DEFAULT NULL COMMENT '粮温',
  `houseTemperature` varchar(255) DEFAULT NULL COMMENT '仓内温度',
  `chonghai` varchar(255) DEFAULT NULL COMMENT '主要虫害',
  `perWeight` double DEFAULT NULL COMMENT '每公斤(头)',
  `length` double DEFAULT NULL COMMENT '长',
  `width` double DEFAULT NULL COMMENT '宽',
  `height` double DEFAULT NULL COMMENT '高',
  `lineHeight` double DEFAULT NULL COMMENT '堆粮线的高',
  `waterPer` varchar(255) DEFAULT NULL COMMENT '水分',
  `acturalHeight` double DEFAULT NULL COMMENT '实力存粮高度',
  `upperTemperature` varchar(255) DEFAULT NULL COMMENT '上层的温度',
  `footTemperature` varchar(255) DEFAULT NULL COMMENT '底层的温度',
  `wet` varchar(255) DEFAULT NULL COMMENT '大气湿度%',
  `innerWet` varchar(255) DEFAULT NULL COMMENT '舱内湿度(%)',
  `qiwen` varchar(255) DEFAULT NULL COMMENT '单位摄氏度',
  `windForm` varchar(255) DEFAULT NULL COMMENT '通风形式',
  `steamForm` varchar(255) DEFAULT NULL COMMENT '熏蒸形式',
  `coldForm` varchar(255) DEFAULT NULL COMMENT '冷却形式',
  `purpose` varchar(255) DEFAULT NULL COMMENT '通风目的',
  `times` varchar(20) DEFAULT NULL COMMENT '时间开始',
  `timee` varchar(20) DEFAULT NULL COMMENT '时间结束',
  `content` varchar(255) DEFAULT NULL COMMENT '方案内容',
  `status` varchar(255) DEFAULT '3' COMMENT '0 审批中 ,1 通过,2退回,3未提交',
  `ctime` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `reason` varchar(255) DEFAULT NULL COMMENT '退回原因(非必须)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_storag_info
-- ----------------------------
DROP TABLE IF EXISTS `t_storag_info`;
CREATE TABLE `t_storag_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '粮食品种',
  `code` varchar(32) DEFAULT NULL,
  `quanZhong` varchar(32) DEFAULT NULL COMMENT '粮权',
  `cangKu` varchar(64) DEFAULT NULL COMMENT '仓库货存量',
  `storageID` varchar(16) DEFAULT NULL COMMENT '仓库号',
  `source` varchar(32) DEFAULT NULL COMMENT '信息来源 1:刘桥',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_store_info
-- ----------------------------
DROP TABLE IF EXISTS `t_store_info`;
CREATE TABLE `t_store_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `location_id` int(10) DEFAULT NULL COMMENT '库点',
  `warehouse_id` int(10) DEFAULT NULL COMMENT '仓库',
  `siType` varchar(30) DEFAULT NULL COMMENT '仓型',
  `siDesignCapacity` float DEFAULT NULL COMMENT '设计仓容',
  `person_id` int(10) DEFAULT NULL COMMENT '保管员',
  `siNature` varchar(10) DEFAULT NULL COMMENT '储量性质',
  `siCategory` varchar(10) DEFAULT NULL COMMENT '粮食类别',
  `siVariety` varchar(10) DEFAULT NULL COMMENT '品种',
  `siPack` varchar(10) DEFAULT NULL,
  `siOrigin` varchar(255) DEFAULT NULL COMMENT '原产地',
  `siYear` varchar(10) DEFAULT NULL COMMENT '收获年份',
  `siPutin` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `siQuantity` float DEFAULT NULL COMMENT '存量数量（公斤）',
  `siLevel` varchar(10) DEFAULT NULL COMMENT '等级',
  `siMoisture` float DEFAULT NULL COMMENT '水份（%）',
  `siImpurity` float DEFAULT NULL COMMENT '杂质',
  `siUnitweight` float DEFAULT NULL COMMENT '容重(g/l)',
  `siUnsoundgrain` float DEFAULT NULL COMMENT '不完善粒(%）',
  `siYellowrice` float DEFAULT NULL COMMENT '黄粒',
  `siHeadricerate` float DEFAULT NULL COMMENT '整精米率（%）',
  `siBrownricerate` float DEFAULT NULL COMMENT '出糙(%）',
  `siHuskedriceinpeddy` float DEFAULT NULL COMMENT '谷外糙米',
  `siUpdatetime` datetime DEFAULT '2014-12-01 00:00:00',
  `siPrice` float DEFAULT NULL COMMENT '单价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='初始库存记录';

-- ----------------------------
-- Table structure for t_store_info_timestamp
-- ----------------------------
DROP TABLE IF EXISTS `t_store_info_timestamp`;
CREATE TABLE `t_store_info_timestamp` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `store_id` int(10) DEFAULT NULL,
  `sit_lasttime` datetime NOT NULL COMMENT '最后一条记录的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_temp_hzbb
-- ----------------------------
DROP TABLE IF EXISTS `t_temp_hzbb`;
CREATE TABLE `t_temp_hzbb` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `zdbh` int(10) DEFAULT NULL,
  `bh` int(10) DEFAULT NULL,
  `ch` varchar(10) DEFAULT NULL,
  `cjsj` datetime DEFAULT NULL,
  `cw` float DEFAULT NULL,
  `cs` float DEFAULT NULL,
  `qw` float DEFAULT NULL,
  `qs` float DEFAULT NULL,
  `zcpj` float DEFAULT NULL,
  `zczg` float DEFAULT NULL,
  `zczd` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_temp_wdcjz
-- ----------------------------
DROP TABLE IF EXISTS `t_temp_wdcjz`;
CREATE TABLE `t_temp_wdcjz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zdbh` int(11) DEFAULT NULL,
  `cjsj` datetime DEFAULT NULL,
  `bh` int(5) DEFAULT NULL,
  `ch` varchar(5) DEFAULT NULL,
  `xlh` int(5) DEFAULT NULL,
  `a1` float DEFAULT NULL,
  `a2` float DEFAULT NULL,
  `a3` float DEFAULT NULL,
  `a4` float DEFAULT NULL,
  `a5` float DEFAULT NULL,
  `b1` float DEFAULT NULL,
  `b2` float DEFAULT NULL,
  `b3` float DEFAULT NULL,
  `b4` float DEFAULT NULL,
  `b5` float DEFAULT NULL,
  `c1` float DEFAULT NULL,
  `c2` float DEFAULT NULL,
  `c3` float DEFAULT NULL,
  `c4` float DEFAULT NULL,
  `c5` float DEFAULT NULL,
  `d1` float DEFAULT NULL,
  `d2` float DEFAULT NULL,
  `d3` float DEFAULT NULL,
  `d4` float DEFAULT NULL,
  `d5` float DEFAULT NULL,
  `e1` float DEFAULT NULL,
  `e2` float DEFAULT NULL,
  `e3` float DEFAULT NULL,
  `e4` float DEFAULT NULL,
  `e5` float DEFAULT NULL,
  `f1` float DEFAULT NULL,
  `f2` float DEFAULT NULL,
  `f3` float DEFAULT NULL,
  `f4` float DEFAULT NULL,
  `f5` float DEFAULT NULL,
  `g1` float DEFAULT NULL,
  `g2` float DEFAULT NULL,
  `g3` float DEFAULT NULL,
  `g4` float DEFAULT NULL,
  `g5` float DEFAULT NULL,
  `cnwd` float DEFAULT NULL,
  `cnsd` float DEFAULT NULL,
  `cwwd` float DEFAULT NULL,
  `cwsd` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for t_timestamp
-- ----------------------------
DROP TABLE IF EXISTS `t_timestamp`;
CREATE TABLE `t_timestamp` (
  `tableName` varchar(200) NOT NULL,
  `lasttime` varchar(30) DEFAULT '2016-01-01 00:00:00',
  `location` varchar(30) NOT NULL COMMENT '库点',
  PRIMARY KEY (`tableName`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_archives
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_archives`;
CREATE TABLE `t_warehouse_archives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wId` varchar(16) NOT NULL DEFAULT '',
  `waHeatInsulator` varchar(32) NOT NULL DEFAULT '',
  `waWindow` int(11) NOT NULL DEFAULT '0',
  `waWarehouseType` varchar(32) NOT NULL DEFAULT '',
  `waDoorNumber` int(11) NOT NULL DEFAULT '0',
  `waStructure` varchar(32) NOT NULL DEFAULT '',
  `waAeration` varchar(32) NOT NULL DEFAULT '',
  `waFumigate` varchar(32) NOT NULL DEFAULT '',
  `waConstructDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `waDesignCapacity` float NOT NULL DEFAULT '0',
  `waDesignHeight` float NOT NULL DEFAULT '0',
  `waInnerLong` float NOT NULL DEFAULT '0',
  `waInnerWidth` float NOT NULL DEFAULT '0',
  `waStoreman` int(11) DEFAULT NULL,
  `waSequence` varchar(32) NOT NULL DEFAULT '0.0',
  `waDataOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wId` (`wId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_archives_his
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_archives_his`;
CREATE TABLE `t_warehouse_archives_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wId` int(11) DEFAULT NULL,
  `waHeatInsulator` varchar(32) NOT NULL DEFAULT '',
  `waWindow` int(11) NOT NULL DEFAULT '0',
  `waWarehouseType` varchar(32) NOT NULL DEFAULT '',
  `waDoorNumber` int(11) NOT NULL DEFAULT '0',
  `waStructure` varchar(32) NOT NULL DEFAULT '',
  `waAeration` varchar(32) NOT NULL DEFAULT '',
  `waFumigate` varchar(32) NOT NULL DEFAULT '',
  `waConstructDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `waDesignCapacity` float NOT NULL DEFAULT '0',
  `waDesignHeight` float NOT NULL DEFAULT '0',
  `waInnerLong` float NOT NULL DEFAULT '0',
  `waInnerWidth` float NOT NULL DEFAULT '0',
  `waStoreman` int(11) DEFAULT NULL,
  `waSequence` varchar(32) NOT NULL DEFAULT '0.0',
  `waDataOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT '1',
  `wahUser` int(11) DEFAULT NULL,
  `wahSQL` text NOT NULL,
  `wahType` varchar(32) NOT NULL DEFAULT '',
  `wahOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_grain_transfer
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_grain_transfer`;
CREATE TABLE `t_warehouse_grain_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wgtBill` varchar(64) NOT NULL DEFAULT '' COMMENT '倒仓单号',
  `wgtOriginalId` int(11) NOT NULL COMMENT '原仓号',
  `wgtTargetId` int(11) NOT NULL COMMENT '目标仓号',
  `wgtOriginalVariety` varchar(32) NOT NULL DEFAULT '' COMMENT '原仓内品种',
  `wgtTargetVariety` varchar(32) NOT NULL DEFAULT '' COMMENT '目标仓内品种',
  `wgtCause` varchar(32) NOT NULL DEFAULT '' COMMENT '倒仓原因',
  `wgtNumber` float NOT NULL DEFAULT '0' COMMENT '倒仓数量',
  `wgtOriginalCategory` varchar(32) NOT NULL DEFAULT '' COMMENT '原仓性质',
  `wgtTargetCategory` varchar(32) NOT NULL DEFAULT '' COMMENT '目标仓性质',
  `wgtOriginalStoreman` int(11) NOT NULL COMMENT '原仓保管员',
  `wgtTargetStoreman` int(11) NOT NULL COMMENT '目标仓保管员',
  `wgtOriginalStorageRate` float NOT NULL DEFAULT '0' COMMENT '原仓库存量',
  `wgtTargetStorageRate` float NOT NULL DEFAULT '0' COMMENT '目标仓库存量',
  `wgtDataOperator` int(11) NOT NULL COMMENT '数据操作员',
  `wgtTransferDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '倒仓日期',
  `wgtAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加日期',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_info
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_info`;
CREATE TABLE `t_warehouse_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wDate` varchar(16) DEFAULT NULL,
  `wTime` varchar(16) DEFAULT NULL,
  `wTemperature` float DEFAULT NULL,
  `gTemperature` float DEFAULT NULL,
  `wHumidity` float DEFAULT NULL,
  `gHumidity` float DEFAULT NULL,
  `wCoordinate` text,
  `wDisable` char(1) DEFAULT NULL,
  `wWarehouse` int(11) DEFAULT NULL,
  `cjsj` datetime DEFAULT NULL COMMENT '采集时间',
  `maxTemperature` float DEFAULT NULL,
  `minTemperature` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_location_archives
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_location_archives`;
CREATE TABLE `t_warehouse_location_archives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wlaNo` varchar(32) NOT NULL,
  `wlaName` varchar(64) NOT NULL DEFAULT '',
  `wlaGovernor` varchar(32) NOT NULL DEFAULT '',
  `wlaPhoneNumber` varchar(16) NOT NULL DEFAULT '',
  `wlaCapacity` float NOT NULL DEFAULT '0',
  `wlaFloorSpace` varchar(16) NOT NULL DEFAULT '',
  `wlaPersonNumber` int(11) NOT NULL DEFAULT '0',
  `wlaPrivince` varchar(32) NOT NULL DEFAULT '',
  `wlaCity` varchar(32) NOT NULL DEFAULT '',
  `wlaCounty` varchar(32) NOT NULL DEFAULT '',
  `wlaAddress` varchar(256) NOT NULL DEFAULT '',
  `wlaOrganization` varchar(32) NOT NULL DEFAULT '',
  `wlaAdministrativeCode` varchar(16) NOT NULL DEFAULT '',
  `wlaFaxNumber` varchar(16) NOT NULL DEFAULT '',
  `wlaDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wlaNo` (`wlaNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_location_archives_his
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_location_archives_his`;
CREATE TABLE `t_warehouse_location_archives_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wlaNo` varchar(32) NOT NULL,
  `wlaName` varchar(64) NOT NULL DEFAULT '',
  `wlaGovernor` varchar(32) NOT NULL DEFAULT '',
  `wlaPhoneNumber` varchar(16) NOT NULL DEFAULT '',
  `wlaCapacity` float NOT NULL DEFAULT '0',
  `wlaFloorSpace` varchar(16) NOT NULL DEFAULT '',
  `wlaPersonNumber` int(11) NOT NULL DEFAULT '0',
  `wlaPrivince` varchar(32) NOT NULL DEFAULT '',
  `wlaCity` varchar(32) NOT NULL DEFAULT '',
  `wlaCounty` varchar(32) NOT NULL DEFAULT '',
  `wlaAddress` varchar(256) NOT NULL DEFAULT '',
  `wlaOrganization` varchar(32) NOT NULL DEFAULT '',
  `wlaAdministrativeCode` varchar(16) NOT NULL DEFAULT '',
  `wlaFaxNumber` varchar(16) NOT NULL DEFAULT '',
  `wlaDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `wlahUser` int(11) DEFAULT NULL,
  `wlahSQL` text NOT NULL,
  `wlahType` varchar(32) NOT NULL DEFAULT '',
  `wlahOpDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_repair
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_repair`;
CREATE TABLE `t_warehouse_repair` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wId` int(11) NOT NULL,
  `wrDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `wrWarranty` varchar(16) DEFAULT '',
  `wrMaturity` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `wrContent` varchar(256) DEFAULT '',
  `wrSummary` varchar(256) DEFAULT '',
  `wrEffect` varchar(256) DEFAULT '',
  `wrAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `wrOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_repair_his
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_repair_his`;
CREATE TABLE `t_warehouse_repair_his` (
  `id` int(11) DEFAULT NULL,
  `wId` int(11) NOT NULL,
  `wrDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `wrWarranty` varchar(16) DEFAULT '',
  `wrMaturity` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `wrContent` varchar(256) DEFAULT '',
  `wrSummary` varchar(256) DEFAULT '',
  `wrEffect` varchar(256) DEFAULT '',
  `wrAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `wrOperator` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT '1',
  `wrhUser` int(11) DEFAULT NULL,
  `wrhSQL` varchar(512) NOT NULL DEFAULT '',
  `wrhType` varchar(32) NOT NULL DEFAULT '',
  `wrhOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_save_report_list
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_save_report_list`;
CREATE TABLE `t_warehouse_save_report_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `location_no` varchar(10) DEFAULT NULL COMMENT '库点编号',
  `warehouse_id` int(10) DEFAULT NULL COMMENT '仓库主键',
  `wCategory` varchar(10) DEFAULT NULL COMMENT '品种',
  `wInstocktime` varchar(7) DEFAULT NULL COMMENT '入库时间 2017-06',
  `wPacking` varchar(6) DEFAULT NULL COMMENT '包装方式',
  `wQuality` varchar(10) DEFAULT NULL COMMENT '性质',
  `wStock` int(10) DEFAULT NULL COMMENT '库存',
  `wMoisture` varchar(10) DEFAULT NULL COMMENT '水分',
  `wTempH` varchar(10) DEFAULT NULL COMMENT '最高温度',
  `wTempL` varchar(10) DEFAULT NULL COMMENT '最低温度',
  `wGrainInsect` varchar(10) DEFAULT NULL COMMENT '虫情数量',
  `wPestis` varchar(50) DEFAULT NULL COMMENT '主要虫害',
  `wProcessed` varchar(20) DEFAULT NULL COMMENT '已处理',
  `wUndisposed` varchar(20) DEFAULT NULL COMMENT '未处理',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `person_id` int(10) DEFAULT NULL COMMENT '保管员编号',
  `wRemark` varchar(200) DEFAULT NULL COMMENT '备注',
  `wPrice` varchar(10) DEFAULT NULL COMMENT '单价',
  `wSum` varchar(10) DEFAULT NULL COMMENT '金额 wStock*wPrice',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_storage_capacity
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_storage_capacity`;
CREATE TABLE `t_warehouse_storage_capacity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wscId` int(11) NOT NULL COMMENT '仓号',
  `wscLimitHeight` float NOT NULL DEFAULT '0' COMMENT '堆粮限高(米)',
  `wscInnerLong` float NOT NULL DEFAULT '0' COMMENT '内墙长(米)',
  `wscInnerWidth` float NOT NULL DEFAULT '0' COMMENT '内墙宽(米)',
  `wscJaponicaRiceDensity` float NOT NULL DEFAULT '0' COMMENT '粳稻堆放密度(kg/m³)',
  `wscWheatDensity` float NOT NULL DEFAULT '0' COMMENT '小麦堆放密度(kg/m³)',
  `wscJaponicaRiceWeight` float NOT NULL DEFAULT '0' COMMENT '粳稻仓容(kg)',
  `wscWheatWeight` float NOT NULL DEFAULT '0' COMMENT '小麦仓容(kg)',
  `wscDataOperator` int(11) NOT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `wscId` (`wscId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_storage_capacity_his
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_storage_capacity_his`;
CREATE TABLE `t_warehouse_storage_capacity_his` (
  `id` int(11) DEFAULT NULL,
  `wscId` int(11) NOT NULL COMMENT '仓号',
  `wscLimitHeight` float NOT NULL DEFAULT '0' COMMENT '堆粮限高(米)',
  `wscInnerLong` float NOT NULL DEFAULT '0' COMMENT '内墙长(米)',
  `wscInnerWidth` float NOT NULL DEFAULT '0' COMMENT '内墙宽(米)',
  `wscJaponicaRiceDensity` float NOT NULL DEFAULT '0' COMMENT '粳稻堆放密度(kg/m³)',
  `wscWheatDensity` float NOT NULL DEFAULT '0' COMMENT '小麦堆放密度(kg/m³)',
  `wscJaponicaRiceWeight` float NOT NULL DEFAULT '0' COMMENT '粳稻仓容(kg)',
  `wscWheatWeight` float NOT NULL DEFAULT '0' COMMENT '小麦仓容(kg)',
  `wscDataOperator` int(11) NOT NULL COMMENT '数据操作员',
  `version` int(11) NOT NULL DEFAULT '1',
  `wschUser` int(11) DEFAULT NULL,
  `wschSQL` text NOT NULL,
  `wschType` varchar(32) NOT NULL DEFAULT '',
  `wschOpDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_transfer
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_transfer`;
CREATE TABLE `t_warehouse_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wtId` int(11) NOT NULL,
  `wtOriginalStoreman` int(11) NOT NULL,
  `wtNowStoreman` int(11) NOT NULL,
  `wtTransferDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `wtAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `wtRemark` varchar(256) NOT NULL DEFAULT '',
  `wtDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_warehouse_transfer_his
-- ----------------------------
DROP TABLE IF EXISTS `t_warehouse_transfer_his`;
CREATE TABLE `t_warehouse_transfer_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wtId` int(11) NOT NULL,
  `wtOriginalStoreman` int(11) NOT NULL,
  `wtNowStoreman` int(11) NOT NULL,
  `wtTransferDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `wtAddDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `wtRemark` varchar(256) NOT NULL DEFAULT '',
  `wtDataOperator` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT '1',
  `wthUser` int(11) DEFAULT NULL,
  `wthSQL` text NOT NULL,
  `wthType` varchar(32) NOT NULL DEFAULT '',
  `wthOpDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_yingpanluxiangji
-- ----------------------------
DROP TABLE IF EXISTS `t_yingpanluxiangji`;
CREATE TABLE `t_yingpanluxiangji` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `yIp` varchar(20) DEFAULT NULL,
  `yPort` varchar(10) DEFAULT NULL,
  `yName` varchar(30) DEFAULT NULL,
  `yPassword` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `location_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_car_relation
-- ----------------------------
DROP TABLE IF EXISTS `w_car_relation`;
CREATE TABLE `w_car_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carid` varchar(32) NOT NULL,
  `instorageid` varchar(45) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_customer
-- ----------------------------
DROP TABLE IF EXISTS `w_customer`;
CREATE TABLE `w_customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `CustomerName` varchar(45) DEFAULT NULL,
  `Identity` varchar(45) DEFAULT NULL COMMENT '身份证',
  `Address` varchar(45) DEFAULT NULL COMMENT '联系地址',
  `Phone` varchar(45) DEFAULT NULL COMMENT '联系电话',
  `Company` varchar(45) DEFAULT NULL COMMENT '单位',
  `customercol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_instorage
-- ----------------------------
DROP TABLE IF EXISTS `w_instorage`;
CREATE TABLE `w_instorage` (
  `basicid` int(11) NOT NULL AUTO_INCREMENT,
  `ID` varchar(64) DEFAULT NULL COMMENT '流水单号',
  `Owner` varchar(45) DEFAULT NULL COMMENT '货主姓名',
  `Identity` varchar(45) DEFAULT NULL COMMENT '身份证号码',
  `Phone` varchar(45) DEFAULT NULL COMMENT '手机号',
  `Address` varchar(45) DEFAULT NULL COMMENT '联系地址',
  `Category` varchar(45) DEFAULT NULL COMMENT '粮食类别',
  `Breed` varchar(45) DEFAULT NULL COMMENT '粮食品种',
  `Property` varchar(45) DEFAULT NULL COMMENT '粮食的性质',
  `CarID` varchar(20) DEFAULT NULL COMMENT '车(船)号',
  `StorageID` varchar(50) DEFAULT NULL COMMENT '入库号',
  `useCar` varchar(4) DEFAULT '0' COMMENT '0:不使用,1使用',
  `State` varchar(5) DEFAULT NULL COMMENT '流水状态 \n1:入库\n2:出库\n3:称重结束\n4:结算',
  `CreateTime` datetime DEFAULT NULL COMMENT '创建时间',
  `PayTime` varchar(45) DEFAULT NULL,
  `inorout` varchar(45) DEFAULT '' COMMENT '1入库 0出库',
  `Payway` varchar(255) DEFAULT '' COMMENT '结算类型 1现金 2转账 3补录',
  `JSY` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `late` varchar(255) DEFAULT '1',
  PRIMARY KEY (`basicid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='入库流水表';

-- ----------------------------
-- Table structure for w_payment
-- ----------------------------
DROP TABLE IF EXISTS `w_payment`;
CREATE TABLE `w_payment` (
  `ID` int(11) NOT NULL COMMENT '流水编号',
  `Sum` varchar(45) DEFAULT NULL COMMENT '结算金额',
  `Type` varchar(45) DEFAULT NULL COMMENT '结算类型',
  `Operator` varchar(45) DEFAULT NULL COMMENT '操作员',
  `Time` varchar(45) DEFAULT NULL COMMENT '结算时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_payway
-- ----------------------------
DROP TABLE IF EXISTS `w_payway`;
CREATE TABLE `w_payway` (
  `basicid` int(255) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) DEFAULT NULL,
  `bankName` varchar(50) DEFAULT NULL,
  `cardID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`basicid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_quailty_basic_01
-- ----------------------------
DROP TABLE IF EXISTS `w_quailty_basic_01`;
CREATE TABLE `w_quailty_basic_01` (
  `Code` varchar(32) NOT NULL DEFAULT '0.00' COMMENT '质量编码',
  `CodeName` varchar(45) DEFAULT '0.00' COMMENT '名称',
  `Standard` varchar(45) DEFAULT '0.00' COMMENT '标准值,标准等级',
  `Min` varchar(45) DEFAULT '0.00' COMMENT '最小区间,最低等级',
  `Max` varchar(45) DEFAULT '0.00' COMMENT '最大区间,最高等级',
  `Step` varchar(45) DEFAULT '0.00' COMMENT '等级差',
  `Reduce` varchar(45) DEFAULT '0.00' COMMENT '扣量标准',
  `Reducing` varchar(45) DEFAULT '0.00' COMMENT '扣量值',
  `Promote` varchar(45) DEFAULT '0.00' COMMENT '增量幅度',
  `Promoting` varchar(45) DEFAULT '0.00' COMMENT '增量值',
  `Abbreviation` varchar(45) DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_quality
-- ----------------------------
DROP TABLE IF EXISTS `w_quality`;
CREATE TABLE `w_quality` (
  `basicid` int(11) NOT NULL AUTO_INCREMENT,
  `ID` varchar(45) NOT NULL COMMENT '流水单号',
  `Bwsld` varchar(45) DEFAULT NULL COMMENT '不完善粒度',
  `CCL` varchar(45) DEFAULT NULL COMMENT '出糙率',
  `Gwcm` varchar(45) DEFAULT NULL COMMENT '谷外糙米',
  `Hl` varchar(45) DEFAULT NULL COMMENT '黄粒',
  `Pcpf` varchar(45) DEFAULT NULL COMMENT '品尝评分',
  `Rl` varchar(45) DEFAULT NULL COMMENT '容量',
  `Szqw` varchar(45) DEFAULT NULL COMMENT '色泽气味',
  `Smj` varchar(45) DEFAULT NULL COMMENT '湿面筋',
  `Sf` varchar(45) DEFAULT NULL COMMENT '水分',
  `Zz` varchar(45) DEFAULT NULL COMMENT '杂质',
  `Zjml` varchar(45) DEFAULT NULL COMMENT '整精米粒',
  `Zfsz` varchar(45) DEFAULT NULL COMMENT '脂肪酸值',
  `Price` varchar(45) DEFAULT NULL COMMENT '单价',
  `AmountPercent` varchar(45) DEFAULT NULL COMMENT '总扣量',
  `Level` varchar(45) DEFAULT NULL COMMENT '等级',
  `Rz` varchar(45) DEFAULT NULL COMMENT '容重',
  `Kwz` varchar(45) DEFAULT NULL COMMENT '矿物质',
  `Hh` varchar(45) DEFAULT NULL COMMENT '互混',
  `ZJY` varchar(45) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL COMMENT '库点',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`basicid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='质检信息表';

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
-- Table structure for w_role
-- ----------------------------
DROP TABLE IF EXISTS `w_role`;
CREATE TABLE `w_role` (
  `roleid` varchar(255) DEFAULT NULL,
  `rolename` varchar(255) DEFAULT NULL,
  `privilege` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_setting
-- ----------------------------
DROP TABLE IF EXISTS `w_setting`;
CREATE TABLE `w_setting` (
  `parameterKey` int(255) NOT NULL AUTO_INCREMENT,
  `parameterValue` varchar(255) DEFAULT NULL COMMENT '配置参数',
  `location` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL COMMENT '地磅标识码',
  PRIMARY KEY (`parameterKey`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_supply
-- ----------------------------
DROP TABLE IF EXISTS `w_supply`;
CREATE TABLE `w_supply` (
  `ID` varchar(32) NOT NULL,
  `CompanyName` varchar(10) DEFAULT NULL COMMENT '客户名称',
  `Address` varchar(45) DEFAULT NULL COMMENT '通讯地址',
  `Contacts` varchar(45) DEFAULT NULL COMMENT '联系人',
  `Phone` varchar(15) DEFAULT NULL COMMENT '联系电话',
  `Info` varchar(45) DEFAULT NULL COMMENT '资讯情况',
  `PurchaseID` varchar(20) DEFAULT NULL COMMENT '收购凭证',
  `ProductionID` varchar(20) DEFAULT NULL COMMENT '生产许可证',
  `HealthID` varchar(20) DEFAULT NULL COMMENT '卫生许可证',
  `Licence` varchar(20) DEFAULT NULL COMMENT '营业执照',
  `RegisterID` varchar(45) DEFAULT NULL COMMENT '注册号',
  `Brand` varchar(45) DEFAULT NULL COMMENT '注册商标',
  `Standard` varchar(45) DEFAULT NULL COMMENT '企业商品采用的主要标准',
  `Comments` varchar(45) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_transportcar_basic
-- ----------------------------
DROP TABLE IF EXISTS `w_transportcar_basic`;
CREATE TABLE `w_transportcar_basic` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `CaNum` varchar(45) DEFAULT NULL COMMENT '车牌号',
  `Model` varchar(45) DEFAULT NULL COMMENT '车型',
  `Driver` varchar(45) DEFAULT NULL COMMENT '司机',
  `DrivingLcence` varchar(45) DEFAULT NULL COMMENT '驾驶证号',
  `Phone` varchar(45) DEFAULT NULL COMMENT '联系电话',
  `Inuse` varchar(45) DEFAULT '0' COMMENT '0:空闲 ,1:正在使用',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_user
-- ----------------------------
DROP TABLE IF EXISTS `w_user`;
CREATE TABLE `w_user` (
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `w_warehouse`;
CREATE TABLE `w_warehouse` (
  `wareHouseID` varchar(16) DEFAULT NULL,
  `initAmount` varchar(255) DEFAULT '0' COMMENT 'kg',
  `property` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for w_weighting
-- ----------------------------
DROP TABLE IF EXISTS `w_weighting`;
CREATE TABLE `w_weighting` (
  `basicid` int(255) NOT NULL AUTO_INCREMENT,
  `id` varchar(64) NOT NULL COMMENT '流水单号',
  `CarID` varchar(45) DEFAULT NULL COMMENT '车编号',
  `TotalWeight` varchar(45) DEFAULT NULL COMMENT '毛重',
  `CarWeight` varchar(45) DEFAULT NULL COMMENT '皮重',
  `TotalWeightingTime` varchar(45) DEFAULT NULL COMMENT '称毛重时间',
  `CarWeightingTime` varchar(45) DEFAULT NULL COMMENT '称皮重时间',
  `Flag` varchar(45) NOT NULL DEFAULT '1' COMMENT '标记为,0表示从出(入)库插入的数据,1表示称重环节插入的数据',
  `lastweight` varchar(45) NOT NULL DEFAULT '0' COMMENT '1表示最后一次称重',
  `Sid` varchar(64) DEFAULT NULL,
  `SBY` int(255) DEFAULT '0' COMMENT '1表示是补录的数据 0是走流程的数据',
  `location` varchar(30) DEFAULT NULL COMMENT '库点',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `late` varchar(255) DEFAULT '1',
  PRIMARY KEY (`basicid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='称重表';














