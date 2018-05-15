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
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
<script type="text/javascript" charset="UTF-8" src="${ctx}/js/jquery.qrcode.min.js"></script>
</head>
<body style="background-color:#d9edf7">

<div class=" col-md-12">
<div class='col-md-12' style='height:10px'></div>
 <div class='col-md-12' >
<input type="hidden" class="form-control" id="eName" name="OutRegisterFormMap.positionName" value="${OutRegisterFormMap.positionName}">
	<input type="hidden" class="form-control" id="eGroupCode" name="OutRegisterFormMap.code" value="${OutRegisterFormMap.code}">
		<input type="hidden" class="form-control" id="eAddrCode" name="OutRegisterFormMap.location" value="${OutRegisterFormMap.location}">
		<input type="hidden" class="form-control" id="eNature" name="OutRegisterFormMap.houseid" value="${OutRegisterFormMap.houseid}">
		<input type="hidden" class="form-control" id="eClassify" name="OutRegisterFormMap.roomName" value="${OutRegisterFormMap.roomName}">
		<input type="hidden" class="form-control" id="eLocation" name="OutRegisterFormMap.amounts" value="${OutRegisterFormMap.amounts}">
		<input type="hidden" class="form-control" id="ePerson" name="OutRegisterFormMap.outDate" value="${OutRegisterFormMap.outDate}">
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
		utf16TextArr.push("货位名称:"+$("#eName").val());
		utf16TextArr.push("货位编码:"+$("#eGroupCode").val());
		utf16TextArr.push("库点名称:"+$("#eAddrCode").val());
		utf16TextArr.push("仓房名称:"+$("#eNature").val().split(",")[1]);
		utf16TextArr.push("廒间名称:"+$("#eClassify").val());
		utf16TextArr.push("数量（公斤）:"+$("#eLocation").val());
		utf16TextArr.push("出库时间:"+$("#ePerson").val());
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
