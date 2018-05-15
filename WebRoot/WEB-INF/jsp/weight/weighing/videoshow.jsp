<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            border: 0;
        }
    </style>
</head>
<body>
<div id="divPlugin" style=" z-index: -1;"></div>
</body>
<script type="text/javascript" src="${ctx }/js/jquery-1.7.1.min.js"></script>
<script src="${ctx }/js/webVideoCtrl.js"></script>
<script type="text/javascript">
$(function () {
	var width = window.screen.width;
	var oPlugin = {
		iWidth: width/4.4,			// plugin width
		iHeight: 240			// plugin height
	};
	
	// 初始化插件参数及插入插件
	WebVideoCtrl.I_InitPlugin(oPlugin.iWidth, oPlugin.iHeight, {
        bWndFull: true,//是否支持单窗口双击全屏，默认支持 true:支持 false:不支持
        iWndowType: 1,
		cbSelWnd: function (xmlDoc) {
			
		}
	});
	WebVideoCtrl.I_InsertOBJECTPlugin("divPlugin");
});
</script>
</html>
