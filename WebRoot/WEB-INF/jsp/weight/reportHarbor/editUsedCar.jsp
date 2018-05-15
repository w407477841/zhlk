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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">修改单据驳车</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
     <div class="form-group col-md-6">
   <div class="col-md-2 div_label">单据号</div>
   <div class="col-md-8">
   <div class="has-warning">
	<input type="text" class="form-control" id="bId" value="${bId }" placeholder="请输入 ：单据号" maxlength="12">	
   </div>  
   </div>
   <div class="col-md-2">
     <button type="button" class="btn btn-primary" onclick="search_info()">查询</button>
   </div>
   </div>
     
     <div class="form-group col-md-12">
     <table id="magazineGrid"  style="width:95%;height:300px">
	 </table>
     </div>
  	</div>
<script type="text/javascript" src="${ctx}/js/system/weight/reportHarbor/editusedcarlist.js"></script>

</body>
</html>
