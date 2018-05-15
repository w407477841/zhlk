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
<div class='col-md-12' style='height:10px'></div>
 <div class='col-md-12' >
    <input type="hidden" id="buyYear"  value="${storageInfoFormMap.buyYear}">
	<input type="hidden" id="variety" value="${storageInfoFormMap.variety}">
	<input type="hidden" id="property" value="${storageInfoFormMap.property}">
	<input type="hidden" id="cangKu" value="${storageInfoFormMap.cangKu}">
	<input type="hidden" id="wName"  value="${storageInfoFormMap.wName}">
	<input type="hidden" id="paName" value="${storageInfoFormMap.paName}">
	<input type="hidden" id="level" value="${storageInfoFormMap.level}">
	<input type="hidden" id="qiyemingcheng" value="${storageInfoFormMap.qiyemingcheng}">
	
	<input type="hidden" id="kuqubianma" value="${storageInfoFormMap.kuqubianma}">
	<input type="hidden" id="tongyixinyongdaima" value="${storageInfoFormMap.tongyixinyongdaima}">
	<input type="hidden" id="cangfangbianhao" value="${storageInfoFormMap.cangfangbianhao}">
	<input type="hidden" id="huoweibianhao" value="${storageInfoFormMap.huoweibianhao}">
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
		utf16TextArr.push("单位名称:"+$("#qiyemingcheng").val());
		utf16TextArr.push("货位代码:"+$("#tongyixinyongdaima").val()+$("#kuqubianma").val()+$("#cangfangbianhao").val()+$("#huoweibianhao").val());
		utf16TextArr.push("货位名称:"+$("#wName").val());
		utf16TextArr.push("粮食品种:"+$("#variety").val());
		utf16TextArr.push("粮食性质:"+$("#property").val());
		utf16TextArr.push("库存数量:"+$("#cangKu").val()+" kg");
		utf16TextArr.push("等级:"+$("#level").val());
		utf16TextArr.push("收获年份:"+$("#buyYear").val());
		utf16TextArr.push("保管员:"+$("#paName").val());
		
		var utf8Text=utf16to8(utf16TextArr.join("\n"));
		$("#code").qrcode({ 
			    width: 320, //宽度 
			    height:320, //高度 
			    correctLevel:1, //纠错等级
			   	src:rootPath+"/img/logo.png",
			    imgWidth:80,
			    imgHeight:80,
			    text:utf8Text
			});
	});
	
</script>
</body>
</html>
