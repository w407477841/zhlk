alter TABLE t_weight_report_harbor add COLUMN reportDate varchar(32) comment '报港时间';
alter TABLE t_weight_report_harbor_his add COLUMN reportDate varchar(32) comment '报港时间';

alter TABLE t_weight_report_harbor MODIFY COLUMN addDate varchar(32) comment '添加时间';
alter TABLE t_weight_report_harbor_his MODIFY COLUMN addDate varchar(32) comment '添加时间';