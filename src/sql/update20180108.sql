/* /reportHarbor/onlyReportList.shtml  --  只进行报港  */
/* /reportHarbor/notCheckListUI.shtml  --  只进行质检  */
/* /reportHarbor/printListUI.shtml  --  出入库检验单  */

/*添加备注--出库保管耗--报表*/
alter TABLE t_getout_storage_loss add COLUMN remark varchar(256) comment '备注';
alter TABLE t_getout_storage_loss add COLUMN gslProperty varchar(32) comment '粮食性质';
alter TABLE t_getout_storage_loss add COLUMN gslPackageWay varchar(256) comment '包装方式';
alter table t_getout_storage_loss add COLUMN lossPrice FLOAT COMMENT '损耗单价'; 
alter table t_getout_storage_loss add COLUMN lossMoney DECIMAL(12,2) COMMENT '报损金额';

alter TABLE t_getout_storage_loss_his add COLUMN remark varchar(256) comment '备注';
alter TABLE t_getout_storage_loss_his add COLUMN gslProperty varchar(32) comment '粮食性质';
alter TABLE t_getout_storage_loss_his add COLUMN gslPackageWay varchar(256) comment '包装方式';
alter table t_getout_storage_loss_his add COLUMN lossPrice FLOAT COMMENT '损耗单价'; 
alter table t_getout_storage_loss_his add COLUMN lossMoney DECIMAL(12,2) COMMENT '报损金额';

/*粮油保管账--报表*/
ALTER table t_quality_manager ADD COLUMN packageWay varchar(32) comment '包装方式';
ALTER table t_quality_manager ADD COLUMN managerWay varchar(32) comment '管理方式';
ALTER table t_quality_manager ADD COLUMN putinWay varchar(32) comment '入仓方式';
ALTER table t_quality_manager ADD COLUMN grainOwnership varchar(32) comment '粮权归属';
ALTER table t_quality_manager ADD COLUMN dNumber varchar(32) comment '凭证编号';
ALTER table t_quality_manager ADD COLUMN businessType char(1) comment '业务类别：1、入库，2、出库';
ALTER table t_quality_manager ADD COLUMN remark varchar(256) comment '备注/摘要';

ALTER table t_quality_manager_his ADD COLUMN packageWay varchar(32) comment '包装方式';
ALTER table t_quality_manager_his ADD COLUMN managerWay varchar(32) comment '管理方式';
ALTER table t_quality_manager_his ADD COLUMN putinWay varchar(32) comment '入仓方式';
ALTER table t_quality_manager_his ADD COLUMN grainOwnership varchar(32) comment '粮权归属';
ALTER table t_quality_manager_his ADD COLUMN dNumber varchar(32) comment '凭证编号';
ALTER table t_quality_manager_his ADD COLUMN businessType char(1) comment '业务类别：1、入库，2、出库';
ALTER table t_quality_manager_his ADD COLUMN remark varchar(256) comment '备注/摘要';
/*判断是否进行质检操作*/
alter table t_weight_report_harbor ADD COLUMN isChecked char(1) NOT null DEFAULT '1' COMMENT '是否质检：1、质检，2、未质检';
alter table t_weight_report_harbor_his ADD COLUMN isChecked char(1) NOT null DEFAULT '1' COMMENT '是否质检：1、质检，2、未质检';

/*检验单*/
ALTER TABLE t_weight_quality_check ADD COLUMN checkAim varchar(64) COMMENT '检验目的';
ALTER TABLE t_weight_quality_check ADD COLUMN checkWeight varchar(64) COMMENT '数量(吨)';
ALTER TABLE t_weight_quality_check ADD COLUMN remark varchar(256) COMMENT '备注';

ALTER TABLE t_weight_quality_check_his ADD COLUMN checkAim varchar(64) COMMENT '检验目的';
ALTER TABLE t_weight_quality_check_his ADD COLUMN checkWeight varchar(64) COMMENT '数量(吨)';
ALTER TABLE t_weight_quality_check_his ADD COLUMN remark varchar(256) COMMENT '备注';

/*药剂申请*/
ALTER TABLE t_medicament_apply ADD COLUMN remark varchar(256) COMMENT '备注';
ALTER TABLE t_medicament_apply_his ADD COLUMN remark varchar(256) COMMENT '备注';

/*创建表*/
create TABLE t_deliver_goods_detail(
id int NOT NULL auto_increment primary KEY,
agreementBill VARCHAR(64) COMMENT '合同编号',
deliverGoodsName VARCHAR(128) COMMENT '发货单位',
deliverGoodsStation VARCHAR(128) COMMENT '发货站（港）',
deliverGoodsDate varchar(16) COMMENT '发货日期',
grainVariety VARCHAR(32) COMMENT '发货品种',
warehouseName VARCHAR(32) COMMENT '仓号',
deliverGoodsNumberLower VARCHAR(16) COMMENT '发货数量（小写）',
deliverGoodsNumberUpper VARCHAR(32) COMMENT '发货数量（大写）',
getoutBill VARCHAR(32) COMMENT '出库单据号--报港单据号',
takeDeliveryName VARCHAR(128) COMMENT '收货单位',
takeDeliveryStation VARCHAR(128) COMMENT '到货站（港）',
takeDeliveryDate VARCHAR(16) COMMENT '到货日期',
takeDeliveryNumberLower VARCHAR(16) COMMENT '接收数量（小写）',
takeDeliveryNumberUpper VARCHAR(32) COMMENT '接受数量（大写）',
tureLossNumber VARCHAR(16) COMMENT '实际损耗量',
overstepNumber VARCHAR(16) COMMENT '超损量',
agreementName VARCHAR(128) COMMENT '合同对方单位',
transportName VARCHAR(128) COMMENT '运输单位',
transportTool VARCHAR(16) COMMENT '运输工具',
carOrShipNo VARCHAR(16) COMMENT '车船号',
transportBill VARCHAR(32) COMMENT '运单号',
transportLossRate VARCHAR(16) COMMENT '定额运输损耗率',
transportLossNumber VARCHAR(16) COMMENT '定额损耗量',
remark VARCHAR(128) COMMENT '备注',

deliverGoodsPerson VARCHAR(16) COMMENT '发货方经办人',
takeDeliveryPerson VARCHAR(16) COMMENT '收货方经办人',
transportPerson VARCHAR(16) COMMENT '运输方经办人',
imagePath VARCHAR(128) COMMENT '扫描件--图片路径',

version int not null DEFAULT 1 COMMENT '版本控制',
addUser int COMMENT '添加者',
addDate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间'
)COMMENT '发货明细';

create TABLE t_deliver_goods_detail_his(
id int,
agreementBill VARCHAR(64) COMMENT '合同编号',
deliverGoodsName VARCHAR(128) COMMENT '发货单位',
deliverGoodsStation VARCHAR(128) COMMENT '发货站（港）',
deliverGoodsDate varchar(16) COMMENT '发货日期',
grainVariety VARCHAR(32) COMMENT '发货品种',
warehouseName VARCHAR(32) COMMENT '仓号',
deliverGoodsNumberLower VARCHAR(16) COMMENT '发货数量（小写）',
deliverGoodsNumberUpper VARCHAR(32) COMMENT '发货数量（大写）',
getoutBill VARCHAR(32) COMMENT '出库单据号--报港单据号',
takeDeliveryName VARCHAR(128) COMMENT '收货单位',
takeDeliveryStation VARCHAR(128) COMMENT '到货站（港）',
takeDeliveryDate VARCHAR(16) COMMENT '到货日期',
takeDeliveryNumberLower VARCHAR(16) COMMENT '接收数量（小写）',
takeDeliveryNumberUpper VARCHAR(32) COMMENT '接受数量（大写）',
tureLossNumber VARCHAR(16) COMMENT '实际损耗量',
overstepNumber VARCHAR(16) COMMENT '超损量',
agreementName VARCHAR(128) COMMENT '合同对方单位',
transportName VARCHAR(128) COMMENT '运输单位',
transportTool VARCHAR(16) COMMENT '运输工具',
carOrShipNo VARCHAR(16) COMMENT '车船号',
transportBill VARCHAR(32) COMMENT '运单号',
transportLossRate VARCHAR(16) COMMENT '定额运输损耗率',
transportLossNumber VARCHAR(16) COMMENT '定额损耗量',
remark VARCHAR(128) COMMENT '备注',

deliverGoodsPerson VARCHAR(16) COMMENT '发货方经办人',
takeDeliveryPerson VARCHAR(16) COMMENT '收货方经办人',
transportPerson VARCHAR(16) COMMENT '运输方经办人',
imagePath VARCHAR(128) COMMENT '扫描件--图片路径',

version int COMMENT '版本控制',
addUser int COMMENT '添加者',
addDate TIMESTAMP COMMENT '添加时间',

execUser int(11) COMMENT '操作者',
execSQL text  COMMENT '操作SQL',
execType varchar(32) COMMENT '操作类型',
execDate timestamp COMMENT '操作时间'
)COMMENT '发货明细操作记录';


CREATE TABLE t_storage_steam_present_his (
	`id` INT (11),
	`charge` VARCHAR (255) DEFAULT NULL COMMENT '负责人',
	`cconcator` VARCHAR (255) DEFAULT NULL COMMENT '联系电话(负责人)',
	`east` VARCHAR (255) DEFAULT NULL COMMENT '警戒距离-东(米)',
	`south` VARCHAR (255) DEFAULT NULL COMMENT '警戒距离-南(米)',
	`west` VARCHAR (255) DEFAULT NULL COMMENT '警戒距离-西(米)',
	`north` VARCHAR (255) DEFAULT NULL COMMENT '警戒距离-北(米)：',
	`filler` VARCHAR (255) DEFAULT NULL COMMENT '填表人',
	`fconcator` VARCHAR (255) DEFAULT NULL COMMENT '联系电话(填表人)',
	`email` VARCHAR (255) DEFAULT NULL COMMENT '电子信箱(填表人)',
	`mName` VARCHAR (255) DEFAULT NULL COMMENT '药剂名称',
	`mType` VARCHAR (255) DEFAULT NULL COMMENT '类型/型号',
	`mDate` VARCHAR (50) DEFAULT NULL COMMENT '有效期至',
	`mPlace` VARCHAR (255) DEFAULT NULL COMMENT '暂存地点',
	`mAmount` VARCHAR (255) DEFAULT NULL COMMENT '领取数量',
	`mPerson` VARCHAR (255) DEFAULT NULL COMMENT '领取人',
	`mTime` VARCHAR (255) DEFAULT NULL COMMENT '领取时间',
	`mUseAmount` VARCHAR (255) DEFAULT NULL COMMENT '施药量(kg)',
	`mWay` VARCHAR (255) DEFAULT NULL COMMENT '施药设备及方式',
	`mComment` VARCHAR (255) DEFAULT NULL COMMENT '药剂残渣  ',
	`peopleMsg` text COMMENT '熏蒸人员信息',
	`targetMsg` text COMMENT '熏蒸对象信息',
	`timeCreate` VARCHAR (50) DEFAULT NULL COMMENT '创建时间',
	`status` VARCHAR (255) COMMENT '备案状态0 未上传  ,1 已上传',
	`files` VARCHAR (255) DEFAULT NULL COMMENT '关联t_commons_file sid',
	execUser INT (11) COMMENT '操作者',
	execSQL text COMMENT '操作SQL',
	execType VARCHAR (32) COMMENT '操作类型',
	execDate TIMESTAMP COMMENT '操作时间'
) COMMENT '熏蒸备案操作';


/*熏蒸备案*/
ALTER table t_storage_steam_present ADD COLUMN bill VARCHAR(32) COMMENT '备案编号';
ALTER TABLE t_storage_steam_present ADD COLUMN version INT NOT NULL DEFAULT 1 COMMENT '版本号';
ALTER TABLE t_storage_steam_present ADD COLUMN remark VARCHAR(128) COMMENT '备注';

ALTER table t_storage_steam_present_his ADD COLUMN bill VARCHAR(32) COMMENT '备案编号';
ALTER TABLE t_storage_steam_present_his ADD COLUMN version INT NOT NULL DEFAULT 1 COMMENT '版本号';
ALTER TABLE t_storage_steam_present_his ADD COLUMN remark VARCHAR(128) COMMENT '备注';


CREATE TABLE `t_storage_work_project_his` (
  `id` int(11),
  `type` char(1) DEFAULT NULL COMMENT '0:通风,1熏蒸 2冷却',
  `location` varchar(32) DEFAULT NULL COMMENT '库点位置',
  `houseid` varchar(32) DEFAULT NULL COMMENT '仓号',
  `breed` varchar(32) DEFAULT NULL COMMENT '粮食种类',
  `amount` varchar(32) DEFAULT NULL COMMENT '单位公斤',
  `temperature` varchar(32) DEFAULT NULL COMMENT '粮温',
  `houseTemperature` varchar(32) DEFAULT NULL COMMENT '仓内温度',
  `chonghai` varchar(64) DEFAULT NULL COMMENT '主要虫害',
  `perWeight` double DEFAULT NULL COMMENT '每公斤(头)',
  `length` double DEFAULT NULL COMMENT '长',
  `width` double DEFAULT NULL COMMENT '宽',
  `height` double DEFAULT NULL COMMENT '高',
  `lineHeight` double DEFAULT NULL COMMENT '堆粮线的高',
  `waterPer` varchar(32) DEFAULT NULL COMMENT '水分',
  `acturalHeight` double DEFAULT NULL COMMENT '实力存粮高度',
  `upperTemperature` varchar(32) DEFAULT NULL COMMENT '上层的温度',
  `footTemperature` varchar(32) DEFAULT NULL COMMENT '底层的温度',
  `wet` varchar(32) DEFAULT NULL COMMENT '大气湿度%',
  `innerWet` varchar(32) DEFAULT NULL COMMENT '舱内湿度(%)',
  `qiwen` varchar(32) DEFAULT NULL COMMENT '单位摄氏度',
  `windForm` varchar(64) DEFAULT NULL COMMENT '通风形式',
  `steamForm` varchar(64) DEFAULT NULL COMMENT '熏蒸形式',
  `coldForm` varchar(64) DEFAULT NULL COMMENT '冷却形式',
  `purpose` varchar(64) DEFAULT NULL COMMENT '通风目的',
  `times` varchar(20) DEFAULT NULL COMMENT '时间开始',
  `timee` varchar(20) DEFAULT NULL COMMENT '时间结束',
  `content` varchar(255) DEFAULT NULL COMMENT '方案内容',
  `status` char(1) DEFAULT '3' COMMENT '0 审批中 ,1 通过,2退回,3未提交',
  `ctime` varchar(50) DEFAULT NULL COMMENT '创建时间',
  `reason` varchar(255) DEFAULT NULL COMMENT '退回原因(非必须)',
  execUser INT (11) COMMENT '操作者',
	execSQL text COMMENT '操作SQL',
	execType VARCHAR (32) COMMENT '操作类型',
	execDate TIMESTAMP COMMENT '操作时间'
) COMMENT '作业方案编制操作记录';

ALTER TABLE t_storage_work_project ADD COLUMN version INT not NULL DEFAULT 1 COMMENT '版本';
ALTER TABLE t_storage_work_project ADD COLUMN bId varchar(32) COMMENT '熏蒸备案编号';

ALTER TABLE t_storage_work_project_his ADD COLUMN version INT not NULL DEFAULT 1 COMMENT '版本';
ALTER TABLE t_storage_work_project_his ADD COLUMN bId varchar(32) COMMENT '熏蒸备案编号';