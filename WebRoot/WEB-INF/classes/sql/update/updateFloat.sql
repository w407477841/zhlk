/*库存变化记录表*/
create table t_storage_change(
id int auto_increment primary key,
oId int comment '原始ID',
storageWeight decimal(20) comment '库存量',
changeWeight decimal(20) comment '变换量',
afterWeight decimal(20) comment '变换后量',
changeDate varchar(32) comment '变换时间',
changeUser int comment '数据修改者',
changeType varchar(32) comment '修改类型',
operateTable varchar(64) comment '操作数据表',
operateID varchar(32) comment '操作数据表示'
) comment '库存变化记录表';
/*仓库操作记录*/
CREATE TABLE t_warehouse_his (
  id int(11),
  wNo varchar(16) ,
  wName varchar(32) ,
  wHeight int(11) ,
  wColumn int(11) ,
  wRow int(11) ,
  wLocation int(11) ,
  wStatus int(11) ,
  wDisable char(1) ,
  
  execUser int comment '操作者',
  execSQL text comment '操作语句',
  execType varchar(16) comment '操作类型',
  execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '仓库操作记录';
/*粮库站点*/
CREATE TABLE t_warehouse_location_his (
  id int(11),
  wNo varchar(16) ,
  wName varchar(32) ,
  wStatus int(11) ,
  wDisable char(1) ,
  wSummary varchar(512) ,
  wLog varchar(16),
  wLat varchar(16) ,
  wFullName varchar(128) ,
  wImage varchar(128) ,
  wPlaneImage varchar(128) ,
  
  execUser int comment '操作者',
  execSQL text comment '操作语句',
  execType varchar(16) comment '操作类型',
  execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '站点操作记录'


/*储量计划*/
alter table t_business_plan MODIFY newPlanedAmount DECIMAL(20);
alter table t_business_plan MODIFY totalAmount DECIMAL(20);
alter table t_business_plan MODIFY turnPlannedAmount DECIMAL(20);
alter table t_business_plan MODIFY completedAmount DECIMAL(20);
alter table t_business_plan MODIFY originalWeight DECIMAL(20);
/*架空计划*/
alter table t_business_plan_jiakong MODIFY amount DECIMAL(20);
/*仓房移交*/
alter table t_warehouse_transfer MODIFY wtRemark varchar(256);
alter table t_warehouse_transfer_his MODIFY wtRemark varchar(256);
/*出库申请*/
alter table t_getout_storage_apply modify gsaTransferTools varchar(64);
alter table t_getout_storage_apply_his modify gsaTransferTools varchar(64);
alter table t_getout_storage_apply modify gsaApplyPerson varchar(32);
alter table t_getout_storage_apply_his modify gsaApplyPerson varchar(32);

alter table t_getout_storage_apply modify gsaPlanOutWeight DECIMAL(20);
alter table t_getout_storage_apply_his modify gsaPlanOutWeight DECIMAL(20);

alter table t_getout_storage_apply modify gsaCurrentWeight DECIMAL(20);
alter table t_getout_storage_apply_his modify gsaCurrentWeight DECIMAL(20);
/*入库方案*/
alter table t_putin_storage_plan modify pspFileName varchar(64);
alter table t_putin_storage_plan_his modify pspFileName varchar(64);
alter table t_putin_storage_plan modify pspContent varchar(512);
alter table t_putin_storage_plan_his modify pspContent varchar(512);
alter table t_putin_storage_plan modify pspWeight DECIMAL(20);
alter table t_putin_storage_plan_his modify pspWeight DECIMAL(20);
/*出库方案*/
alter table t_getout_storage_plan modify gspFileName varchar(64);
alter table t_getout_storage_plan_his modify gspFileName varchar(64);
alter table t_getout_storage_plan modify gspContent varchar(512);
alter table t_getout_storage_plan_his modify gspContent varchar(512);
alter table t_getout_storage_plan modify gspWeight DECIMAL(20);
alter table t_getout_storage_plan_his modify gspWeight DECIMAL(20);
/*轮换入库损耗*/
alter table t_putin_storage_loss MODIFY pslPutInFluid FLOAT;
alter table t_putin_storage_loss MODIFY pslPutInImpurity FLOAT;
alter table t_putin_storage_loss MODIFY pslCleanUpFluid FLOAT;
alter table t_putin_storage_loss MODIFY pslCleanUpImpurity FLOAT;

alter table t_putin_storage_loss MODIFY pslPutInWeight DECIMAL(20);
alter table t_putin_storage_loss MODIFY pslCleanUpWeight DECIMAL(20);
alter table t_putin_storage_loss MODIFY pslFluidReduce DECIMAL(20);
alter table t_putin_storage_loss MODIFY pslImpurityReduce DECIMAL(20);
alter table t_putin_storage_loss MODIFY pslTotalReduce DECIMAL(20);

alter table t_putin_storage_loss_his MODIFY pslPutInFluid FLOAT;
alter table t_putin_storage_loss_his MODIFY pslPutInImpurity FLOAT;
alter table t_putin_storage_loss_his MODIFY pslCleanUpFluid FLOAT;
alter table t_putin_storage_loss_his MODIFY pslCleanUpImpurity FLOAT;

alter table t_putin_storage_loss_his MODIFY pslPutInWeight DECIMAL(20);
alter table t_putin_storage_loss_his MODIFY pslCleanUpWeight DECIMAL(20);
alter table t_putin_storage_loss_his MODIFY pslFluidReduce DECIMAL(20);
alter table t_putin_storage_loss_his MODIFY pslImpurityReduce DECIMAL(20);
alter table t_putin_storage_loss_his MODIFY pslTotalReduce DECIMAL(20);
/*出库保管耗*/
alter table t_getout_storage_loss MODIFY gslPutInFluid FLOAT;
alter table t_getout_storage_loss MODIFY gslPutInImpurity FLOAT;
alter table t_getout_storage_loss MODIFY gslGetOutFluid FLOAT;
alter table t_getout_storage_loss MODIFY gslGetOutImpurity FLOAT;
alter table t_getout_storage_loss MODIFY gslLossRate FLOAT;

alter table t_getout_storage_loss MODIFY gslPutInWeight DECIMAL(20);
alter table t_getout_storage_loss MODIFY gslGetOutWeight DECIMAL(20);
alter table t_getout_storage_loss MODIFY gslTotalReduce DECIMAL(20);
alter table t_getout_storage_loss MODIFY gslLossWeight DECIMAL(20);
alter table t_getout_storage_loss MODIFY gslCleanUpWeight DECIMAL(20);
alter table t_getout_storage_loss MODIFY gslOverrateWeight DECIMAL(20);
alter table t_getout_storage_loss MODIFY gslOverflowWeight DECIMAL(20);


alter table t_getout_storage_loss_his MODIFY gslPutInFluid FLOAT;
alter table t_getout_storage_loss_his MODIFY gslPutInImpurity FLOAT;
alter table t_getout_storage_loss_his MODIFY gslGetOutFluid FLOAT;
alter table t_getout_storage_loss_his MODIFY gslGetOutImpurity FLOAT;
alter table t_getout_storage_loss_his MODIFY gslLossRate FLOAT;

alter table t_getout_storage_loss_his MODIFY gslPutInWeight DECIMAL(20);
alter table t_getout_storage_loss_his MODIFY gslGetOutWeight DECIMAL(20);
alter table t_getout_storage_loss_his MODIFY gslTotalReduce DECIMAL(20);
alter table t_getout_storage_loss_his MODIFY gslLossWeight DECIMAL(20);
alter table t_getout_storage_loss_his MODIFY gslCleanUpWeight DECIMAL(20);
alter table t_getout_storage_loss_his MODIFY gslOverrateWeight DECIMAL(20);
alter table t_getout_storage_loss_his MODIFY gslOverflowWeight DECIMAL(20);
/*库存质检*/
ALTER table t_quality_manager MODIFY currentWeight decimal(20);
ALTER table t_quality_manager_his MODIFY currentWeight decimal(20);
/*药剂库存*/
alter table t_medicament_repository MODIFY mrBrand VARCHAR(128);
alter table t_medicament_repository MODIFY mrStandard VARCHAR(64);
alter table t_medicament_repository MODIFY mrPrice FLOAT;
alter table t_medicament_repository MODIFY mrUnit VARCHAR(128);
alter table t_medicament_repository MODIFY mrProductCompany VARCHAR(128);
alter table t_medicament_repository MODIFY mrOperator VARCHAR(128);
alter table t_medicament_repository MODIFY mrAuditor VARCHAR(128);
alter table t_medicament_repository MODIFY mrRemark VARCHAR(128);

alter table t_medicament_repository_his MODIFY mrBrand VARCHAR(128);
alter table t_medicament_repository_his MODIFY mrStandard VARCHAR(64);
alter table t_medicament_repository_his MODIFY mrPrice FLOAT;
alter table t_medicament_repository_his MODIFY mrUnit VARCHAR(128);
alter table t_medicament_repository_his MODIFY mrProductCompany VARCHAR(128);
alter table t_medicament_repository_his MODIFY mrOperator VARCHAR(128);
alter table t_medicament_repository_his MODIFY mrAuditor VARCHAR(128);
alter table t_medicament_repository_his MODIFY mrRemark VARCHAR(128);
/*药剂领用*/
ALTER table t_medicament_used MODIFY muName VARCHAR(128);
ALTER table t_medicament_used MODIFY muBrand VARCHAR(128);
ALTER table t_medicament_used MODIFY muStandard VARCHAR(64);
ALTER table t_medicament_used MODIFY muPrice FLOAT;
ALTER table t_medicament_used MODIFY muNumber int;
ALTER table t_medicament_used MODIFY muUnit VARCHAR(128);
ALTER table t_medicament_used MODIFY muProductCompany VARCHAR(128);
ALTER table t_medicament_used MODIFY muApplicant VARCHAR(64);
ALTER table t_medicament_used MODIFY muAuditor VARCHAR(64);
ALTER table t_medicament_used MODIFY muSupervisor VARCHAR(64);
ALTER table t_medicament_used MODIFY muUsed VARCHAR(256);

ALTER table t_medicament_used_his MODIFY muName VARCHAR(128);
ALTER table t_medicament_used_his MODIFY muBrand VARCHAR(128);
ALTER table t_medicament_used_his MODIFY muStandard VARCHAR(64);
ALTER table t_medicament_used_his MODIFY muPrice FLOAT;
ALTER table t_medicament_used_his MODIFY muNumber int;
ALTER table t_medicament_used_his MODIFY muUnit VARCHAR(128);
ALTER table t_medicament_used_his MODIFY muProductCompany VARCHAR(128);
ALTER table t_medicament_used_his MODIFY muApplicant VARCHAR(64);
ALTER table t_medicament_used_his MODIFY muAuditor VARCHAR(64);
ALTER table t_medicament_used_his MODIFY muSupervisor VARCHAR(64);
ALTER table t_medicament_used_his MODIFY muUsed VARCHAR(256);
/*药剂申请*/
ALTER table t_medicament_apply MODIFY maName VARCHAR(128);
ALTER table t_medicament_apply MODIFY maBrand VARCHAR(128);
ALTER table t_medicament_apply MODIFY maPage int;
ALTER table t_medicament_apply MODIFY maStandard VARCHAR(64);
ALTER table t_medicament_apply MODIFY maUnit VARCHAR(128);
ALTER table t_medicament_apply MODIFY maProductCompany VARCHAR(128);
ALTER table t_medicament_apply MODIFY maQuantity int;
ALTER table t_medicament_apply MODIFY maApplicant VARCHAR(64);
ALTER table t_medicament_apply MODIFY maProcess VARCHAR(16);
ALTER table t_medicament_apply MODIFY maUsed VARCHAR(256);
ALTER table t_medicament_apply MODIFY maOpinion VARCHAR(256);

ALTER table t_medicament_apply_his MODIFY maName VARCHAR(128);
ALTER table t_medicament_apply_his MODIFY maBrand VARCHAR(128);
ALTER table t_medicament_apply_his MODIFY maPage int;
ALTER table t_medicament_apply_his MODIFY maStandard VARCHAR(64);
ALTER table t_medicament_apply_his MODIFY maUnit VARCHAR(128);
ALTER table t_medicament_apply_his MODIFY maProductCompany VARCHAR(128);
ALTER table t_medicament_apply_his MODIFY maQuantity int;
ALTER table t_medicament_apply_his MODIFY maApplicant VARCHAR(64);
ALTER table t_medicament_apply_his MODIFY maProcess VARCHAR(16);
ALTER table t_medicament_apply_his MODIFY maUsed VARCHAR(256);
ALTER table t_medicament_apply_his MODIFY maOpinion VARCHAR(256);
/*设备管理*/
ALTER table t_large_equipment MODIFY leName VARCHAR(64);
ALTER table t_large_equipment MODIFY leStandard VARCHAR(32);
ALTER table t_large_equipment MODIFY leWorth DECIMAL(20,2);
ALTER table t_large_equipment MODIFY leMotorsNumber int;
ALTER table t_large_equipment MODIFY lePower FLOAT;
ALTER table t_large_equipment MODIFY leTelephone VARCHAR(16);
ALTER table t_large_equipment MODIFY leZipCode CHAR(6);
ALTER table t_large_equipment MODIFY leLocation VARCHAR(32);
ALTER table t_large_equipment MODIFY leManufacturingUnit VARCHAR(128);
ALTER table t_large_equipment MODIFY leManufacturingAddress VARCHAR(128);
ALTER table t_large_equipment MODIFY leSon VARCHAR(256);
ALTER table t_large_equipment MODIFY leType int;
ALTER table t_large_equipment MODIFY leUnit int;
ALTER table t_large_equipment MODIFY leManufacturingUnit VARCHAR(128);
ALTER table t_large_equipment MODIFY leManufacturingUnit VARCHAR(128);

ALTER table t_large_equipment_his MODIFY leName VARCHAR(64);
ALTER table t_large_equipment_his MODIFY leStandard VARCHAR(32);
ALTER table t_large_equipment_his MODIFY leWorth DECIMAL(20,2);
ALTER table t_large_equipment_his MODIFY leMotorsNumber int;
ALTER table t_large_equipment_his MODIFY lePower FLOAT;
ALTER table t_large_equipment_his MODIFY leTelephone VARCHAR(16);
ALTER table t_large_equipment_his MODIFY leZipCode CHAR(6);
ALTER table t_large_equipment_his MODIFY leLocation VARCHAR(32);
ALTER table t_large_equipment_his MODIFY leManufacturingUnit VARCHAR(128);
ALTER table t_large_equipment_his MODIFY leManufacturingAddress VARCHAR(128);
ALTER table t_large_equipment_his MODIFY leSon VARCHAR(256);
ALTER table t_large_equipment_his MODIFY leType int;
ALTER table t_large_equipment_his MODIFY leUnit int;
ALTER table t_large_equipment_his MODIFY leManufacturingUnit VARCHAR(128);
ALTER table t_large_equipment_his MODIFY leManufacturingUnit VARCHAR(128);
/*预约缴粮*/
alter table t_appointment_grain MODIFY agIDCard varchar(18);
alter table t_appointment_grain MODIFY agNumber DECIMAL(20);
alter table t_appointment_grain MODIFY agAddress varchar(128);

alter table t_appointment_grain_his MODIFY agIDCard varchar(18);
alter table t_appointment_grain_his MODIFY agNumber DECIMAL(20);
alter table t_appointment_grain_his MODIFY agAddress varchar(128);
/*粮库信息*/
ALTER table t_warehouse_location_archives MODIFY wlaPhoneNumber VARCHAR(16);
ALTER table t_warehouse_location_archives MODIFY wlaCapacity DECIMAL(20);
ALTER table t_warehouse_location_archives MODIFY wlaOrganization VARCHAR(32);
ALTER table t_warehouse_location_archives MODIFY wlaAdministrativeCode VARCHAR(16);
ALTER table t_warehouse_location_archives MODIFY wlaFaxNumber VARCHAR(16);

ALTER table t_warehouse_location_archives_his MODIFY wlaPhoneNumber VARCHAR(16);
ALTER table t_warehouse_location_archives_his MODIFY wlaCapacity DECIMAL(20);
ALTER table t_warehouse_location_archives_his MODIFY wlaOrganization VARCHAR(32);
ALTER table t_warehouse_location_archives_his MODIFY wlaAdministrativeCode VARCHAR(16);
ALTER table t_warehouse_location_archives_his MODIFY wlaFaxNumber VARCHAR(16);
/*仓房信息*/
ALTER TABLE t_warehouse_archives MODIFY waHeatInsulator VARCHAR(32);
ALTER TABLE t_warehouse_archives MODIFY waWarehouseType VARCHAR(32);
ALTER TABLE t_warehouse_archives MODIFY waStructure VARCHAR(32);
ALTER TABLE t_warehouse_archives MODIFY waAeration VARCHAR(32);
ALTER TABLE t_warehouse_archives MODIFY waFumigate VARCHAR(32);
ALTER TABLE t_warehouse_archives MODIFY waDesignCapacity DECIMAL(20);
ALTER TABLE t_warehouse_archives MODIFY waSequence VARCHAR(32);

ALTER TABLE t_warehouse_archives_his MODIFY waHeatInsulator VARCHAR(32);
ALTER TABLE t_warehouse_archives_his MODIFY waWarehouseType VARCHAR(32);
ALTER TABLE t_warehouse_archives_his MODIFY waStructure VARCHAR(32);
ALTER TABLE t_warehouse_archives_his MODIFY waAeration VARCHAR(32);
ALTER TABLE t_warehouse_archives_his MODIFY waFumigate VARCHAR(32);
ALTER TABLE t_warehouse_archives_his MODIFY waDesignCapacity DECIMAL(20);
ALTER TABLE t_warehouse_archives_his MODIFY waSequence VARCHAR(32);
/*人员档案*/
ALTER table t_person_archives MODIFY paSex CHAR(2);
ALTER table t_person_archives MODIFY paEmail VARCHAR(64);
ALTER table t_person_archives MODIFY paOfficePhone VARCHAR(16);
ALTER table t_person_archives MODIFY paNation VARCHAR(32);
ALTER table t_person_archives MODIFY paQQ VARCHAR(12);
ALTER table t_person_archives MODIFY paDegree VARCHAR(32);
ALTER table t_person_archives MODIFY paHealth VARCHAR(32);
ALTER table t_person_archives MODIFY paDepartment VARCHAR(32);
ALTER table t_person_archives MODIFY paDuty VARCHAR(32);

ALTER table t_person_archives_his MODIFY paSex CHAR(2);
ALTER table t_person_archives_his MODIFY paEmail VARCHAR(64);
ALTER table t_person_archives_his MODIFY paOfficePhone VARCHAR(16);
ALTER table t_person_archives_his MODIFY paNation VARCHAR(32);
ALTER table t_person_archives_his MODIFY paQQ VARCHAR(12);
ALTER table t_person_archives_his MODIFY paDegree VARCHAR(32);
ALTER table t_person_archives_his MODIFY paHealth VARCHAR(32);
ALTER table t_person_archives_his MODIFY paDepartment VARCHAR(32);
ALTER table t_person_archives_his MODIFY paDuty VARCHAR(32);