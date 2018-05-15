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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">品种信息档案</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
     <div class="form-group col-md-6">
     <div class="col-md-3 div_label">品种名称</div>
   <div class="col-md-9">
   <div class="has-warning">
	<input type="text" class="form-control" name="varietyFormMap.text" value="${varietyFormMap.text }" readonly="readonly">	
   </div>  
   </div>
   </div>
   
    <div class="form-group col-md-6">
      <div class="col-md-3 div_label">自定义名称</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control" name="varietyFormMap.definedText" value="${varietyFormMap.definedText }" readonly="readonly">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">销售价格(50kg)</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control" name="varietyFormMap.salePrice" value="${varietyFormMap.salePrice }" readonly="readonly">
   </div> 
   </div>
   </div>  
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">采购价格(50kg)</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control" name="varietyFormMap.buyPrice" value="${varietyFormMap.buyPrice }" readonly="readonly">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">等级差价</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control"  name="varietyFormMap.rankPrice" value="${varietyFormMap.rankPrice }" readonly="readonly">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">是否启用</div>
   <div class="col-md-9">
    <div class="has-warning" style="height: 38px; line-height: 38px;">
    <input type="checkbox" style="height: 30px; width: 20px;" name="varietyFormMap.isEnable" disabled="disabled"  ${varietyFormMap.isEnable == 2?'checked="checked"':''}/>
    </div> 
   </div>
   </div> 
  	</div>
 <div class=" col-md-12"> 
    <table id="magazineGrid"  style="width:98%;height:300px">
	</table>
 </div>
 <script type="text/javascript">
 var vId = '${varietyFormMap.id}';
 </script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath }/js/system/weight/variety/qualitylist.js">
  
</script>
</body>
</html>
