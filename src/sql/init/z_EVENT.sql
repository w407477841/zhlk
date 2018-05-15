DROP EVENT IF EXISTS `call_sp_autoupdate_storageInfo`;
CREATE 
EVENT `call_sp_autoupdate_storageInfo`
ON SCHEDULE EVERY 3 MINUTE STARTS '2017-03-09 09:00:00'
ON COMPLETION NOT PRESERVE
ENABLE
COMMENT 'w_weighting de 数据同步到 storageInfo'
DO
call  sp_autoupdate_storageInfo;