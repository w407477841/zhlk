/*修改人员档案*/
alter table t_person_archives MODIFY paSex char(2);
alter table t_person_archives MODIFY paEmail varchar(64);
alter table t_person_archives MODIFY paOfficePhone varchar(16);
alter table t_person_archives MODIFY paNation varchar(32);
alter table t_person_archives MODIFY paQQ varchar(12);
alter table t_person_archives MODIFY paDegree varchar(32);
alter table t_person_archives MODIFY paHealth varchar(32);
alter table t_person_archives MODIFY paWorkLicence varchar(32);
alter table t_person_archives MODIFY paDepartment varchar(32);
alter table t_person_archives MODIFY paDuty varchar(32);
alter table t_person_archives MODIFY paEmail varchar(64);

alter table t_person_archives_his MODIFY paSex char(2);
alter table t_person_archives_his MODIFY paEmail varchar(64);
alter table t_person_archives_his MODIFY paOfficePhone varchar(16);
alter table t_person_archives_his MODIFY paNation varchar(32);
alter table t_person_archives_his MODIFY paQQ varchar(12);
alter table t_person_archives_his MODIFY paDegree varchar(32);
alter table t_person_archives_his MODIFY paHealth varchar(32);
alter table t_person_archives_his MODIFY paWorkLicence varchar(32);
alter table t_person_archives_his MODIFY paDepartment varchar(32);
alter table t_person_archives_his MODIFY paDuty varchar(32);
alter table t_person_archives_his MODIFY paEmail varchar(64);
alter table t_person_archives_his MODIFY pahSQL text;
alter table t_person_archives_his MODIFY pahType varchar(32);
alter table t_person_archives_his MODIFY version int;