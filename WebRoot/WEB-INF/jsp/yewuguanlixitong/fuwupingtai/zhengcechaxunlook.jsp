<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
	 <style type="text/css">
	 .chosen-container-single .chosen-single{
	 height:37px;
	 }
	 .title{
	  font-size: x-large;
	  font-weight:bold;
	  text-align: center;
	  width: 100%;
	 }
	 
	 .line_hr{
	 width: 100%;
	 height: 1px;
	 background-color: black;
	 }
	 </style>
	 
	 
</head>
<body style="background-color:#d9edf7">
<div id="errorDiv" class="col-md-12">
</div>
<div class=" col-md-4"><div class=" col-md-6">  <h3 class="animated rubberBand"></h3> </div>   </div> <div class=" col-md-8">	</div>
<div class=" col-md-12"> 
   <div class="form-group col-md-12">
   <div class="title">
   ${zhengCeChaXunFormMap.pqTitle }
   </div>
   </div>  
   <div class="form-group col-md-12">
   <div class="line_hr">
   </div>
   </div>  
   <div class="form-group col-md-12">
   <div class="col-md-12">
   ${zhengCeChaXunFormMap.pqContent}
   </div>
   </div>  
   <div class="form-group col-md-12">
   <div class="line_hr">
   </div>
   </div> 
   <div class="form-group col-md-12">
   <div class="col-md-1 div_label">文章类型：</div>
   <div class="col-md-3 div_label" style="text-align: left;">
   	${zhengCeChaXunFormMap.itName}
   </div>
   
   <div class="col-md-1 div_label">发布人：</div>
   <div class="col-md-3 div_label" style="text-align: left;">
   	${zhengCeChaXunFormMap.userName}
   </div>
   
   <div class="col-md-1 div_label">发布日期：</div>
   <div class="col-md-3 div_label" style="text-align: left;">
   	${zhengCeChaXunFormMap.pqAddDate}
   </div>
   </div>  
  	</div> 	
</body>
</html>
