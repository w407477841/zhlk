<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
<script type="text/javascript" charset="UTF-8" src="${ctx}/js/jquery.qrcode.min.js"></script>
</head>
<body style="background-color:#d9edf7">
<div class='col-md-12' style='height:30px'></div>
 <div class='col-md-12' >
	<div id="code"></div>
   </div>
<script type="text/javascript">
	$(function(){
		$("#code").qrcode({ 
			    render: "table", //table方式 
			    width: 320, //宽度 
			    height:320, //高度 
			    //correctLevel:0, //纠错等级
			   	//src:rootPath+"/img/logo.png",
			    //imgWidth:80,
			    //imgHeight:80,
			    text:'${url}${ctx}/version/download.shtml'
			});
	});
	
</script>
</body>
</html>
