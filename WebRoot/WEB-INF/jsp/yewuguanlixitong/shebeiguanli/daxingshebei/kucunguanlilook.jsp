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
  <input type="hidden" name="DaXingSheBeiFormMap.id" value="${daXingSheBeiFormMap.id}">
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
	<table border="1" cellpadding="1" cellspacing="1"
		style="width: 800px;margin: 20px auto;">
		<tr>
			<td colspan="4" class="titleStyle">设备信息</td>
		</tr>
		<tr>
			<td style="width: 150px;">设备编号</td>
			<td style="width: 250px;">${daXingSheBeiFormMap.leNo}</td>
			<td style="width: 150px;">设备名称</td>
			<td style="width: 250px;">${daXingSheBeiFormMap.leName}</td>
		</tr>
		<tr>
			<td>设备规格</td>
			<td>${daXingSheBeiFormMap.leStandard}</td>
			<td>资产价值(元)</td>
			<td>${daXingSheBeiFormMap.leWorth}</td>
		</tr>
		
		<tr>
			<td>电机数量(台)</td>
			<td>${daXingSheBeiFormMap.leMotorsNumber}</td>
			<td>电机总容量(KW)</td>
			<td>${daXingSheBeiFormMap.lePower}</td>
		</tr>
		<tr>
			<td>电话号码</td>
			<td>${daXingSheBeiFormMap.leTelephone}</td>
			<td>邮编</td>
			<td>${daXingSheBeiFormMap.leZipCode}</td>
		</tr>
		<tr>
			<td>使用地点</td>
			<td>${daXingSheBeiFormMap.leLocation}</td>
			<td>始用时间</td>
			<td>${daXingSheBeiFormMap.leUsedDate}</td>
		</tr>
		<tr>
			<td>制造单位</td>
			<td colspan="3">${daXingSheBeiFormMap.leManufacturingUnit}</td>
		</tr>
		<tr>
			<td>制造地址</td>
			<td colspan="3">${daXingSheBeiFormMap.leManufacturingAddress}</td>
		</tr>
		<tr>
		   <td  colspan="4" class="titleStyle">随机附件</td>
		</tr>
		<tr>
		   <td>序号</td>
		   <td>名称</td>
		   <td>规格</td>
		   <td>数量</td>
		</tr>
		<c:if test="${daXingSheBeiFuJianList !=null && fn:length(daXingSheBeiFuJianList)>0 }">
		  <c:forEach items="${daXingSheBeiFuJianList}" var="shebei" varStatus="ind">
		     <tr>
		       <td>${ind.index+1}</td>
		       <td>${shebei.leaName }</td>
		       <td>${shebei.leaStandard }</td>
		       <td>${shebei.leaNumber }</td>
		     </tr>
		  </c:forEach>
		  <tr>
		   <td></td>
		   <td></td>
		   <td></td>
		   <td></td>
		  </tr>
		</c:if>
		<c:if test="${daXingSheBeiFuJianList ==null || fn:length(daXingSheBeiFuJianList)<=0 }">
		   <c:forEach begin="1" end="5" step="1">
		   <tr>
		   <td></td>
		   <td></td>
		   <td></td>
		   <td></td>
		   </tr>
		   </c:forEach>
		</c:if>
		
		<tr>
		   <td  colspan="4" class="titleStyle">维修记录</td>
		</tr>
		<tr>
		   <td>日期</td>
		   <td colspan="2">维修内容</td>
		   <td>维修人员</td>
		</tr>
		<c:if test="${daXingSheBeiWeiXiuList !=null && fn:length(daXingSheBeiWeiXiuList)>0 }">
		  <c:forEach items="${daXingSheBeiWeiXiuList}" var="weixiu" varStatus="ind">
		     <tr>
		       <td>${weixiu.lerRepairDate }</td>
		       <td colspan="2">${weixiu.lerContent }</td>
		        <td>${weixiu.lerRepairUser }</td>
		     </tr>
		  </c:forEach>
		  <tr>
		   <td></td>
		   <td colspan="2"></td>
		   <td></td>
		  </tr>
		</c:if>
		<c:if test="${daXingSheBeiWeiXiuList ==null || fn:length(daXingSheBeiWeiXiuList)<=0 }">
		   <c:forEach begin="1" end="5" step="1">
		   <tr>
		   <td></td>
		   <td colspan="2"></td>
		   <td></td>
		   </tr>
		   </c:forEach>
		</c:if>
	</table>
	</div>
</body>
<script type="text/javascript">
$("#createPDF").click("click",function(){
	$("#formexport").attr("action",rootPath+"/daxingshebeikucun/createPDFReport.shtml");
	$("#formexport").submit();
});
$("#createExcel").click("click",function(){
	$("#formexport").attr("action",rootPath+"/daxingshebeikucun/createExcelReport.shtml");
	$("#formexport").submit();
});
$("#createWord").click("click",function(){
	$("#formexport").attr("action",rootPath+"/daxingshebeikucun/createWordReport.shtml");
	$("#formexport").submit();
});


</script>
</html>
