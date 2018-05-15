DROP VIEW IF EXISTS `v_warehouse`;
CREATE 
VIEW `v_warehouse`AS 
SELECT
t_warehouse_location.wNo AS wlNo,
t_warehouse.id,
t_warehouse.wNo,
t_warehouse.wName,
t_warehouse.wHeight,
t_warehouse.wColumn,
t_warehouse.wRow,
t_warehouse.wLocation,
t_warehouse.wStatus,
t_warehouse.wDisable
FROM
t_warehouse
INNER JOIN t_warehouse_location ON t_warehouse.wLocation = t_warehouse_location.id ; ;

DROP VIEW IF EXISTS `v_warehouse_info`;
CREATE VIEW `v_warehouse_info`AS 
SELECT
t_warehouse_info.id,
t_warehouse_info.wDate,
t_warehouse_info.wTime,
t_warehouse_info.wTemperature,
t_warehouse_info.gTemperature,
t_warehouse_info.wHumidity,
t_warehouse_info.gHumidity,
t_warehouse_info.wCoordinate,
t_warehouse_info.wDisable,
t_warehouse_info.wWarehouse,
t_warehouse_location.wNo AS wlNo,
t_warehouse.wNo,
t_warehouse.wName,
t_warehouse_info.cjsj
FROM
t_warehouse_location
INNER JOIN t_warehouse ON t_warehouse.wLocation = t_warehouse_location.id
INNER JOIN t_warehouse_info ON t_warehouse_info.wWarehouse = t_warehouse.id ;