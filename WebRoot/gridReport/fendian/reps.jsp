<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Map" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String param=new String(request.getParameter("key").getBytes("ISO-8859-1"),"UTF-8");
System.out.println(param);

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
	    var Report = "reps14119.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
	    
	var param=JSON.parse('<%=param%>')
	var sql_m="	";
	
	if(!!param["StorageFormMap.location"]&&!!!param["station"]){
		sql_m+=" and	l.location_no in ("+param["StorageFormMap.location"]+") ";
	}if(!!param["station"]){
		sql_m+=" and	l.location_no in ("+param.station+") ";
	}if(param["StorageFormMap.breed"]!=""){
		sql_m+=" and	n.breed='"+param["StorageFormMap.breed"]+"' ";
	} if(param["StorageFormMap.property"]!=""){
		sql_m+=" and	n.property='"+param["StorageFormMap.property"]+"' ";
	}
	
	var QuerySQL ="select * from(SELECT	"+
					"l.qiyemingcheng location,	"+
					"lo.wName position,	"+
					"w.wName houseid,	"+
					"n.breed,	"+
					"n.quanZhong,"+
					"ifnull(ww.weight,0) weight,"+
					"CASE WHEN (n.quanZhong='123' and n.value='113') THEN ww.weight ELSE '' END '县稻谷',	"+
					"CASE WHEN (n.quanZhong='123' and n.value='113') THEN n.sdPrice ELSE '' END '县稻谷单价',	"+
					"CASE WHEN (n.quanZhong='123' and n.value='113') THEN n.sdPrice * ww.weight ELSE '' END '县稻谷金额',	"+
				
				
					"CASE WHEN (n.quanZhong='2' and n.value='113') THEN ww.weight ELSE '' END '非县稻谷',	"+
					"CASE WHEN (n.quanZhong='2' and n.value='113') THEN n.sdPrice ELSE '' END '非县稻谷单价',	"+
					"CASE WHEN (n.quanZhong='2' and n.value='113') THEN n.sdPrice * ww.weight ELSE '' END '非县稻谷金额',	"+
				
				
					"CASE WHEN (n.quanZhong='123' and  n.value='111') THEN ww.weight ELSE '' END '县小麦',	"+
					"CASE WHEN (n.quanZhong='123' and n.value='111') THEN n.sdPrice ELSE '' END '县小麦单价',	"+
					"CASE WHEN (n.quanZhong='123' and n.value='111') THEN n.sdPrice * ww.weight ELSE '' END '县小麦金额',	"+
				
					"CASE WHEN (n.quanZhong='2' and n.value='111') THEN ww.weight ELSE '' END '非县小麦',	"+
					"CASE WHEN (n.quanZhong='2' and n.value='111') THEN n.sdPrice ELSE '' END '非县小麦单价',	"+
					"CASE WHEN (n.quanZhong='2' and n.value='111') THEN n.sdPrice * ww.weight ELSE '' END '非县小麦金额'	"+
				"FROM	"+
					"t_contrast_location l	"+
				"LEFT JOIN t_warehouse_location lo ON l.location_no = lo.wNo	"+
				"LEFT JOIN t_warehouse w ON w.wLocation = lo.wNo	"+
				"left JOIN (	"+
				"	SELECT	"+
					"	v.source,	"+
					"	v.storageID,	"+
				"		v.text breed,	"+
					"	v.quanZhong,	"+
				"		c1.text property,	"+
				"		v. NAME,	"+
				"		substr(v.name,1,3) VALUE ,	"+
				"		v.sdPrice	"+
				"	FROM	"+
				"		("+
				"			SELECT	"+
				"				c.text,"+
					"			f. NAME,"+
				"				f.storageID,"+
				"				f.source,"+
				"				d.sdYear,"+
				"				d.sdPrice,"+
				"				concat(d.sdMoisture, '%') sdMoisture,	"+
				"				f.quanZhong	"+
				"			FROM	"+
				"				t_storag_info f	"+
				"			LEFT JOIN t_storage_detail d ON f.id = d.storage_id	"+
				"			LEFT JOIN t_codeitem c ON f. NAME = c.id	"+
				"			AND (c.codeid = 12)	"+
				"			GROUP BY	"+
				"				f.storageID,	"+
				"				f.source	"+
				"		) v	"+
				"	LEFT JOIN t_codeitem c1 ON v.quanZhong = c1.id	"+
				"	AND c1.codeid = 11"+
				") n ON lo.wNo = n.source	"+
				"AND w.id = n.storageID	"+
				"left JOIN (	"+
				"	SELECT	"+
				"		cangKu weight,	"+
				"		source location,	"+
				"		storageid storageID	"+
				"	FROM"+
				"		t_storag_info	"+
				") ww ON lo.wNo = ww.location	"+
				"AND ww.storageid = w.id	"+
				"WHERE	"+
				"	1 = 1"+sql_m+"	order by 	l.qiyemingcheng ,lo.wNo,w.id) v where v.weight!=0 and v.quanZhong in ('123', '2')  and v.location!='岔河'"
	
		
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		ReportViewer.Start();
		//alert(document.getElementById('aaa').value)
	</script>
</html>
