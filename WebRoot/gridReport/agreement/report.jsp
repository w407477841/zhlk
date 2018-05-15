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
	
	    var Report = "agreement.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	        
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
		var QuerySQL ="SELECT"+
					"	a.agreementID,"+
					"	a.soldOnes,"+
					"	a.buyOnes,"+
					"	a.signTime,"+
					"	a.signPlace,"+
					"	c.text,"+
					"	a.amounts,"+
					"	a.LEVEL,"+
					"	a.price,"+
					"   a.price*a.amounts/10000 totalLower,"+
					"	a.price*a.amounts totalUpper"+
					"   FROM "+
					"	t_business_agreement a left join t_codeitem c on a.breed=c.id WHERE c.codeid='27' and a.id="+<%=id%>
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		console.log(QuerySQL)
		ReportViewer.Start();
		//alert(document.getElementById('aaa').value)
	</script>
</html>
