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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">添加驳车</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
     <input type="hidden" id="bId" name="bId" value="${bId }"/>
     <div class="form-group col-md-12">
     <table id="magazineGrid"  style="width:95%;height:400px">
	 </table>
     </div>
     <div class="form-group col-md-12">
       <button type="button" class="btn btn-info" onclick="endUsedCar()">驳车完成</button>
     </div>
  	</div>
<script type="text/javascript" src="${ctx}/js/system/weight/reportHarbor/usedcarlist.js"></script>
<script type="text/javascript">
function endUsedCar(){
	parent.layer.close(parent.pageii);
}
</script>
</body>
</html>
