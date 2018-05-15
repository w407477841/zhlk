<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/common/common.jspf"%>
	 <style type="text/css">
	 .chosen-container-single .chosen-single{
	 height:37px;
	 }
	 
	 </style>
</head>
<body style="background-color:#d9edf7">
<div id="errorDiv" class="col-md-12">
</div>
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">车辆二维码</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12">
	   <table border="1" cellpadding="0" cellspacing="0" style="text-align: center;width: 70mm; height:90mm; font-size: 4mm;margin: 0 auto;">
			<tr>
				<td colspan="4" style="height: 40mm;" id="qcimg"><img alt="二维码" src="${ctx }/car/createqrc.shtml?qc=${carFormMap.RFID}">
				</td>
			</tr>
			<tr>
				<td colspan="4" style="height: 10mm; font-size: 5mm;">${carFormMap.bId }</td>
			</tr>
			<tr>
				<td style="width: 25mm; height: 10mm;">司机姓名</td>
				<td style="width: 35mm;">${carFormMap.driver }</td>
			</tr>
			<tr>
				<td style="width: 25mm; height: 10mm;">车牌号</td>
				<td style="width: 35mm;">${carFormMap.cId }</td>
			</tr>
			<tr>
				<td style="width: 25mm; height: 10mm;">联系电话</td>
				<td style="width: 35mm;">${carFormMap.phoneNumber }</td>
			</tr>
		</table>
	</div>
	<div class=" col-md-12" id="printDiv" style="display: none;">
	   <table border="1" cellpadding="0" cellspacing="0" style="text-align: center;width: 70mm; height:90mm; font-size: 4mm;margin: 0 auto;">
			<tr>
				<td colspan="4" style="height: 40mm;">
				</td>
			</tr>
			<tr>
				<td colspan="4" style="height: 10mm; font-size: 5mm;">${carFormMap.bId }</td>
			</tr>
			<tr>
				<td style="width: 25mm; height: 10mm;">司机姓名</td>
				<td style="width: 35mm;">${carFormMap.driver }</td>
			</tr>
			<tr>
				<td style="width: 25mm; height: 10mm;">车牌号</td>
				<td style="width: 35mm;">${carFormMap.cId }</td>
			</tr>
			<tr>
				<td style="width: 25mm; height: 10mm;">联系电话</td>
				<td style="width: 35mm;">${carFormMap.phoneNumber }</td>
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

        LODOP.ADD_PRINT_HTM("10mm","3mm","100%","100%",$("#printDiv").html());	

	    LODOP.ADD_PRINT_BARCODE('15mm','20mm','40mm','40mm',"QRCode","${carFormMap.RFID }");
	};	       
</script>
</body>
</html>
