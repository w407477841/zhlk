<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">出库方案</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post">
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">粮库地点</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${chuKuFangAnFormMap.wlName }">
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">仓号</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${chuKuFangAnFormMap.wName }">
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">粮食品种</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${chuKuFangAnFormMap.variety }">
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">粮食性质</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${chuKuFangAnFormMap.category }">
   </div>  
   </div>
   </div>  
   
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">文件名称</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" value="${chuKuFangAnFormMap.gspFileName }" readonly="readonly">
   </div> 
   </div>
   </div>
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">重量(kg)</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" value="${chuKuFangAnFormMap.gspWeight }" readonly="readonly">
   </div> 
   </div>
   </div>
    
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">开始日期</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" value="${chuKuFangAnFormMap.gspBeginDate }" readonly="readonly">
  </div> 
   </div>
   </div>   
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">结束期日</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" value="${chuKuFangAnFormMap.gspEndDate }" readonly="readonly">
   </div> 
   </div>
   </div> 
  
   <div class="form-group col-md-12">
      <div class="col-md-1 div_label">内容</div>
   <div class="col-md-11">
    <div class="has-warning">
    <textarea rows="4" cols="10" class="form-control" readonly="readonly">${chuKuFangAnFormMap.gspContent }</textarea>
   </div> 
   </div>
   </div> 
   </form> 	
  	</div> 	
</body>
</html>
