<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Map" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String param=new String(request.getParameter("key").getBytes("ISO-8859-1"),"UTF-8");
System.out.println(param);
Map map=(Map)session.getAttribute("userSession");
String operator=map.get("userName").toString();

 %>
<head>
	<title>报表</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<script src="../CreateControl.js" type="text/javascript"></script>
	<script src="../GRInstall.js" type="text/javascript"></script>
    <style type="text/css">
        html,body {
            margin:0;
            height:100%;
        }
    </style>
</head>
<body style="margin:0">
</body>
	<script type="text/javascript">
	    var Report = "reps46108.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
	
	
	var sql_t="	";
	var sql_t1=""
	var  sql_sjsj="";
	var sql_m="	",sql_m1="	";
	var useDate="";
	
	    
	var param=JSON.parse('<%=param%>')
	var userName='<%=operator%>'
	if(param["StorageFormMap.times"]!=""){
		sql_t+="  where i.createTime between '1970-01-01' and  '"+param["StorageFormMap.times"]+"'"
		sql_t1+="  where  i.dates between '1970-01-01' and  '"+param["StorageFormMap.times"]+"'"
		sql_sjsj+="  where cjsj   between '1970-01-01' and  '"+param["StorageFormMap.times"]+"'"
		useDate=param["StorageFormMap.times"];
		
		
	} if(!!param["StorageFormMap.breed"]){
		sql_m+=" and	n.breed='"+param["StorageFormMap.breed"]+"' ";
		sql_m1+=" and	v.name='"+param["StorageFormMap.breed"]+"' ";
	} if(!!param["StorageFormMap.location"]&&!!!param["station"]){
		sql_m+=" and	l.wNo in ("+param["StorageFormMap.location"]+") ";
		sql_m1+=" and	v.wNo in ("+param["StorageFormMap.location"]+") ";
	} if(!!param["StorageFormMap.location"]&&!!param["station"]){
		sql_m+=" and	l.wNo in ("+param["station"]+") ";
		sql_m1+=" and	v.wNo in ("+param["station"]+") ";
	} if(param["StorageFormMap.pack"]!=""){
		sql_m+=" and	n.pack='"+param["StorageFormMap.pack"]+"' ";
	} if(param["StorageFormMap.property"]!=""){
		sql_m+=" and	n.property='"+param["StorageFormMap.property"]+"' ";
		sql_m1+=" and	v.property='"+param["StorageFormMap.property"]+"' ";
	}
	    
		var QuerySQL ="select * from(select locationName ,lName,houseName,breed,sdYear,pack,maxTemperature,minTemperature,sdPrice,property,sdMoisture,useDate,userName,weight,amounts "+
							",'0.00' aName, '0.00' bName, '0.00' cName,'0.00' dName,'0.00' eName,'0.00' fName,'0.00' gName,'0.00' hName,'0.00' iName,'0.00' jName,'0.00' kName "+ 
							"from(SELECT  "+
					   	    "l.wName locationName,  '"+
					   	    param['StorageFormMap.title']+"' lName,   "+
							"w.wName houseName,  "+
							"n.breed breed,  "+
							"n.sdYear,  "+
							"n.pack,  "+
							"tem.maxTemperature,  "+
							"tem.minTemperature,  "+
							"ifnull(n.sdPrice,0)sdPrice , "+
							"n.property,  "+
							"n.sdMoisture sdMoisture,  "+
							"'"+useDate+"'  useDate,  "+
							"'"+userName+"'  userName,  "+
							"ifnull(sum(m.weight),0) -  "+
							"ifnull((  "+
							"	SELECT  "+
							"		ifnull(siQuantity, 0)  "+
							"	FROM  "+
							"		`t_store_info`  "+
							"	WHERE  "+
							"		location_id = w.wLocation  "+
							"	AND warehouse_id = w.id  "+
							"	ORDER BY  "+
							"		siPutin DESC  "+
							"	LIMIT 1  "+
							"),0)*-1 weight, "+
							"(ifnull(sum(m.weight), 0) - ifnull(  "+
							"	("+
							"		SELECT  "+
							"			ifnull(siQuantity, 0)  "+
							"		FROM  "+
							"			`t_store_info`  "+
							"		WHERE  "+
							"			location_id = w.wLocation  "+
							"		AND warehouse_id = w.id  "+
							"		ORDER BY  "+
							"			siPutin DESC  "+
							"		LIMIT 1  "+
							"	),0) *- 1)*ifnull(n.sdPrice, 0) amounts  "+
						"FROM  "+
							"t_warehouse_location AS l  "+
						"LEFT JOIN t_warehouse AS w ON w.wLocation = l.id  "+
						"LEFT JOIN (  "+
							"SELECT  "+
								"i.id,  "+
								"i.location,  "+
								"i.storageID,  "+
								"sum(w.TotalWeight - w.CarWeight) weight  "+
							"FROM  "+
								"w_instorage i  "+
							"LEFT JOIN w_weighting w ON i.ID = LEFT (w.id, 14)  "+ sql_t+
							"GROUP BY i.id  "+
						") m ON concat(l.wNo, ',', w.id, ',', w.wName) = concat(m.location, ',', m.storageID)  "+
						"LEFT JOIN (  "+
				"	select c1.text breed,l.storageid,l.source,ifnull(l.sdMoisture,'--') sdMoisture,ifnull(l.sdYear,'--') sdYear,ifnull(c.text,'--')  property,ifnull(d.sdPrice, '--') sdPrice,  "+
						"CASE d.sdPack  "+
						"	WHEN '1' THEN '散装'  "+
						"	WHEN '2' THEN '亚麻布包装'  "+
						"	WHEN '3' THEN '塑料袋包装'  "+
						"	WHEN '4' THEN '铁盒包装'  "+
						"	ELSE '散装' END pack from (select l.breed text,substring_index(l.houseid, ',' ,1) storageid,l.location source , concat(l.sf,'%') sdMoisture,l.bornDate sdYear  "+
				"	from (select i.breed,i.location,i.houseid,i.bornDate,i.dates,c.text level,q.sf  "+
						"			from t_qualitychain_instance_quality i  "+
						"		   left join w_quality q on i.qualityid=q.id  "+
				        "   left join t_codeitem c on c.codeid=10 and c.id=q.level  "+sql_t1+
				        "     order by dates desc) l group by l.houseid  "+
				"union all  "+
						"SELECT  "+
						"		c.text,f.storageID,f.source,concat(d.sdMoisture, '%') sdMoisture,d.sdYear  "+
						"		FROM t_storag_info f  "+
						"	LEFT JOIN t_storage_detail d ON f.id = d.storage_id  "+
						"	LEFT JOIN t_codeitem c ON f. NAME = c.id  "+
						"	AND (c.codeid = 12)  "+
						"	GROUP BY  "+
						"		f.storageID,  "+
						"		f.source) l  "+
					"left join t_storag_info f  on  f.source=l.source and f.storageid=l.storageid  "+
					"left join t_storage_detail d on f.id=d.storage_id  "+
					"left join t_codeitem c on c.codeid=11 and c.id=f.quanZhong left join t_codeitem c1 on c1.codeid=12 and c1.id=f.name  "+
				" group by l.source,l.storageid  "+
							") n ON concat(l.wNo, w.id) = concat(n.source, n.storageID)  "+
							"left join (select * from (SELECT maxTemperature,minTemperature,cjsj,wWarehouse houseid   "+
							" FROM t_warehouse_info"+sql_sjsj+
							"   order by cjsj desc) tem  group by tem.houseid) tem  "+
							"  on tem.houseid=w.id  "+
						"WHERE	1 = 1 "+sql_m+"   GROUP by w.id ) v where v.weight!=0 "+
						  "union   "+
				"select * from(select null a,null b,null c,null d,null e,null f,null g,null h,null i,null j,null k,null l,null m,null n,null o, sum(q1) aName ,sum(q2) bName ,sum(q3),sum(q4) ,sum(q5) ,sum(q6) ,sum(q7) ,sum(q8) ,sum(q9) ,sum(q10),sum(q11)  from (select  "+ 
					"'1' g,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='11,111' then   sum(v.weight) else 0 end q1,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='11,112' then  sum(v.weight) else 0 end q2,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='11,113' then  sum(v.weight)  else 0 end q3,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='31,111' then  sum(v.weight) else 0 end q4,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='31,113' then  sum(v.weight) else 0 end q5,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='122,113' then  sum(v.weight) else 0 end q6,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='122,111' then  sum(v.weight) else 0 end q11,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='123,111' then  sum(v.weight) else 0 end q7,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='123,113' then  sum(v.weight) else 0 end q8,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='2,111' then  sum(v.weight) else 0 end q9,  "+
				"case  when concat(v.quanZhong ,',',v.breed)='2,113' then  sum(v.weight) else 0 end q10,  "+
				"concat(v.quanZhong ,',',v.breed) type,sum(v.weight) weight from (SELECT  "+
				"	l.wNo,l.wName location,w.id,w.wName houseid,v.weight,f.name,f.quanZhong,  "+
				"  case when substr(f.name,1,3)='111' then '111'  "+
				"	   	 when  substr(f.name,1,3)='112' then '112'   "+
				"			 else '113' end breed,  "+
				"  (select text from t_codeitem where  codeid=11 and id=f.quanZhong) property  "+
				"FROM  "+
				"	t_warehouse_location l  "+
				"LEFT JOIN t_warehouse w ON l.id = w.wLocation  "+
				"left join  (select location ,houseid,sum(weight) weight from (  "+
				"SELECT  "+
				"	i.location,  "+
				"	substring_index(i.storageid, ',', 1) houseid,  "+
				"	ifnull(sum(w.TotalWeight - w.CarWeight),0) weight  "+
				"FROM  "+
				"	w_instorage i  "+
				"LEFT JOIN w_weighting w ON i.ID = LEFT (w.id, 14)  "+
				"GROUP BY  "+
				"	i.location,  "+
				"	i.storageid union all  "+
				"select v.location_id location ,v.warehouse_id houseid,v.weight from(SELECT  "+
				"	siPutin,  "+
				"	location_id,  "+
				"	warehouse_id,  "+
				"	ifnull(siQuantity, 0) weight  "+
				"FROM  "+
				"	`t_store_info`   "+
				"ORDER BY  "+
				"	location_id,warehouse_id,siPutin DESC )v  group by v.location_id,v.warehouse_id) v group by v.location ,v.houseid) v  "+
				"on v.location=l.wNo and v.houseid=w.id  "+
				"left join t_storag_info f on l.wNo=f.source and w.id=f.storageid  ) v  where v.quanZhong in (11,31,122,123,2)  "+sql_m1+ 
				" group by v.property,v.breed) v group by g )v )v" 
						 
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		ReportViewer.Start();
	</script>
</html>
