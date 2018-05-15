/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : zhlk

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-03-16 17:35:10
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_resources
-- ----------------------------
INSERT INTO `t_resources` VALUES ('1', '系统基础管理', '0', 'system', '0', 'system', '1', 'glyphicon glyphicon-cog', '0', '系统基础管理');
INSERT INTO `t_resources` VALUES ('2', '用户管理', '1', 'account', '1', '/user/listUI.shtml', '1002', 'glyphicon glyphicon-user', '0', null);
INSERT INTO `t_resources` VALUES ('3', '角色管理', '1', 'role', '1', '/role/listUI.shtml', '1003', 'glyphicon glyphicon-eye-open', '0', '组管理');
INSERT INTO `t_resources` VALUES ('4', '菜单管理', '1', 't_resources', '1', '/resources/listUI.shtml', '1004', 'fa-list-alt', '0', '菜单管理');
INSERT INTO `t_resources` VALUES ('25', '登陆信息管理', '0', 't_login', '0', 't_login', '2001', 'glyphicon glyphicon-comment', '0', '登陆信息管理');
INSERT INTO `t_resources` VALUES ('26', '用户登录记录', '25', 't_log_list', '1', '/loginlog/listUI.shtml', '2002', '', '0', '用户登录记录');
INSERT INTO `t_resources` VALUES ('27', '操作日志管理', '0', 't_log', '0', 't_log', '2101', 'glyphicon glyphicon-list-alt', '1', '操作日志管理');
INSERT INTO `t_resources` VALUES ('28', '日志查询', '27', 't_log', '1', '/log/listUI.shtml', '2102', null, '0', null);
INSERT INTO `t_resources` VALUES ('32', '系统监控管理', '0', 'monitor', '0', 'monitor', '2201', 'fa-tag', '0', '系统监控管理');
INSERT INTO `t_resources` VALUES ('33', '实时监控', '32', 'sysmonitor', '1', '/monitor/monitor.shtml', '2202', null, '0', '实时监控');
INSERT INTO `t_resources` VALUES ('35', '告警列表', '32', 'monitor_warn', '1', '/monitor/list.shtml', '2203', null, '0', '告警列表');
INSERT INTO `t_resources` VALUES ('37', '树型菜单管理', '1', 't_resourcestree', '1', '/resources/treeListUI.shtml', '1', 'glyphicon glyphicon-home', '0', '1111');
INSERT INTO `t_resources` VALUES ('38', '测试菜单', '0', 'ceshi', '', 'ceshi', null, null, '0', '测试菜单');
INSERT INTO `t_resources` VALUES ('39', '测试菜单1', '38', 'ceshi1', null, 'ceshi1', null, null, '0', '测试菜单1');
INSERT INTO `t_resources` VALUES ('43', '测试菜单1-2', '39', 'ceshi1-2', null, 'ceshi1-2', null, null, '0', '测试菜单1-2');
INSERT INTO `t_resources` VALUES ('51', '测试菜单1-4', '39', 'ceshi1-4', '1', 'ceshi1-4', '1', '1', '0', '测试菜单1-4');
INSERT INTO `t_resources` VALUES ('52', '字典管理', '1', 'code_list', null, '/code/listUI.shtml', null, 'glyphicon glyphicon-book', '0', '字典维护');
INSERT INTO `t_resources` VALUES ('53', '县级粮库管理', '0', 'xjlkgl', null, 'xjlkgl', null, 'fa fa-home', '0', '县级粮库管理');
INSERT INTO `t_resources` VALUES ('54', '刘桥库', '53', 'xjlkgl_lq', null, 'xjlkgl_lq', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('55', '马塘库', '53', 'xjlkgl_mt', null, 'xjlkgl_mt', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('56', '视频点位', '54', 'dianwei_lq', null, '/liangku/shipindianwei.shtml?name=1000001', null, 'glyphicon glyphicon-facetime-video', '0', '刘桥库视频点位');
INSERT INTO `t_resources` VALUES ('57', '打印模板管理', '1', 'printtemplet', null, '/printtemplet/listUI.shtml', null, 'glyphicon glyphicon-print', '0', null);
INSERT INTO `t_resources` VALUES ('58', '粮情信息', '54', 'liangqing', null, '/warehouse/view.shtml?kd=1000001', '3', 'fa fa-thermometer-quarter', '0', 'aa');
INSERT INTO `t_resources` VALUES ('59', '库存信息', '54', 'kucunxixi', null, '/kcxx/kcxx.shtml?source=1000001', '4', 'glyphicon glyphicon-inbox', '0', '库存信息');
INSERT INTO `t_resources` VALUES ('60', '视频点位管理', '1', 'shipindianwei_list', null, '/shipindianwei/listUI.shtml', null, 'glyphicon glyphicon-facetime-video', '0', null);
INSERT INTO `t_resources` VALUES ('61', '业务管理', '76', 'yewuguanli', null, 'yewuguanli', null, '', '0', null);
INSERT INTO `t_resources` VALUES ('62', '计划管理', '61', 'jihuaguanli', null, 'jihuaguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('63', '地储计划', '62', 'dichujihua_list', null, '/businessManager/dichu/listUI.shtml?planType=1', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('64', '省储计划', '62', 'shengchujihua_list', null, '/businessManager/dichu/listUI.shtml?planType=2', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('65', '国储计划', '62', 'guochujihua_list', null, '/businessManager/dichu/listUI.shtml?planType=3', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('66', '商品粮计划', '62', 'shangpinliangjihua_list', null, '/businessManager/dichu/listUI.shtml?planType=4', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('68', '架空计划', '62', 'jiakongjihua_list', null, '/businessManager/jiakongjihua/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('69', '合同管理', '61', 'hetongguanli', null, 'hetongguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('70', '合同管理', '69', 'hetongguanli_list', null, '/businessManager/agreement/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('71', '客户管理', '61', 'kehuguanli', null, 'kehuguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('72', '客户管理', '71', 'kehuguanli_list', null, '/kehuguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('74', '供应商管理', '71', 'gongyingshangguanli_list', null, '/gongyingshangguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('75', '存储管理', '76', 'cunchuguanli', null, 'cunchuguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('76', '业务管理系统', '0', 'yewuguanli_p', null, 'yewuguanli_p', null, 'glyphicon glyphicon-book', '0', null);
INSERT INTO `t_resources` VALUES ('77', '储粮管理', '75', 'chuliangguanli', null, 'chuliangguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('78', '定性管理', '75', 'dingxingguanli_list', null, '/dingxingguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('79', '仓库管理', '75', 'cangkuguanli', null, 'cangkuguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('80', '损益管理', '75', 'sunyiguanli', null, 'sunyiguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('81', '库存管理', '75', 'kucunguanli', null, 'kucunguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('82', '出入库管理', '75', 'churukuguanli', null, 'churukuguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('83', '账卡管理', '75', 'zhangkaguanli', null, 'zhangkaguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('84', '设备管理', '75', 'shebeiguanli', null, 'shebeiguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('85', '储粮作业管理', '77', 'chuliangzuoyeguanli', null, 'chuliangzuoyeguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('86', '虫情管理', '77', 'chongqingguanli', null, 'chongqingguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('87', '粮情管理', '77', 'liangqingguanli', null, 'liangqingguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('88', '作业方案编制', '85', 'zuoyefanganbianzhi_list', null, '/foodStorageManager/project/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('89', '作业计划', '85', 'zuoyejihua_list', null, '/foodStorageManager/plan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('90', '作业审批', '85', 'zuoyeshenpi_lisy', null, '/foodStorageManager/approve/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('91', '作业记录', '85', 'zuoyejilu', null, 'zuoyejil', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('92', '作业备案', '85', 'zuoyebeian', null, 'zuoyebeian', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('93', '通风记录', '91', 'tongfengjilu_list', null, '/foodStorageManager/wind/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('94', '熏蒸记录', '91', 'xunzhengjilu_list', null, '/foodStorageManager/steamRecord/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('95', '冷却记录', '91', 'lengquejilu_list', null, '/foodStorageManager/cold/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('96', '空调降温记录', '91', 'kongtiaojiangwenjilu_list', null, '/foodStorageManager/airCold/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('97', '熏蒸备案', '92', 'xunzhengbeian_list', null, '/foodStorageManager/steamPlan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('98', '虫情检查情况记录', '86', 'chongqingjianchaqingkuangjilu_list', null, '/chongqingjianchaqingkuangjilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('99', '仓内传感器测控报表', '87', 'cangneichuanganqicekongbaobiao_list', null, '/cangneichuanganqicekongbaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('100', '粮情记录', '87', 'liangqingjilu_list', null, '/liangqingjilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('101', '基础资料', '79', 'jichuziliao_list', null, '/cangfangxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('102', '仓房维修', '79', 'cangfangweixiu_list', null, '/cangfangweixiu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('103', '保管员信息', '79', 'baoguanyuanxinxi_list', null, '/renyuandangan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('104', '仓容分配', '79', 'cangrongfenpei_list', null, '/cangrongfenpei/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('105', '移交管理', '79', 'yijiaoguanli_list', null, '/yijiaoguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('106', '倒仓管理', '79', 'daocangguanli_list', null, '/daocangguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('107', '粮食轮换入库整理耗', '80', 'liangshilunhuanrukuzhenglihao_list', null, '/liangshilunhuanrukuzhenglihao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('108', '粮食轮换出库保管耗', '80', 'liangshilunhuanchukubaoguanhao_list', null, '/liangshilunhuanchukubaoguanhao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('109', '库存平面信息展示', '81', 'kucunpingmianxinxizhanshi_list', null, '/kucunpingmianxinxizhanshi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('110', '初始存粮', '81', 'chushicunliang_list', null, '/chushicunliang/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('111', '实时库存', '81', 'shishikucun_list', null, '/shishikucun/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('112', '出库申请与审批', '82', 'chukushenqingyushenpi', null, 'chukushenqingyushenpi', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('113', '出入库方案', '82', 'churukufangan', null, 'churukufangan', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('114', '出入库记录', '82', 'churukujilu', null, ' /storage/register/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('115', '出入库补录', '82', 'churukubulu', null, '/storage/paramConfig/listUI.shtml?disable=true', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('116', '单据管理', '82', 'danjuguanli', null, 'danjuguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('117', '出库申请', '112', 'chukushenqing_list', null, '/chukushenqing/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('118', '出库审批', '112', 'chukushenpi_list', null, '/chukushenpi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('119', '审批记录', '112', 'shenpijilu_list', null, '/shenpijilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('120', '入库方案', '113', 'rukufangan_list', null, '/rukufangan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('121', '出库方案', '113', 'chukufangan_list', null, '/chukufangan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('126', '收购凭证', '116', 'shougoupingzheng_list', null, '/shougoupingzheng/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('127', '业务结算单', '116', 'yewujiesuandan_list', null, '/yewujiesuandan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('128', '收款通知单', '116', 'shoukuantongzhidan_list', null, '/shoukuantongzhidan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('129', '粮食收付日记帐', '83', 'liangshishoururijizhang_list', null, '/liangshishoufurijizhang/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('130', '保管总账', '83', 'baoguanzongzhang_list', null, '/baoguanzongzhang/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('131', '分仓保管账', '83', 'fencangbaoguanzhang_list', null, '/fencangbaoguanzhang/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('132', '粮油专卡', '83', 'liangyouzhuanka_list', null, '/liangyouzhuanka/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('133', '设备库存管理', '84', 'shebeikucunguanli_list', null, '/shebeikucunguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('134', '设备维修管理', '84', 'shebeiweixiuguanli_list', null, '/shebeiweixiuguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('135', '设备报废记录', '84', 'shebeibaofeijilu_list', null, '/shebeibaofeijilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('136', '设备汇总', '84', 'shebeihuizong_list', null, '/shebeihuizong/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('137', '药剂管理', '76', 'yaojiguanli', null, 'yaojiguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('138', '药剂领用申请', '137', 'yaojilingyongshenqing_list', null, '/yaojilingyongshenqing/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('139', '药剂领用审批', '137', 'yaojilingyongshenpi_list', null, '/yaojilingyongshenpi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('140', '药剂审批记录', '137', 'yaojilingyongshenpi_listRecord', null, '/yaojilingyongshenpi/listRecordUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('141', '药剂库存管理', '137', 'yaojikucunguanli_list', null, '/yaojikucunguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('142', '药剂领用管理', '137', 'yaojilingyongguanli_list', null, '/yaojilingyongguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('145', '残渣处理与空瓶回收表', '137', 'canzhachuli_list', null, '/canzhachuli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('146', '药剂管理监督', '137', 'yaojiguanlijiandu_list', null, '/yaojiguanlijiandu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('147', '质量管理', '76', 'zhiliangguanli', null, 'zhiliangguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('148', '质量检测', '147', 'zhiliangjiance', null, 'zhiliangjiance', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('149', '指标项管理', '147', 'zhibiaoxiangguanli', null, 'zhibiaoxiangguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('150', '化验器材管理', '147', 'huayanqicaiguanli', null, 'huayanqicaiguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('151', '粮油入库检验记录', '148', 'liangyourukujianyan_list', null, '/liangyourukujianyan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('152', '粮油检验入库统仓记录', '148', 'liangyourjianyanruku_list', null, '/zaikuzhiliangxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('153', '粮油出库检验记录', '148', 'liangyouchukujianyan_list', null, '/liangyouchukujianyan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('154', '粮油检验出库统仓记录', '148', 'liangyoujianyanchuku_list', null, '/liangyoujianyanchuku/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('155', '库存质量检测记录', '148', 'kucunzhiliangjiance_list', null, '/kucunzhiliangjiance/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('156', '零星样品检验记录', '148', 'lingxingyangpinjianyan_list', null, '/lingxingyangpinjianyan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('157', '质量指标', '149', 'zhiliangzhibiao_list', null, '/zhiliangzhibiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('158', '品质指标', '149', 'pinzhizhibiao_list', null, '/pinzhizhibiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('159', '卫生指标', '149', 'weishengzhibiao_list', null, '/weishengzhibiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('160', '粮食指标管理', '149', 'liangshizhibiaoguanli_list', null, '/liangshizhibiaoguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('161', '化验器材管理', '150', 'huayanqicaiguanli_list', null, '/huayanqicaiguanli/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('162', '化验器材维修记录', '150', 'huayanqicaiweixiujilu_list', null, '/huayanqicaiweixiujilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('163', '新安化验设备汇总表', '150', 'xinanhuayanshebei_list', null, '/xinanhuayanshebei/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('164', '设备管理', '76', 'shebeiguanli', null, 'shebeiguanli', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('165', '大型设备管理', '164', 'daxingshebei', null, 'daxingshebei', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('166', '化验器材管理', '164', 'huayanqicai', null, 'huayanqicai', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('167', '消防设备管理', '164', 'xiaofangshebei', null, 'xiaofangshebei', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('168', '报表查询', '76', 'baobiaochaxun', null, 'baobiaochaxun', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('169', '基础资料', '76', 'jichuziliao', null, 'jichuziliao', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('170', '仓库报表', '168', 'cangku', null, 'cangku', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('171', '质量报表', '168', 'zhiliang', null, 'zhiliang', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('172', '统计报表', '168', 'tongji', null, '/tongji/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('173', '粮库基础信息', '169', 'liangkujichu_list', null, '/liangkujichu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('174', '仓库人员信息档案', '169', 'renyuandangan_list', null, '/renyuandangan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('175', '仓房信息', '169', 'cangfang_list', null, '/cangfangxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('176', '库存管理', '165', 'kucunguanli_list', null, '/daxingshebeikucun/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('177', '资金管控系统', '76', 'zijinguankong', null, 'zijinguankong', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('178', '维修记录', '165', 'weixiujilu_list', null, '/daxingshebeiweixiu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('179', '报废记录', '165', 'baofeijilu_list', null, '/daxingshebeibaofei/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('180', '设备汇总', '165', 'shebeihuizong_list', null, '/daxingshebeihuizong/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('181', '资金计划', '177', 'zijinjihua_list', null, '/zijinjihua/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('182', '资金结算', '177', 'zijinjiesuan_list', null, '/zijinjiesuan/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('183', '资金报表', '177', 'zijinbaobiao_list', null, '/zijinbaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('184', '库存管理', '166', 'kucunguanli_list', null, '/huayanqicaikucun/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('185', '维修记录', '166', 'weixiujilu_list', null, '/huayanqicaiweixiu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('186', '报废记录', '166', 'baofeijilu_list', null, '/huayanqicaibaofei/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('187', '设备汇总', '166', 'shebeihuizong_list', null, '/huayanqicaihuizong/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('188', '粮食库内质量安全追溯系统', '76', 'liangshikuneizhilianganquanzhuisu', null, 'liangshikuneizhilianganquanzhuisu', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('189', '库存管理', '167', 'kucunguanli_list', null, '/xiaofangshebeikucun/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('190', '维修记录', '167', 'weixiujilu_list', null, '/xiaofangshebeiweixiu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('191', '报废记录', '167', 'baofeijilu_list', null, '/xiaofangshebeibaofei/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('192', '设备汇总', '167', 'shebeihuizong_list', null, '/xiaofangshebeihuizong/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('193', '粮情报表', '170', 'liangqing_list', null, '/liangqingbaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('194', '库存报表', '170', 'kucun_list', null, '/kucunbaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('195', '入库报表', '170', 'ruku_list', null, '/rukubaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('196', '出库报表', '170', 'chuku_list', null, '/chukubaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('197', '库存质检记录', '171', 'kucunzhijianjilu_list', null, '/kucunzhijianjilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('198', '入库质检记录', '171', 'rukuzhijianjilu_list', null, '/rukuzhijianjilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('199', '出库质检记录', '171', 'chukuzhijianjilu_list', null, '/chukuzhijianjilu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('200', '轮换入库整理耗', '171', 'lunhuanruku_list', null, '/lunhuanruku/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('201', '出入库质量信息', '188', 'rukuzhiliangxinxi_list', null, '/rukuzhiliangxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('202', '在库质量信息', '188', 'zaikuzhiliangxinxi_list', null, '/zaikuzhiliangxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('204', '储藏作业信息', '188', 'chucangzhiliangxinxi_list', null, '/chucangzuoyexinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('206', '销售信息', '188', 'xiaoshouxinxi_list', null, '/xiaoshouxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('207', '公共服务平台', '76', 'gonggongfuwupingtai', null, 'gonggongfuwupingtai', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('208', '识别代码', '76', 'shibiedaima', null, 'shibiedaima', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('209', '粮库介绍、地址位置', '207', 'liangkujieshao_list', null, '/liangkujieshao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('210', '粮食收购公告', '207', 'liangshishougou_list', null, '/liangshishougou/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('211', '粮食拍卖公告', '207', 'liangshipaimaigonggao_list', null, '/liangshipaimaigonggao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('212', '业务详情查看', '207', 'yewuxiangqing_list', null, '/yewuxiangqing/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('213', '自助报港', '207', 'zizhubaogang_list', null, '/zizhubaogang/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('214', '企业信息维护', '208', 'qiyexinxiweihu_list', null, '/qiyexinxiweihu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('215', '政策查询等服务', '207', 'zhengcechaxun_list', null, '/zhengcechaxun/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('216', '入库信息登记', '208', 'rukuxinxidengji_list', null, '/rukuxinxidengji/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('217', '出库信息登记', '208', 'chukuxinxidengji_list', null, '/chukuxinxidengji/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('218', '倒仓信息登记', '208', 'daocangxinxidengji_list', null, '/daocangxinxidengji/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('219', '数据上报', '208', 'shujushangbao_list', null, '/shujushangbao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('220', '粮权统计', '208', 'liangquantongji_list', null, '/liangquantongji/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('221', '远程监管接口', '76', 'yuanchengjianguanjiekou', null, 'yuanchengjianguanjiekou', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('222', '仓储信息', '221', 'cangchuxinxi_list', null, '/cangchuxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('223', '远程视频', '221', 'yuanchengshipin_list', null, '/shipindianwei/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('224', '粮温粮情', '221', 'liangwenliangqing_list', null, '/liangwenliangqing/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('225', '仓储智能化系统', '0', 'cangchuzhinenghuaxitong', null, 'cangchuzhinenghuaxitong', null, 'glyphicon glyphicon-globe', '0', null);
INSERT INTO `t_resources` VALUES ('226', '粮情监控', '225', 'liangqingjiankong', null, 'liangqingjiankong', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('227', '气体监控', '225', 'qitijiankong', null, 'qitijiankong', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('228', '粮情气体报警', '225', 'liangqingqitibaojing_list', null, '/liangqingqitibaojing/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('229', '仓内粮食基本信息', '226', 'cangneiliangshijibenxinxi_list', null, '/cangneiliangshijibenxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('230', '温度趋势', '226', 'wenduqushi_list', null, '/wenduqushi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('231', '温度报警设置', '226', 'wendubaojingshezhi_list', null, '/wendubaojingshezhi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('232', '粮情报表', '226', 'liangqingbaobiao_list', null, '/liangqingbaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('233', '粮情三维展示', '226', 'liangqingsanweizhanshi_list', null, '/liangqingsanweizhanshi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('234', '气体趋势', '227', 'qitiqushi_list', null, '/qitiqushi/listUI.shtml?name=1000001', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('235', '气体报警设置', '227', 'qitibaojingshezhi_list', null, '/qitibaojingshezhi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('236', '气体报表', '227', 'qitibaobiao_list', null, '/qitibaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('237', '智能安防系统', '0', 'zhinenganfangxitong', null, 'zhinenganfangxitong', null, 'glyphicon glyphicon-facetime-video', '0', null);
INSERT INTO `t_resources` VALUES ('238', '仓储可视化', '237', 'cangchukeshihua_list', null, '/liangku/shipindianwei.shtml?name=1000001', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('239', '熏蒸气体泄露检测', '237', 'xunzhengqitixieloujiance', null, 'xunzhengqitixieloujiance', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('240', '磷化氢报表', '239', 'linhuaqingbaobiao_list', null, '/linhuaqingbaobiao/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('241', '磷化氢报警设置', '239', 'linhuaqingbaojingshezhi_list', null, '/linhuaqingbaojingshezhi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('242', '磷化氢报警', '239', 'linhuaqingbaojing_list', null, '/linhuaqingbaojing/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('243', '收购信息', '188', 'shougouxinxi_list', null, '/shougouxinxi/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('244', '预约缴粮', '207', 'yuyuejiaoliang_list', null, '/yuyuejiaoliang/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('245', '信息发布', '207', 'xinxifabu_list', null, '/xinxifabu/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('246', '政策查询', '207', 'zhengcechaxun_list', null, '/zhengcechaxun/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('247', '出入库明细', '76', '/grain/detail.shtml', null, '/kcxx/detail.shtml?name=1000001', '10', 'glyphicon glyphicon-pencil', '0', null);
INSERT INTO `t_resources` VALUES ('250', '仓库点位管理', '1', 'cangkudianwei_list', null, '/cangkudianwei/listUI.shtml', null, 'glyphicon glyphicon-leaf', '0', '仓库点位管理');
INSERT INTO `t_resources` VALUES ('252', '视频点位', '55', 'dianwei_mt', null, '/liangku/shipindianwei.shtml?name=1000002', null, '', '0', '马塘库视频点位');
INSERT INTO `t_resources` VALUES ('253', '传感器管理', '1', '/sensorManager/listUI.shtml', null, '/sensorManager/listUI.shtml', null, 'glyphicon glyphicon-flash', '0', null);
INSERT INTO `t_resources` VALUES ('254', '硬盘录像机管理', '1', 'yingpanluxiangji_list', null, '/yingpanluxiangji/listUI.shtml', null, 'glyphicon glyphicon-hdd', '0', null);
INSERT INTO `t_resources` VALUES ('255', '粮情信息', '55', 'liangqing_mt', null, '/warehouse/view.shtml?kd=1000003', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('256', '栟搽', '53', 'xjlkgl_bc', null, 'xjlkgl', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('257', '粮情信息', '256', 'liangqing_bc', null, '/warehouse/view.shtml?kd=1000008', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('258', '岔河', '53', 'xjlkgk_bc', null, 'xjlkgl_bc', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('259', '粮情信息', '258', 'liangqing_chahe', null, '/warehouse/view.shtml?kd=1000002', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('260', '收储称重系统', '0', 'weighting', null, 'weighting', '4', 'glyphicon glyphicon-download-alt', '0', null);
INSERT INTO `t_resources` VALUES ('262', '出入库登记', '260', '/register/listUI.shtml', null, '/storage/register/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('263', '称重', '260', '/weighting/listUI.shtml', null, '/storage/weighting/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('264', '财务结算', '260', '/fiancePayment/listUI.shtml', null, '/storage/fiancePayment/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('265', '报表展示', '260', '/reports/listUI.shtml', null, '/storage/reports/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('266', '参数配置', '260', '/paramConfig/listUI.shtml', null, '/storage/paramConfig/listUI.shtml', null, null, '0', null);
INSERT INTO `t_resources` VALUES ('267', '上报管理', '0', 'report', null, 'report', null, 'glyphicon glyphicon-tags', '0', null);
INSERT INTO `t_resources` VALUES ('268', '粮食储藏上报', '267', 'warehouseSaveReport_addUI', null, '/warehouseSaveReport/addUI.shtml', '1', null, '0', null);
INSERT INTO `t_resources` VALUES ('269', '虫情检测', '86', 'chongqingjiance_list', null, '/chongqingjiance/list.shtml', '1', null, '0', null);
INSERT INTO `t_resources` VALUES ('270', '库存分点明细', '170', '/kucunmingxi/listUI', null, '/fendianmingxi/listUI.shtml', '2', null, '0', null);
