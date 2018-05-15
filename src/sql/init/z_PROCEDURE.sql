DROP PROCEDURE IF EXISTS `sp_autoupdate_storageInfo`;

CREATE PROCEDURE `sp_autoupdate_storageInfo`()
BEGIN
declare ifexist int;
DECLARE done INT DEFAULT 0;
declare location VARCHAR(50);
declare houseid VARCHAR(50); 
declare breed varchar(10);
declare property varchar(10);
declare weights int ;
declare initAmount int ;

declare _cur CURSOR for select v.breed,v.property,v.source,v.storageid,sum(v.weights) weights from(SELECT
	v.siCategory breed,
  v.siVariety property,
	v.location_id source,
	v.warehouse_id storageid,
	v.siQuantity weights
FROM
	(SELECT location_id,warehouse_id,siPutin,siQuantity,siCategory, siNature siVariety FROM `t_store_info` ORDER BY siPutin DESC ,id DESC) v
GROUP BY v.location_id, v.warehouse_id
union all
SELECT i.breed,i.property,i.location source, substring_index(i.storageid, ',', 1) storageID,ifnull(sum(w.TotalWeight)-sum(w.CarWeight),0)	weights FROM	w_instorage i	LEFT JOIN w_weighting w ON i.id = LEFT (w.id, 14)	GROUP BY	i.location,i.StorageID)v
group by  v.source,v.storageid;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;  
OPEN _cur;
	FETCH _cur into breed,property,location,houseid,weights;

	while done!=1 do
 select count(*) into @ifexist  from t_storag_info where source=location and storageID=houseid;
 -- select 	case when count(siQuantity)=0 then 0 else siQuantity  end siQuantity into initAmount   FROM `t_store_info` WHERE location_id = location AND warehouse_id = houseid ORDER BY siPutin DESC LIMIT 1;
	
	 	if @ifexist=0 then 
 	insert into `t_storag_info` (`name`, `quanZhong`,`source`, `cangKu`, `storageID`) VALUES (breed,property,location, weights,houseid );
	
	 	else 
	 update t_storag_info set cangKu=weights,name=breed,quanZhong=property where source=location and storageID=houseid;

	 end if;

	FETCH _cur into breed,property, location ,houseid,weights;

	end while ;

-- INSERT INTO `t_storag_info` (`name`, `code`, `quanZhong`, `cangKu`, `storageID`) VALUES ('1', '1', '1', '1', '1');
CLOSE _cur; 


END
