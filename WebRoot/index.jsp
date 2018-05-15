<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/menutaglib" prefix="mt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<!-- 由于地图加载较慢，当是县级平台时在进行加载，智慧粮库就不进行加载
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=ZGdDBno6pWeL3hDhTXaEiPcmMKMtkGL9"></script>
-->
<script type="text/javascript" charset="UTF-8">
	var rootPath = "${pageContext.servletContext.contextPath}";
	function changeClass(obj) {
		if ($(obj).children()[0].className == "glyphicon glyphicon-plus") {

			$(obj).children()[0].className = "glyphicon glyphicon-minus";
		} else {
			$(obj).children()[0].className = "glyphicon glyphicon-plus";
		}
	}
	function onloadUrl(obj, url) {
		$("#content").html(loadingImg());
		if (url.indexOf("?") > -1) {
			url += "&";
		} else {
			url += "?";
		}
		url = url + "_t=" + new Date().getMilliseconds();
		if (url.indexOf("weighing/list") > -1) {
			window.open(url);
		} else {
			$.ajax({
				url : url,
				type : 'post',
				dataType : 'html',
				error : function(data) {
					if (data.status = 404)
						$("#content").html(data.responseText);
				},
				success : function(data) {
					$("#contenttop")
							.css('height', $(window).scrollTop() + "px");
					window.scollH = $(window).scrollTop();
					window.divh = scollH;

					$("#daohang_ul").empty();
					var tag_lis = [];
					$("#daohang_ul").append(
							$("<li class=\"pull-right \"> </li>"));
					$.each($(obj).parents("li"), function(i, val) {
						var li = $("<li>");
						$("<a href=\"javascript:void(0)\">").html(
								$(val).attr("data-name")).appendTo(li);
						tag_lis.push(li[0]);
					});
					while (tag_lis.length > 0) {
						$(tag_lis.pop()).appendTo($("#daohang_ul"));
					}
					$("#content").html(data);
				}
			});
		}
	}
	function loadingImg() {
		var html = '<div class="alert alert-warning">'
				+ '<button type="button" class="close" data-dismiss="alert">'
				+ '<i class="ace-icon fa fa-times"></i></button><div style="text-align:center">'
				+ '<img src="' + rootPath + '/img/ajax-loaders/ajax-loader-5.gif"/><div>'
				+ '</div>';
		return html;
	}
	var Util = (function(u) {
		function updatePasswordLayer() {
			layer.open({
				type : 2,
				title : '修改密码',
				area : [ '550px', '360px' ],
				skin : 'layui-layer-rim', //加上边框
				content : [ rootPath + '/user/updatePassword.shtml', 'no' ]
			});
		}
		u.updatePasswordLayer = updatePasswordLayer;
		u.fullScreen = {
			isFull : false,
			full : function() {
				if (!this.fullScreen) {
					$("#menuheight").css("display", "none");
					$("#fullScreenDiv").attr("class", "col-lg-12 col-sm-12");
					this.fullScreen = true;
				} else {
					$("#menuheight").css("display", "block");
					$("#fullScreenDiv").attr("class", "col-lg-9 col-sm-9");
					this.fullScreen = false;
				}
			}
		};
		return u;
	})(Util || {});
</script>
</head>
<body>
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">
		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left animated flip">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.shtml"
				style="width:${prop.appNameWidth}"> <img alt="Logo"
				src="img/logob.png" class="hidden-xs" /> <span><font
					class="user_define_title_color">${prop.appName}</font></span></a>
			<!-- user dropdown starts -->
			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs">${userSession.userName}</span> <span
						class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="javascript:Util.updatePasswordLayer()">修改密码</a></li>
					<li class="divider"></li>
					<li><a
						href="${pageContext.servletContext.contextPath}/logout.shtml">退出</a></li>
				</ul>
			</div>
			<!-- user dropdown ends -->
			<!-- theme selector starts -->
			<div class="btn-group pull-right theme-container animated tada">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-tint"></i><span
						class="hidden-sm hidden-xs">更换主题</span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu" id="themes">
					<li><a data-value="classic" href="javascript:void(0)"><i
							class="whitespace"></i> Classic</a></li>
					<li><a data-value="cerulean" href="javascript:void(0)"><i
							class="whitespace"></i> Cerulean</a></li>
					<li><a data-value="lumen" href="javascript:void(0)"><i
							class="whitespace"></i> Lumen</a></li>
					<li><a data-value="united" href="javascript:void(0)"><i
							class="whitespace"></i> United</a></li>
				</ul>
			</div>
			<!-- theme selector ends -->
			<div class="btn-group pull-right" style="margin: 0px;">
				<div>
					<span id="day" style="margin-right: 20px;"></span><span id="hours"></span><span><img
						width="10px" height="40px" style="width:10px;height:40px"
						src="img/time/dd.png" /></span><span id="minutes"></span><span><img
						src="img/time/dd.png" style="width:10px;height:40px" width="10px"
						height="40" /></span><span id="seconds"></span>
				</div>
			</div>

		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">

			<!-- left menu starts -->
			<div class="col-sm-3 col-lg-3 menu_list" id="menuheight">
				<div class="sidebar-nav">
					<div class="nav-canvas">
						<div class="nav-sm nav nav-stacked"></div>
						<mt:showMenu menuList="${list}" ctx="${ctx}" />
					</div>
				</div>
			</div>
			<!--/span-->
			<!-- left menu ends -->
			<div class="col-lg-9 col-sm-9" id="fullScreenDiv">
				<div id="contenttop" class="col-lg-12 col-sm-12">
					<!-- 填补高度 -->
				</div>
				<div class="col-lg-12 col-sm-12">
					<ul class="breadcrumb" id="daohang_ul">
						<li><a href="javascript:void(0)">主页</a></li>

					</ul>
				</div>
				<div id="content" class="col-lg-12 col-sm-12">
					<!-- content starts -->
				</div>
			</div>
			<!--/row-->
			<!-- content ends -->
		</div>
		<!--/#content.col-md-0-->
	</div>
	<!--/fluid-row-->
	<hr>
	<footer class="row">
	<p class="col-md-9 col-sm-9 col-xs-12 copyright">
		Copyright © 2016 - 2017 <a href="http://www.jszyiot.com/">江苏中源物联网技术发展有限公司</a>
	</p>
	</footer>
	<!--/.fluid-container-->
</body>
<script type="text/javascript">
	onloadUrl(document.getElementById("home_a"), rootPath + '/welcome.shtml');
	(function() {//调整高度
		$(window).scroll(function() {
			try {
				var tempS = $(window).scrollTop();
				if (divh > tempS) {
					document.getElementById('contenttop').style.height = tempS;
					divh = tempS;
					scollH = tempS;
				} else {
					scollH = tempS;
				}
			} catch (e) {
			}
		});
	})();
	$(function() {
		var aUl = document.getElementById("daohang_ul");
		aUl.ondblclick = function(ev) {
			var ev = ev || window.event;
			var target = ev.target || ev.srcElement;
			if (target.nodeName == 'UL') {
				Util.fullScreen.full();
			} else {
			}
		};
	});
</script>
<script type="text/javascript" src="${ctx}/common/common_time.js"></script>
</html>