create table t_weight_report_harbor(
id int auto_increment primary key,
bId varchar(16) not null unique comment '单据号',
cardId varchar(64) unique comment '一卡通',
userName varchar(16) not null comment '姓名',
IDCard varchar(32) comment '身份证',
address varchar(64) comment '地址',
phoneNumber varchar(16) comment '电话号码',
shipId varchar(16) comment '车船号',
wId int comment '仓号',
grainVariety varchar(32) comment '粮食品种',
grainProperty varchar(32) comment '粮食性质',
buyPrice float comment '收购价格',
checker varchar(16) comment '检查员',
grossWeight float comment '毛重',
tare float comment '皮重',
totalWeight float comment '总重',
otherReduce float comment '其他扣重',
totalReduce float comment '总扣重',
trueWeight float comment '结算重量',
weightAuthor varchar(16) comment '称重人员',
sumMoney float comment '结算金额',
payType char(10) comment '结算方式:转账，现金',
bankName varchar(32) comment '银行',
bankId varchar(32) comment '银行卡',
payAuthor varchar(16) comment '结算员',
payStatus char(10) comment '结算状态:待结算，结算完成',
payDate varchar(32) comment '结算时间',
payPlanId varchar(32) comment '资金计划编号',
addDate varchar(32) comment '报港时间',
weightEndDate varchar(32) comment '称重完成时间',
inOrOut char(1) comment '收支指标：1:出库，2:入库',
positionNum char(2) comment '货位号',
usedCar char(1) comment '是否驳车：1：驳车，2：不驳车',
addRecord char(1) not null default '2' comment '是否补录：1：补录，2：不是补录',
isAdd char(1) not null default '1' comment '是否插入实时库存：1：未插入，2：已插入',
printCount int not null default 0 comment '凭证打印次数',
version int not null default 1 comment '版本'
)comment '报港信息';

create table t_weight_report_harbor_his(
id int ,
bId varchar(16) comment '单据号',
cardId varchar(64) not null comment '一卡通',
userName varchar(16) not null comment '姓名',
IDCard varchar(32) comment '身份证',
address varchar(64) comment '地址',
phoneNumber varchar(16) comment '电话号码',
shipId varchar(16) comment '车船号',
wId int comment '仓号',
grainVariety varchar(32) comment '粮食品种',
grainProperty varchar(32) comment '粮食性质',
buyPrice float comment '收购价格',
checker varchar(16) comment '检查员',
grossWeight float comment '毛重',
tare float comment '皮重',
totalWeight float comment '总重',
otherReduce float comment '其他扣重',
totalReduce float comment '总扣重',
trueWeight float comment '结算重量',
weightAuthor varchar(16) comment '称重人员',
sumMoney float comment '结算金额',
payType char(10) comment '结算方式:转账，现金',
bankName varchar(32) comment '银行',
bankId varchar(32) comment '银行卡',
payAuthor varchar(16) comment '结算员',
payStatus char(10) comment '结算状态:待结算，结算完成',
payDate varchar(32) comment '结算时间',
payPlanId varchar(32) comment '资金计划编号',
addDate varchar(32) comment '报港时间',
weightEndDate varchar(32) comment '称重完成时间',
inOrOut char(1) comment '收支指标：1:出库，2:入库',
positionNum char(2) comment '货位号',
usedCar char(1) comment '是否驳车：1：驳车，2：不驳车',
addRecord char(1) comment '是否补录：1：补录，2：不是补录',
isAdd char(1) comment '是否插入实时库存：1：未插入，2：已插入',
printCount int not null default 0 comment '凭证打印次数',
version int not null default 1 comment '版本',

execUser int comment '操作者',
execSQL text comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '报港信息操作数据';


create table t_weight_quality_check(
id int auto_increment primary key,
bId varchar(16) comment '单据号',
rz float comment '容重出糙',
sf float comment '水分',
zz float comment '杂质',
kwz float comment '矿物质',
bwsld float comment '不完善粒度',
zjml float comment '整精米粒',
gwcm float comment '谷外糙米',
hlm float comment '黄粒米',
hh float comment '互混',

sfkl float comment '水分扣量',
zzkl float comment '杂质扣量',
kwzkl float comment '矿物质扣量',
bwsldkl float comment '不完善粒度扣量',
zjmlkl float comment '整精米粒扣量',
gwcmkl float comment '谷外糙米扣量',
hlmkl float comment '黄粒米扣量',
hhkl float comment '互混扣量',

cmbl float comment '赤霉病粒',
ydzs float comment '硬度指数',
szqw varchar(16) comment '色泽气味',
level char(2) comment '等级',
version int not null default 1,
CONSTRAINT FK_baogang_zhijian foreign key(bId) references t_weight_report_harbor(bId)
)comment '质检信息';

create table t_weight_quality_check_his(
id int,
bId varchar(16) comment '单据号',
rz float comment '容重出糙',
sf float comment '水分',
zz float comment '杂质',
kwz float comment '矿物质',
bwsld float comment '不完善粒度',
zjml float comment '整精米粒',
gwcm float comment '谷外糙米',
hlm float comment '黄粒米',
hh float comment '互混',

sfkl float comment '水分扣量',
zzkl float comment '杂质扣量',
kwzkl float comment '矿物质扣量',
bwsldkl float comment '不完善粒度扣量',
zjmlkl float comment '整精米粒扣量',
gwcmkl float comment '谷外糙米扣量',
hlmkl float comment '黄粒米扣量',
hhkl float comment '互混扣量',

cmbl float comment '赤霉病粒',
ydzs float comment '硬度指数',
szqw varchar(16) comment '色泽气味',
level char(2) comment '等级',
version int not null default 1,

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '质检信息操作数据';

create table t_weight_weighing(
id int auto_increment primary key,
bId varchar(16) comment '单据号',
carId varchar(16) comment '车号',
grossWeight float comment '毛重',
tare float comment '皮重',
grossWeightDate varchar(32) comment '称毛时间',
tarDate varchar(32) comment '称皮时间',
grossWeightPhoto varchar(128) comment '称毛截图',
tarPhoto varchar(128) comment '称皮截图',
weightPerson varchar(16) comment '司磅员',
version int not null default 1 comment '版本',
CONSTRAINT FK_weight_weighting foreign key(bId) references t_weight_report_harbor(bId)
)comment '称重信息';

create table t_weight_weighing_his(
id int,
bId varchar(16) comment '单据号',
carId varchar(16) comment '车号',
grossWeight float comment '毛重',
tare float comment '皮重',
grossWeightDate varchar(32) comment '称毛时间',
tarDate varchar(32) comment '称皮时间',
grossWeightPhoto varchar(128) comment '称毛截图',
tarPhoto varchar(128) comment '称皮截图',
weightPerson varchar(64) comment '司磅员',
version int not null default 1 comment '版本',

execUser int comment '操作者',
execSQL text comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '称重信息操作数据';

create table t_weight_car_archives(
id int auto_increment primary key,
cId varchar(16) not null UNIQUE comment '车牌号',
carType varchar(16) comment '车型',
driver varchar(16) comment '驾驶员',
driveLicense varchar(32) comment '驾驶证',
phoneNumber varchar(16) comment '电话号码',
bId varchar(16) not null default '' comment '单据号',
RFID varchar(64) not null default '' comment 'RFID卡号',
RFIDName varchar(32) not null default '' comment 'RFID卡名',
oDate timestamp null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '操作时间',
version int not null default 1 comment '版本'
)comment '车辆档案';

create table t_weight_car_archives_his(
id int,
cId varchar(16) comment '车牌号',
carType varchar(16) comment '车型',
driver varchar(16) comment '驾驶员',
driveLicense varchar(32) comment '驾驶证',
phoneNumber varchar(16) comment '电话号码',
bId varchar(16) not null default '' comment '单据号',
RFID varchar(32) comment 'RFID卡号',
RFIDName varchar(32) not null default '' comment 'RFID卡名',
version int comment '版本',

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间',
oDate timestamp comment '操作时间'
)comment '车辆档案操作数据';


create table t_weight_supplier(
id int auto_increment primary key,
cID varchar(32) not null unique comment '身份证',
userName varchar(16) not null comment '姓名',
sex char(1) comment '性别',
birthday varchar(16) comment '出生日期',
address varchar(64) comment '地址',
phoneNumber varchar(16) comment '联系电话',
version int not null default 1 comment '版本'
)comment '供应商';

create table t_weight_supplier_his(
id int,
cID varchar(32) comment '身份证',
userName varchar(16) comment '姓名',
sex char(1) comment '性别',
birthday varchar(16) comment '出生日期',
address varchar(64) comment '地址',
phoneNumber varchar(16) comment '联系电话',
version int comment '版本',

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '供应商操作数据';

create table t_weight_grain_variety(
id int primary key comment '编号',
parentId int comment '父级编号',
text varchar(32) not null default '' comment '品种名称',
definedText varchar(32) not null default '' comment '自定义名称',
salePrice float not null default 0.0 comment '销售价格',
buyPrice float not null default 0.0 comment '采购价格',
rankPrice float not null default 0.0 comment '等级差价',
isEnable char(1) not null default '1' comment '是否启用：1：不启用，2：启用',
version int not null default 1 
)comment '品种档案';

create table t_weight_grain_variety_his(
id int primary key comment '编号',
parentId int comment '父级编号',
text varchar(32) not null default '' comment '品种名称',
definedText varchar(32) not null default '' comment '自定义名称',
salePrice float not null default 0.0 comment '销售价格',
buyPrice float not null default 0.0 comment '采购价格',
rankPrice float not null default 0.0 comment '等级差价',
isEnable char(1) not null default '1' comment '是否启用：1：不启用，2：启用',
version int not null default 1 ,

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '品种档案操作数据';

create table t_weight_quality_archives(
id int auto_increment primary key,
vId int comment '品种编号',
zjbh char(2) not null comment '检测类型编号',
standard float not null default 0 comment '标准值',
miniValue float not null default 0 comment '最小区间',
maxiValue float not null default 0 comment '最大区间',
rank float not null default 0 comment '等级差',
reduceStandard float not null default 0 comment '扣量标准',
increaseRange float not null default 0 comment '增量幅度',
increaseValue float not null default 0 comment '增量值',
reduceValue float not null default 0 comment '扣量值',
version int not null default 1 
)comment '质量国标档案';

create table t_weight_quality_archives_his(
id int auto_increment primary key,
vId int comment '品种编号',
zjbh char(2) not null comment '检测类型编号',
standard float not null default 0 comment '标准值',
miniValue float not null default 0 comment '最小区间',
maxiValue float not null default 0 comment '最大区间',
rank float not null default 0 comment '等级差',
reduceStandard float not null default 0 comment '扣量标准',
increaseRange float not null default 0 comment '增量幅度',
increaseValue float not null default 0 comment '增量值',
reduceValue float not null default 0 comment '扣量值',
version int not null default 1,

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间' 
)comment '质量国标档案操作数据';

create table t_weight_quality_type(
id char(2) not null primary key comment '编号',
tName varchar(32) comment '名称',
miniValue float not null default 0 comment '最小值',
maxiValue float not null default 0 comment '最大值'
)comment '检测类型';


create table t_weight_hardware_config(
id int auto_increment primary key,
mac varchar(32) not null comment 'MAC地址',
carType varchar(16) comment '硬件类型',
COMNum varchar(16) comment 'COM串口号',
baudRate varchar(16) comment '波特率',
dataBit varchar(16) comment '数据位',
stopBit varchar(16) comment '停止位',
checkBit varchar(16) comment '校验位',
startAddress varchar(16) comment '起始地址',
wordNum varchar(16) comment '字数',
remark varchar(64) comment '备注',
version int not null default 1
)comment '硬件配置';

create table t_weight_hardware_config_his(
id int auto_increment primary key,
mac varchar(32) not null comment 'MAC地址',
carType varchar(16) comment '硬件类型',
COMNum varchar(16) comment 'COM串口号',
baudRate varchar(16) comment '波特率',
dataBit varchar(16) comment '数据位',
stopBit varchar(16) comment '停止位',
checkBit varchar(16) comment '校验位',
startAddress varchar(16) comment '起始地址',
wordNum varchar(16) comment '字数',
remark varchar(64) comment '备注',
version int not null default 1,

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '硬件配置操作数据';


create table t_weight_video_config(
id int auto_increment primary key,
mac varchar(32) not null unique comment 'MAC地址',
ipAddr varchar(16) comment 'IP地址',
ipPort varchar(16) comment 'IP端口号',
userName varchar(16) comment '登录帐号',
password varchar(64) comment '登录密码',
throughPort varchar(16) comment '通道号',
turnWeighing char(1) not null default '1' comment '轮询称重：1，轮询，2：随意称重',
printType char(1) not null default '1' comment '凭证打印：1，逐条打印，2：不逐条打印',
screenshotPath varchar(64) comment '截图路径',
remark varchar(64) comment '备注',
version int not null default 1
)comment '称重视频';

create table t_weight_video_config_his(
id int,
mac varchar(32) not null comment 'MAC地址',
ipAddr varchar(16) comment 'IP地址',
ipPort varchar(16) comment 'IP端口号',
userName varchar(16) comment '登录帐号',
password varchar(64) comment '登录密码',
throughPort varchar(16) comment '通道号',
remark varchar(64) comment '备注',
turnWeighing char(1) not null default '1' comment '轮询称重：1，轮询，2：随意称重',
printType char(1) not null default '1' comment '凭证打印：1，逐条打印，2：不逐条打印',
version int not null default 1,

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '称重视频操作数据';

create table t_weight_speck_config(
id int auto_increment primary key,
mac varchar(32) not null unique comment 'mac地址',
isOpen char(1) not null default '1' comment '是否开启：1，开启、2，关闭',
speechRate int not null default 1 comment '播放速度',
content varchar(128) comment '播放内容',
remark varchar(128) comment '备注',
version int not null default '1'
)comment '语音播报';


create table t_weight_grain_property(
id int primary key comment '编号',
parentId int comment '父级编号',
text varchar(32) not null default '' comment '性质名称',
isEnable char(1) not null default '1' comment '是否启用：1：不启用，2：启用',
version int not null default 1
)comment '粮食性质';


create table t_weight_grain_property_his(
id int comment '编号',
parentId int comment '父级编号',
text varchar(32) not null default '' comment '性质名称',
isEnable char(1) not null default '1' comment '是否启用：1：不启用，2：启用',
version int not null default 1,

execUser int comment '操作者',
execSQL varchar(512) comment '操作语句',
execType varchar(16) comment '操作类型',
execDate timestamp null default CURRENT_TIMESTAMP comment '操作时间'
)comment '粮食性质操作数据';


