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
	 font-weight: bold;
	 text-align: center;
	 }
	 
	 .underline_lable{
	  width: 200px;
	  border-bottom:1px solid black;
	  text-align: center;
	  display: inline-block;
	 }
	 
	 .font_style{
	  font-size: large;
	  font-weight: bold;
	  line-height: 40px;
	 }
	 </style>
</head>
<body style="background-color:#d9edf7">
<div class=" col-md-6"><div class=" col-md-6"><h3 class="animated rubberBand"></h3> </div>   </div> <div class=" col-md-6">	</div>
<div class="form-group col-md-12 title"> 
客户货款到账通知单
</div> 	
<div class="form-group col-md-12 font_style" style="text-indent:40px"> 
  客户:<div class="underline_lable">${shouKuanTongZhiDanFormMap.cnCustomName }</div>
 仓号：<div class="underline_lable">${shouKuanTongZhiDanFormMap.wName }</div>
 货款：<div class="underline_lable">${shouKuanTongZhiDanFormMap.cnPayment }元</div>
 已于<div class="underline_lable">${shouKuanTongZhiDanFormMap.cnMoneyDate }</div>到我库帐号。
</div>
<div class="form-group col-md-12 font_style" style="text-indent:40px">
 特此通知
</div>
<div class="form-group col-md-12 font_style"style="text-align: right;">
${shouKuanTongZhiDanFormMap.wlName }<br>
${shouKuanTongZhiDanFormMap.cnAddDate }
</div>
</body>
</html>
