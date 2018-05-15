--修改大型设备表
ALTER TABLE t_large_equipment ADD COLUMN leWLNo INT NOT NULL;
ALTER TABLE t_large_equipment_his ADD COLUMN leWLNo INT NOT NULL;
--修改药剂库存表
ALTER TABLE t_medicament_repository ADD COLUMN mrWLNo INT NOT NULL;
ALTER TABLE t_medicament_repository_his ADD COLUMN mrWLNo INT NOT NULL;
--修改药剂领用表
ALTER TABLE t_medicament_used ADD COLUMN muWLNo INT NOT NULL;
ALTER TABLE t_medicament_used_his ADD COLUMN muWLNo INT NOT NULL;
--修改药剂申请表
ALTER TABLE t_medicament_apply ADD COLUMN maWLNo INT NOT NULL;
ALTER TABLE t_medicament_apply_his ADD COLUMN maWLNo INT NOT NULL;

--创建表t_warehouse_info_transform
CREATE TABLE `t_warehouse_info_transform` (
  `oid` int(11) NOT NULL COMMENT '原始数据ID',
  `rowNum` int(11) NOT NULL COMMENT '行号',
  `layNum` char(2) NOT NULL COMMENT '层号',
  `C1` float DEFAULT NULL,
  `C2` float DEFAULT NULL,
  `C3` float DEFAULT NULL,
  `C4` float DEFAULT NULL,
  `C5` float DEFAULT NULL,
  `C6` float DEFAULT NULL,
  `C7` float DEFAULT NULL,
  `C8` float DEFAULT NULL,
  KEY `FK_transgorm_id` (`oid`),
  CONSTRAINT `FK_transgorm_id` FOREIGN KEY (`oid`) REFERENCES `t_warehouse_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='温度转换数据';

/*温度报警*/
create table t_temperature_alarm(
id int auto_increment primary key,
wId int not null comment '仓号',
position text comment '报警位置',
alarmTemperature float comment '报警温度',
alarmDate timestamp comment '报警时间',
cjsj timestamp comment '采集时间',
wiId int not null comment '粮温id'
) comment '温度报警';

--修改实时库存
alter table t_storag_info add COLUMN buyYear char(4) COMMENT '收获年度';

--微信报港数据
alter table t_weight_report_harbor add COLUMN wxId varchar(32) comment '微信报港id';
alter table t_weight_report_harbor_his add COLUMN wxId varchar(32) comment '微信报港id';

--更改用户出生日期
ALTER TABLE t_person_archives MODIFY COLUMN paBirthday datetime;
ALTER TABLE t_person_archives_his MODIFY COLUMN paBirthday datetime;

create table t_business_agreement_form(
id int auto_increment primary key,
fName varchar(64) comment '模版名称',
fFile varchar(64) comment '模版文件名'
)comment '合同模版';

