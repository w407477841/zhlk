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
</div>
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">仓房移交信息</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/yijiaoguanli/add.shtml">
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">粮库地点</div>
   <div class="col-md-10">
   <div class="has-warning">
    <input type="text" class="form-control" readonly="readonly" value="${yiJiaoGuanLiFormMap.wlName}">	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">仓号</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" readonly="readonly" value="${yiJiaoGuanLiFormMap.wName}">		
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">原保管员</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${yiJiaoGuanLiFormMap.poName}">	
  </div> 
   </div>
   </div>  
   
    <div class="form-group col-md-6">
        <div class="col-md-2 div_label">现保管员</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" readonly="readonly" value="${yiJiaoGuanLiFormMap.pnName}">		
   </div>  
   </div>
   </div>
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">移交日期</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" readonly="readonly" value="${yiJiaoGuanLiFormMap.wtTransferDate}">	
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">创建日期</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" readonly="readonly" value="${yiJiaoGuanLiFormMap.wtAddDate}">	
   </div> 
   </div>
   </div>    
  
   <div class="form-group col-md-12">
      <div class="col-md-1 div_label">备注</div>
   <div class="col-md-11">
    <div class="has-warning">
    <textarea rows="4" cols="10" class="form-control" readonly="readonly">${yiJiaoGuanLiFormMap.wtRemark}</textarea>
   </div> 
   </div>
   </div>
   </form> 	
  	</div> 	
</body>
</html>
