<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
</head>
<body style="background-color:#d9edf7">
	<div class='col-md-12' style='height:50px'></div>
	
	<div class='col-md-12' style="text-align: center;">
	 <img alt="img" src="${ctx}/img/logob.png" width="60%">
	</div>
	<div class='col-md-12' style='height:30px'></div>
	<div class='col-md-12'>
		<form action="${versionFormMap.url}" method="post">
			<input type="submit" value="安全下载" class="btn btn-info btn-block btn-lg">
		</form>
	</div>
</body>
</html>
