SELECT
	l.qiyemingcheng location,
	lo.wName position,
	w.wName houseid,
	n.breed,
	CASE n. NAME
WHEN '1132002' THEN
	ww.weight
ELSE
	''
END '稻谷',
 CASE n. NAME
WHEN '1132002' THEN
	n.sdPrice
ELSE
	''
END '稻谷单价',
 CASE n. NAME
WHEN '1132002' THEN
	n.sdPrice * ww.weight
ELSE
	''
END '稻谷金额',
 CASE n. NAME
WHEN '1114' THEN
	ww.weight
ELSE
	''
END '小麦',
 CASE n. NAME
WHEN '1114' THEN
	n.sdPrice
ELSE
	''
END '小麦单价',
 CASE n. NAME
WHEN '1114' THEN
	ww.weight * n.sdPrice
ELSE
	''
END '小麦金额',
 n.property,
 n.sdPrice,
 n. NAME,
 ww.weight
FROM
	t_contrast_location l
LEFT JOIN t_warehouse_location lo ON l.location_no = lo.wNo
LEFT JOIN t_warehouse w ON w.wLocation = lo.wNo
LEFT JOIN (
	SELECT
		v.source,
		v.storageID,
		v.text breed,
		c1.text property,
		v. NAME,
		v.sdPrice
	FROM
		(
			SELECT
				c.text,
				f. NAME,
				f.storageID,
				f.source,
				d.sdYear,
				d.sdPrice,
				concat(d.sdMoisture, '%') sdMoisture,
				f.quanZhong
			FROM
				t_storag_info f
			LEFT JOIN t_storage_detail d ON f.id = d.storage_id
			LEFT JOIN t_codeitem c ON f. NAME = c.id
			AND (c.codeid = 27)
			GROUP BY
				f.storageID,
				f.source
		) v
	LEFT JOIN t_codeitem c1 ON v.quanZhong = c1.id
	AND c1.codeid = 11
) n ON lo.wNo = n.source
AND w.id = n.storageID
LEFT JOIN (
	SELECT
		i.id,
		i.location,
		i.storageID,
		sum(w.TotalWeight - w.CarWeight) weight
	FROM
		w_instorage i
	LEFT JOIN w_weighting w ON i.ID = LEFT (w.id, 14)
	GROUP BY
		i.id
) ww ON lo.wNo = ww.location
AND ww.storageid = concat(w.id, ',', w.wName)
WHERE
	1 = 1