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
	 <script type="text/javascript" charset="UTF-8" src="${ctx}/js/jquery.qrcode.min.js"></script>
</head>
<body style="background-color:#d9edf7">


<div class=" col-md-12"> 
<div class=" col-md-12">
<div class='col-md-12' style='height:10px'></div>
 <div class='col-md-12' >

   <input type="hidden" id="kudian" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wlNameo }">	
 

	<input type="hidden" id="canghao1" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wNameo }">

	<input type="hidden" id="canghao2" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wNamet }">

   <input type="hidden" class="form-control" readonly="readonly"  id="OriginalVariety" value="${daoCangGuanLiFormMap.variety }">

   <input type="hidden" class="form-control" readonly="readonly"  id="TargetVariety" value="${daoCangGuanLiFormMap.variety }">
  
 
   <input type="hidden" class="form-control" readonly="readonly"  id="OriginalCategory" value="${daoCangGuanLiFormMap.category }">

   <input type="hidden" class="form-control" readonly="readonly"  id="TargetCategory" value="${daoCangGuanLiFormMap.category }">

   <input type="hidden" class="form-control" readonly="readonly"  id="OriginalStoreman" value="${daoCangGuanLiFormMap.paNameo }">
 
   <input type="hidden" class="form-control" readonly="readonly"  id="TargetStoreman" value="${daoCangGuanLiFormMap.paNamet }">

   <input type="hidden" class="form-control" readonly="readonly"  id="OriginalStorageRate" value="${daoCangGuanLiFormMap.wgtOriginalStorageRate}">

   <input type="hidden" class="form-control" readonly="readonly"  id="TargetStorageRate"  value="${daoCangGuanLiFormMap.wgtTargetStorageRate}">

   
   <input type="hidden" id="danhao" class="form-control"  value="${daoCangGuanLiFormMap.wgtBill}" placeholder="请输入倒仓原单号" readonly="readonly">
 
   <input type="hidden" class="form-control" readonly="readonly" id="date"  value="${daoCangGuanLiFormMap.wgtTransferDate}">
  
   <input type="hidden" class="form-control" value="${daoCangGuanLiFormMap.wgtCause}" placeholder="请输入倒仓原因" readonly="readonly">
  
   <input type="hidden" class="form-control" readonly="readonly" id="sl" value="${daoCangGuanLiFormMap.wgtNumber}" placeholder="请输入倒仓数量(kg)">

   <input type="hidden" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wgtAddDate}"">

   <div id="code"></div>
  	</div> 	
  	<script type="text/javascript">

	$(function(){
		function utf16to8(str) {  
	        var out, i, len, c;  
	        out = "";  
	        len = str.length;  
	        for(i = 0; i < len; i++) {  
	        c = str.charCodeAt(i);  
	        if ((c >= 0x0001) && (c <= 0x007F)) {  
	            out += str.charAt(i);  
	        } else if (c > 0x07FF) {  
	            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));  
	            out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));  
	            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));  
	        } else {  
	            out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));  
	            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));  
	        }  
	        }  
	        return out;  
	    }  
		var utf16TextArr=[];
		utf16TextArr.push("倒仓单号:"+$("#danhao").val());
		utf16TextArr.push("原仓库:"+$("#canghao1").val());
		utf16TextArr.push("目标仓库:"+$("#canghao2").val());
		utf16TextArr.push("原种类:"+$("#OriginalVariety").val());
		utf16TextArr.push("目标种类:"+$("#TargetVariety").val());
		utf16TextArr.push("原性质:"+$("#OriginalCategory").val());
		utf16TextArr.push("目标性质:"+$("#TargetCategory").val());
		utf16TextArr.push("原保管员:"+$("#OriginalStoreman").val());
		utf16TextArr.push("目标保管员:"+$("#TargetStoreman").val());
		utf16TextArr.push("倒仓数量:"+$("#sl").val()+"公斤");
		utf16TextArr.push("倒仓时间:"+$("#date").val());
		var utf8Text=utf16to8(utf16TextArr.join("\n"));
		$("#code").qrcode({ 
			  //  render: "table", //table方式 
			    width: 320, //宽度 
			    height:320, //高度 
			    correctLevel:1, //纠错等级
			   	src:rootPath+"/img/logo.png",
			    imgWidth:80,
			    imgHeight:80,
			    text:utf8Text
			    //  text:"http://www.jszyiot.com" //任意内容
			  
			});
	});
	
</script>
</body>
</html>
