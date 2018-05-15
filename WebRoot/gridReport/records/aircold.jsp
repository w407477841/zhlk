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
	    var Report = "aircold.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	        
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
		var QuerySQL ="SELECT "+
							"a.location, "+
							"reverse(substring_index( reverse(substring_index(a.houseid, ',', 3)), ',', 1)) houseid, "+
							"c.text, "+
							"a.devicetype, "+
							"a.amount, "+
							"a.deviceAmount, "+
							"a.thick, "+
							"a.height, "+
							"a.devicePower, "+
							"a.totlePower, "+
							"a.times, "+
							"a.timee, "+
							"a.timeTotal*24 timeTotal, "+
							"a.temperatureMax, "+
							"a.temperatureMin, "+
							"a.temperatureAvg, "+
							"a.wetMax, "+
							"a.wetMin, "+
							"a.wetAvg, "+
							"a.ftemperatureMax_b, "+
							"a.ftemperatureMin_b, "+
							"a.ftemperatureAvg_b, "+
							"a.ftemperature_ladderMax_b, "+
							"a.ftemperatureMax_a, "+
							"a.ftemperatureMin_a, "+
							"a.ftemperatureAvg_a, "+
							"a.ftemperature_ladderMax_a, "+
							"a.elecAmount, "+
							"a.elecAmountPerHour, "+
							"a.`comment`, "+
							"a.charge, "+
							"a.operator, "+
							"a.timecreate "+
							"FROM "+
							"t_storage_record_aircold AS a "+
							"INNER JOIN t_codeitem AS c ON a.breed = c.id "+
							"WHERE "+
							"c.codeid = 27 and a.id="+<%=id%>
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		ReportViewer.Start();
	</script>
</html>
