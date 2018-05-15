<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}

table tr {
	height: 35px;
	line-height: 35px;
	text-align: center;
}
.titleStyle{
text-align: center;
height: 50px;
font-size: large;
font-weight: bold;
}
.export{
 margin-top: 10px;
 margin-left: 200px;
}
</style>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
</head>
<body style="background-color:#d9edf7; ">
<div class="export">
<form action="" method="post" id="formexport">
  <input type="hidden" name="chuKuShenQingFormMap.id" value="${chuKuShenQingFormMap.id}">
   <a class="btn btn-info" href="javascript:void(0)" id="createPDF" style="text-shadow: black 5px 3px 3px;">
   <i class="glyphicon glyphicon-export icon-white" ></i>
      PDF
   </a>
   <a class="btn btn-info" href="javascript:void(0)" id="createExcel" style="text-shadow: black 5px 3px 3px;">
   <i class="glyphicon glyphicon-export icon-white" ></i>
   Excel
   </a>
   <a class="btn btn-info" href="javascript:void(0)" id="createWord" style="text-shadow: black 5px 3px 3px;">
   <i class="glyphicon glyphicon-export icon-white" ></i>
   Word
   </a>
</form>
</div>
<table style="width: 800px;margin: 20px auto;">
 <tr>
  <td colspan="4" class="titleStyle">出库申请单</td>
 </tr>
<tr>
  <td style="width: 150px;">发货日期：</td>
  <td style="width: 250px;" align="left">${chuKuShenQingFormMap.gsaSendOutDate}</td>
  <td style="width: 150px;">申请单编号：</td>
  <td style="width: 250px;" align="left">${chuKuShenQingFormMap.gsaApplyBill}</td>
 </tr><tr>
  <td colspan="4">
  
  <table border="1" cellpadding="1" cellspacing="1">
		<tr>
			<td style="width: 150px;">粮库地点</td>
			<td style="width: 250px;">${chuKuShenQingFormMap.wlName}</td>
			<td style="width: 150px;">仓号</td>
			<td style="width: 250px;">${chuKuShenQingFormMap.wName}</td>
		</tr>
		<tr>
			<td>买受人(需方)</td>
			<td>${chuKuShenQingFormMap.gsaPurchaser}</td>
			<td>合同号</td>
			<td>${chuKuShenQingFormMap.agreementID}</td>
		</tr>
		
		<tr>
			<td>货款到账情况</td>
			<td colspan="3">${chuKuShenQingFormMap.gsaPaymentSituation}</td>
			
		</tr>
		<tr>
		    <td>计划出库数量(吨)</td>
			<td>${chuKuShenQingFormMap.gsaPlanOutWeight}</td>
			<td>当前数量</td>
			<td>${chuKuShenQingFormMap.gsaCurrentWeight}</td>
			
		</tr>
		<c:if test="${lists !=null && fn:length(lists)>0 }">
		  <tr>
		   <td rowspan="${fn:length(lists)+2}">需方运输工具情况</td>
		   <td colspan="2">
		            车船号
		   </td>
		   <td>
		          车船吨位
		    </td>
		  </tr>
		  <c:forEach items="${lists}" var="tools">
		     <tr>
		       <td colspan="2">${tools.gsaaNo }</td>
		       <td>${tools.gsaaWeight }</td>
		     </tr>
		  </c:forEach>
		  <tr>
		   <td colspan="2"></td>
		   <td></td>
		  </tr>
		</c:if>

       <c:if test="${lists ==null || fn:length(lists) == 0 }">
		  <tr>
		   <td rowspan="6">需方运输工具情况</td>
		   <td colspan="2">
		            车船号
		   </td>
		   <td>
		          车船吨位
		    </td>
		  </tr>
		  <c:forEach begin="1" end="5" step="1">
		     <tr>
		       <td colspan="2"></td>
		       <td></td>
		     </tr>
		  </c:forEach>
		</c:if>
	</table>
  
  </td>
 </tr>
 <tr>
  <td>审批人：</td>
  <td  align="left">${chuKuShenQingFormMap.userName}</td>
  <td>申请部门：</td>
  <td  align="left">${chuKuShenQingFormMap.department}</td>
 </tr>

</table>




	

</body>
<script type="text/javascript">
$("#createPDF").click("click",function(){
	
});
$("#createExcel").click("click",function(){
	
});
$("#createWord").click("click",function(){
	
});


</script>
</html>
