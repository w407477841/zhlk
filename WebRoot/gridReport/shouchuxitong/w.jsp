<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String id=request.getParameter("id");
System.out.println(id);

 %>
<head>
	<title>报表</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<script src="../CreateControl.js" type="text/javascript"></script>
	<script src="../GRInstall.js" type="text/javascript"></script>
    <style type="text/css">
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
	
	    var Report = "_weighting.grf";
	    if (Report == "null")
			Report = "";
	    else if (Report != "")
	        Report = "" + Report;
	        
	    CreatePrintViewerEx("100%", "100%", Report, "", false, "");
				  
		var QuerySQL="SELECT "+
					    "i.id,"+
					    "i.owner,"+
					    "i.CarID,"+
					    "i.Identity,"+
					    "i.Address,"+
					    "i.StorageID,"+
					    "(CASE i.inorout WHEN 1 THEN '入库'ELSE '出库' END) inorout,"+
					    "b.name,"+
					    "q.Rz,"+
					    "q.Bwsld,"+
					    "q.CCL,"+
					    "q.Gwcm,"+
					    "q.Hl,"+
					    "q.Pcpf,"+
					    "q.Rl,"+
					    "q.Szqw,"+
					    "q.Smj,"+
					    "q.Sf,"+
					   	"q.Zz,"+
					    "q.Zjml,"+
					    "q.Zfsz,"+
					    "q.Kwz,"+
					    "q.Hh,"+
					    "q.level,"+
					    "q.AmountPercent,"+
					    "(abs(w.TotalWeight) - abs(w.CarWeight)) * q.AmountPercent weightPercent,"+
					    "q.Price,"+
					    "ifnull(q.zjy,'') zjy,"+
						"ifnull(i.jsy,'') jsy,"+
						"ifnull(w.sby,'') sby, "+
					    "abs(w.TotalWeight) TotalWeight,"+
					    "abs(w.CarWeight) CarWeight,"+
					    "w.count,"+
					    "((abs(w.TotalWeight)-abs(w.CarWeight))*q.Price*0.01*(1-truncate(q.AmountPercent * 0.01,5))) payment,"+
					    "((abs(w.TotalWeight)-abs(w.CarWeight))*q.Price*0.01*(1-truncate(q.AmountPercent * 0.01,5))) upperPayment "+
					"FROM	"+
					    "w_instorage i	"+
					        "LEFT JOIN	"+
					    "(SELECT LEFT(w.id, 14) id,SUM(TotalWeight) TotalWeight, SUM(w.CarWeight) CarWeight,COUNT(*) count,sby	"+
					    		"FROM w_weighting w GROUP BY LEFT(w.id, 14)) w ON i.id = w.id	"+
					        "LEFT JOIN	"+
					    "w_quality_basic b ON i.Breed = b.Code	"+
					        "LEFT JOIN	"+
					    "w_quality q ON i.id = q.id	"+
					"WHERE i.id = '"+<%=id%>+"'";
		ReportViewer.DataURL = encodeURI("../xml.jsp?QuerySQL=" + QuerySQL+"&name=入库");
		
		ReportViewer.Start();
		//alert(document.getElementById('aaa').value)
	</script>
</html>
