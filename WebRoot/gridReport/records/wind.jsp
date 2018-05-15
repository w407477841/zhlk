<%@ page contentType="text/html; charset=utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String id=request.getParameter("id");

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
	    var Report = "wind.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	        
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
		var QuerySQL ="SELECT "+
						"w.amount, "+
						"w.purpose, "+
						"w.thick, "+
						"w.devicetype, "+
						"w.deviceP, "+
						"w.nettype, "+
						"w.netPa, "+
						"w.windamount, "+
						"w.deviceamount, "+
						"w.windtype, "+
						"w.windperH, "+
						"w.times, "+
						"w.timee, "+
						"w.timeTotal, "+
						"w.temperatureMax, "+
						"w.temperatureMin, "+
						"w.temperatureAvg, "+
						"w.wetMax, "+
						"w.wetMin, "+
						"w.wetAvg, "+
						"w.ftemperatureMax_b, "+
						"w.ftemperatureMin_b, "+
						"w.ftemperatureAvg_b, "+
						"w.ftemperature_ladderMax_b, "+
						"w.waterMax_b, "+
						"w.waterMin_b, "+
						"w.waterAvg_b, "+
						"w.water_ladderMax_b, "+
						"w.ftemperatureMax_a, "+
						"w.ftemperatureMin_a, "+
						"w.ftemperatureAvg_a, "+
						"w.ftemperature_ladderMax_a, "+
						"w.waterMax_a, "+
						"w.waterMin_a, "+
						"w.waterAvg_a, "+
						"w.water_ladderMax_a, "+
						"w.elecAmount, "+
						"w.elecAmountPerHour, "+
						"w.`comment`, "+
						"w.charge, "+
						"w.operator, "+
						"w.timecreate, "+
						"w.location, "+
						"reverse(substring_index( reverse(substring_index(w.houseid, ',', 3)), ',', 1)) houseid, "+
						"c.text "+
					"FROM t_storage_record_wind AS w "+
					"INNER JOIN t_codeitem AS c ON w.breed = c.id "+
					"WHERE c.codeid = 27 AND w.id="+<%=id%>
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		ReportViewer.Start();
	</script>
</html>
