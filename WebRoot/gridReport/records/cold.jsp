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
	    var Report = "cold.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	        
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
		var QuerySQL ="SELECT "+
						"c.location,"+
						"c.`level`,"+
						"c.water,"+
						"c.zazhi,"+
						"c.amount,"+
						"c.houseType,"+
						"c.length,"+
						"c.thick,"+
						"c.volume,"+
						"c.type,"+
						"c.strength,"+
						"c.windAmount,"+
						"c.mType,"+
						"c.mAmount,"+
						"c.power,"+
						"c.windPerVolume,"+
						"c.purpose,"+
						"c.times,"+
						"c.timee,"+
						"c.timeLasts*24 timeLasts, "+
						"c.temperature_1,"+
						"c.wet_1,"+
						"c.ftemperature_b_1,"+
						"c.ftemperature_a_1,"+
						"c.water_b_1,"+
						"c.water_a_1,"+
						"c.thickness_1,"+
						"c.water_1,"+
						"c.temperature_2,"+
						"c.wet_2,"+
						"c.ftemperature_b_2,"+
						"c.ftemperature_a_2,"+
						"c.water_b_2,"+
						"c.water_a_2,"+
						"c.thickness_2,"+
						"c.water_2,"+
						"c.temperature_3,"+
						"c.wet_3,"+
						"c.ftemperature_b_3,"+
						"c.ftemperature_a_3,"+
						"c.water_b_3,"+
						"c.water_a_3,"+
						"c.thickness_3,"+
						"c.water_3,"+
						"c.windTemperature,"+
						"c.wetTemperature,"+
						"c.capacity,"+
						"c.elecAmount,"+
						"c.elecAmountPerHour,"+
						"c.`comment`,"+
						"c.chargeOne,"+
						"c.recordOne,"+
						"c.timecreate,"+
						"i.text,"+
						"reverse(substring_index( reverse(substring_index(c.houseid, ',', 3)), ',', 1)) houseid "+
						"FROM "+
						"t_storage_record_cold AS c "+
						"left JOIN t_codeitem AS i ON c.breed = i.id "+
						"WHERE "+
						"i.codeid = 27 and  c.id="+<%=id%>
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		ReportViewer.Start();
	</script>
</html>
