<%@ page contentType="text/html; charset=utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String id=request.getParameter("id");
String id1=id;
String trunk=request.getParameter("id").substring(0, 14);
System.out.println(id);
System.out.println(trunk);

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
<input type="hidden" id="aaa" value="<%=id%>">
</body>
	<script type="text/javascript">
	//    Install_InsertReport();
	//		var Installed = Install_Detect();
	//	if ( Installed )	CreateReport("Report");
	
	    var Report = "mm.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	        
	    
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
		var QuerySQL = 
				"SELECT      '"+document.getElementById('aaa').value+"' id,     q.Bwsld,     q.CCL,     q.Gwcm,     q.Hl,     q.Pcpf,     q.Rl,     q.Szqw,     q.Smj,     q.Sf,     q.Zz,     q.Zjml,     q.Zfsz,     q.Price,     q.AmountPercent,     q.Level,     q.Rz,     i.Owner,     i.CarID,     i.StorageID,b.name Property "+
				  "FROM     w_quality AS q         LEFT JOIN     w_instorage AS i ON q.id = i.ID LEFT JOIN w_quality_basic AS b ON i.Breed = b.code WHERE "+
				  "q.id = '"+<%=trunk%>+"'";
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL);
		console.log(QuerySQL)
		ReportViewer.Start();
		//alert(document.getElementById('aaa').value)
	</script>
</html>
