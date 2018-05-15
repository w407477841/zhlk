<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-6">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">票据打印</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12" id="printDiv">
		<table border="1" cellpadding="0" cellspacing="0" style="text-align: center;width: 70mm; height:90mm; font-size: 4mm;margin: 0 auto;">
			<tr>
				<td colspan="4" style="height: 10mm; font-size:5mm;">${reportHarborFormMap.userName }</td>
			</tr>
			<tr>
				<td colspan="4" style="height: 40mm;" id="qcimg"><img alt="二维码" src="${ctx }/car/createqrc.shtml?qc=${reportHarborFormMap.bId}" width="160px">
				</td>
			</tr>
			<tr>
				<td colspan="4" style="height: 10mm; font-size: 5mm;">${reportHarborFormMap.bId }</td>
			</tr>
			<tr>
				<td style="width: 15mm; height: 10mm;">收购品种</td>
				<td style="width: 20mm;">${reportHarborFormMap.grainVariety }</td>
				<td style="width: 15mm;">入库仓号</td>
				<td style="width: 20mm;">${reportHarborFormMap.wlName }/${reportHarborFormMap.wName }</td>
			</tr>
			<tr>
				<td style="height: 10mm;">报港时间</td>
				<td>${reportHarborFormMap.addDate }</td>
				<td>车船号</td>
				<td>${reportHarborFormMap.shipId }</td>
			</tr>
			<tr>
				<td style="height: 10mm;">身份证号</td>
				<td colspan="3">${reportHarborFormMap.IDCard }</td>
			</tr>
		</table>
	</div>
	<div id="printContext" style="display: none;">
		<table border="1" cellpadding="0" cellspacing="0" style="text-align: center;width: 70mm; height:90mm; font-size: 4mm;margin: 0 auto;">
			<tr>
				<td colspan="4" style="height: 10mm; font-size:6mm;">${reportHarborFormMap.userName }</td>
			</tr>
			<tr>
				<td colspan="4" style="height: 40mm;" id="qcimg">
				</td>
			</tr>
			<tr>
				<td colspan="4" style="height: 10mm; font-size: 6mm;">${reportHarborFormMap.bId }</td>
			</tr>
			<tr>
				<td style="width: 15mm; height: 10mm;">收购品种</td>
				<td style="width: 20mm;">${reportHarborFormMap.grainVariety }</td>
				<td style="width: 15mm;">入库仓号</td>
				<td style="width: 20mm;">${reportHarborFormMap.wlName }/${reportHarborFormMap.wName }</td>
			</tr>
			<tr>
				<td style="height: 10mm;">报港时间</td>
				<td>${reportHarborFormMap.addDate }</td>
				<td>车船号</td>
				<td>${reportHarborFormMap.shipId }</td>
			</tr>
			<tr>
				<td style="height: 10mm;">身份证号</td>
				<td colspan="3">${reportHarborFormMap.IDCard }</td>
			</tr>
		</table>
	</div>
	<div class="form-group col-md-12" style="margin-top: 10px;">
		<button type="button" class="btn btn-info bt-submit" onclick="javascript:myAddHtml();LODOP.PREVIEW();">打印</button>
	</div>
<script language="javascript" src="${ctx}/js/LodopFuncs.js"></script>
	<script type="text/javascript">
	function myAddHtml() {    
		LODOP=getLodop();         
   		LODOP.PRINT_INIT("asdas");	

		LODOP.SET_PRINT_PAGESIZE(1,800,1200,''); 

        LODOP.ADD_PRINT_HTM("10mm","3mm","100%","100%",$("#printContext").html());	

	    LODOP.ADD_PRINT_BARCODE('25mm','20mm','40mm','40mm',"QRCode","${reportHarborFormMap.bId }");
	};	       
</script>
</body>
</html>
