<%@ page contentType="text/html; charset=utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String id=request.getParameter("id");
String type=request.getParameter("type");
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
<input type="hidden" id="aaa" value="1">
</body>
	<script type="text/javascript">
	//    Install_InsertReport();
	//		var Installed = Install_Detect();
	//	if ( Installed )	CreateReport("Report");
	 	var type=<%=type%>
	  	var Report = null;
	    if(type=="0"){
	    	Report="steam_normal.grf"
	    }else if(type=="1"){
	    	Report="steam_circle.grf"	
	    }
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	     
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
		var QuerySQL ="SELECT "+
							"s.location, "+
							"reverse(substring_index( reverse(substring_index(s.houseid, ',', 3)), ',', 1)) houseid, "+
							"case s.type when 0 then '常规熏蒸' when 1 then '环流熏蒸' end type, "+
							"s.amount, "+
							"s.names, "+
							"s.medicineType, "+
							"s.water, "+
							"s.methods, "+
							"s.zazhi, "+
							"s.persons, "+
							"s.weather, "+
							"s.times, "+
							"s.timee, "+
							"s.temperature, "+
							"s.way, "+
							"s.houseTemperature, "+
							"s.days, "+
							"s.foodTotle, "+
							"s.spaceTotle, "+
							"s.sumTotal, "+
							"s.foodMedicine, "+
							"s.spaceMedicine, "+
							"s.sumMedicine, "+
							"s.insects_before, "+
							"s.insects_amount_before, "+
							"s.insects_amount_after, "+
							"s.killingPercent, "+
							"s.buildDays, "+
							"s.steamOne, "+
							"s.safetyOne, "+
							"s.recordOne, "+
							"s.`comment`, "+
							"s.timecreate, "+
							"s.lastDate, "+
							"s.thickness, "+
							"s.tamount, "+
							"s.firstAmount, "+
							"s.hours, "+
							"s.firstfillTime, "+
							"s.ftemperature_max, "+
							"s.ftemperature_min, "+
							"s.ftemperature_avg, "+
							"s.firstfillAmount, "+
							"s.lastfillAmount, "+
							"s.lastfillDate, "+
							"s.fillTimes, "+
							"s.fillAmounts, "+
							"s.acturalAmounts, "+
							"s.openDate, "+
							"s.openWay, "+
							"s.openDays, "+
							"c.text "+
							"FROM "+
							"t_storage_record_steam AS s "+
							"INNER JOIN t_codeitem AS c ON s.breed = c.id "+
							"WHERE "+
							"c.codeid = 27 AND s.id="+<%=id%>
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		ReportViewer.Start();
	</script>
</html>
