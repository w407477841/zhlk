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
<input type="hidden" class="form-control" id="eName" name="enterpriseFormMap.eName" value="${enterpriseFormMap.eName}">
	<input type="hidden" class="form-control" id="eGroupCode" name="enterpriseFormMap.eGroupCode" value="${enterpriseFormMap.eGroupCode}">
		<input type="hidden" class="form-control" id="eAddrCode" name="enterpriseFormMap.eAddrCode" value="${enterpriseFormMap.eAddrCode}">
		<input type="hidden" class="form-control" id="eNature" name="enterpriseFormMap.eNature" value="${enterpriseFormMap.eNature}">
		<input type="hidden" class="form-control" id="eClassify" name="enterpriseFormMap.eClassify" value="${enterpriseFormMap.eClassify}">
		<input type="hidden" class="form-control" id="eLocation" name="enterpriseFormMap.eLocation" value="${enterpriseFormMap.eLocation}">
		<input type="hidden" class="form-control" id="ePerson" name="enterpriseFormMap.ePerson" value="${enterpriseFormMap.ePerson}">
		<input type="hidden" class="form-control" id="ePhone" name="enterpriseFormMap.ePhone" value="${enterpriseFormMap.ePhone}">
		<input type="hidden" class="form-control" id="eCredit" name="enterpriseFormMap.eCredit" value="${enterpriseFormMap.eCredit}">
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
		utf16TextArr.push("企业名称:"+$("#eName").val());
		utf16TextArr.push("组织机构代码:"+$("#eGroupCode").val());
		utf16TextArr.push("行政区划代码:"+$("#eAddrCode").val());
		utf16TextArr.push("企业性质:"+$("#eNature").val());
		utf16TextArr.push("企业经营种类:"+$("#eClassify").val());
		utf16TextArr.push("通信地址:"+$("#eLocation").val());
		utf16TextArr.push("法人名称:"+$("#ePerson").val());
		utf16TextArr.push("联系电话:"+$("#ePhone").val());
		utf16TextArr.push("资信情况:"+$("#eCredit").val());
		console.log(utf16TextArr.join("\n"))
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
