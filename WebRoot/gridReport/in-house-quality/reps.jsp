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
	    var Report = "reps101.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
	
	var sql_m="	";
	
	    
	var param=JSON.parse('<%=param%>')
	
	if(param["InstanceMsgFormMap.stime"]!=""&&param["InstanceMsgFormMap.etime"]!=""){
		sql_m+="  and    q.dates  between   '"+param["InstanceMsgFormMap.stime"]+"' and '"+param["InstanceMsgFormMap.etime"]+"' ";
		
	} if(param["InstanceMsgFormMap.location"]!=""){
		sql_m+=" and	i.wNo='"+param["InstanceMsgFormMap.location"]+"' ";
	}  if(param["InstanceMsgFormMap.houseid"]!=""){
		sql_m+=" and	q.houseid='"+param["InstanceMsgFormMap.houseid"]+"' ";
	}
	    
		var QuerySQL ="SELECT	"+
							"q.dates,	"+
							"i.wName,	"+
							"substring_index(q.houseid, ',', - 1) houseid,	q.dates,	"+
							"c.text breed,	"+
							"q.amounts,	"+
							"q.bornDate,	"+
							"q.property,	"+
							"q.`comment`,	"+
							"y.`Level`,	"+
							"y.Sf,	"+
							"y.Zz,	"+
							"y.CCL,	"+
							"y.Rz,	"+
							"y.Bwsld,	"+
							"y.Hl,	"+
							"y.Gwcm,	"+
							"y.Zjml	"+
						"FROM	"+
							"t_qualitychain_instance_quality AS q	"+
						"LEFT JOIN w_quality y ON q.qualityid = y.id	"+
						"LEFT JOIN t_warehouse_location i ON q.location = i.wNo	"+
						"left join t_codeitem c on c.codeid=27 and c.id=q.breed where q.inorout=0 " +sql_m
		
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		ReportViewer.Start();
		//alert(document.getElementById('aaa').value)
	</script>
</html>
