<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@include file="/common/common.jspf"%>

<link rel="stylesheet" href="login/css/templatemo_misc.css">
<link type="text/css" rel="stylesheet"
	href="login/css/easy-responsive-tabs.css" />
<link href="login/css/templatemo_style.css" rel="stylesheet">

<script src="login/js/jquery.lightbox.js"></script>
<!-- script src="login/js/templatemo_custom.js"></script-->
<script src="login/js/easyResponsiveTabs.js" type="text/javascript"></script>

<script>
	function showhide() {
		var div = document.getElementById("newpost");
		if (div.style.display !== "none") {
			div.style.display = "none";
		} else {
			div.style.display = "block";
		}
	}
</script>
</head>
<body>
	<!-- logo start -->
	<div id="cttop"></div>
	<div class="logocontainer">
		<div class="row">
			<div class="clear"></div>
			<div class="templatemo_smalltitle">${prop.appName}</div>
		</div>
	</div>
	<!-- logo end -->
	<div id="menu-container" class="main_menu">
		<!-- homepage start -->
		<div class="content homepage" id="menu-1">
			<div class="container">
				<div class="col-md-3 col-sm-6 col-xs-12 templatemo_leftgap">
					<div class="templatemo_0 templatemo_botgap">
						<div class="templatemo_link">
							<form id="form0"
								action="${pageContext.servletContext.contextPath}/index.shtml"
								method="post">

								<input type="hidden" name="res" value="0"> <a
									class="show-2 templatemo_page2"
									href="javascript:document.getElementById('form0').submit()"><i
									class="glyphicon glyphicon-home"></i>
									<span style="color:white;font-size:large;">所有功能</span>
									 </a>
							</form>
						</div>
					</div>
				</div>
				<c:set value="1" var="len" scope="page"></c:set>
				<c:forEach items="${list}" var="res" varStatus="s">
					<c:if test="${s.index==0||s.index==4||s.index==5}">
						<div class="col-md-6 col-sm-6 col-xs-12 templatemo_leftgap">
							<c:set value="${len+2}" var="len" scope="page"></c:set>
					</c:if>
					<c:if test="${s.index==2}">
						<div class="col-md-9 col-sm-6 col-xs-12 templatemo_leftgap">
							<c:set value="${len+3}" var="len" scope="page"></c:set>
					</c:if>
					<c:if test="${s.index!=0&&s.index!=2&&s.index!=4&&s.index!=5}">
						<div class="col-md-3 col-sm-6 col-xs-12 templatemo_leftgap">
							<c:set value="${len+1}" var="len" scope="page"></c:set>
					</c:if>
					<div class="templatemo_${(s.index+1)%12} templatemo_botgap">
						<div class="templatemo_link">
							<form id="form${s.index+1}"
								action="${pageContext.servletContext.contextPath}/index.shtml"
								method="post">
								<input type="hidden" name="res" value="${res.id}"> <a
									class="show-2 templatemo_page2"
									href="javascript:document.getElementById('form${s.index+1}').submit()"><i
									class="${res.icon}"></i>
									<span style="color:white;font-size:large;">${res.name}</span>
									</a>
							</form>
						</div>
					</div>
			</div>
			</c:forEach>
			<c:set value="${len+1}" var="len" scope="page"></c:set>
			<div class="col-md-3 col-sm-6 col-xs-12 templatemo_leftgap">
				<div class="templatemo_5 templatemo_botgap">
					<div class="templatemo_link">
						<a class="show-2 templatemo_page2"
							href="${pageContext.servletContext.contextPath}/logout.shtml"><i
							class="glyphicon glyphicon-off"></i>
							<span style="color:white;font-size:large;">系统退出</span>
							</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- homepage end -->
	</div>
	<div id="divbottom"></div>
	<!-- logo start -->
	<div class="logocontainer">
		<div class="row">
			<c:if test="${error!=null}">
				<font color="red">${error}</font>
			</c:if>
		</div>
		<div class="row">
			<div class="templatemo_footer">
				Copyright © 2016 - 2017 <a href="http://www.jszyiot.com/">江苏中源物联网技术发展有限公司</a>
			</div>
		</div>
	</div>
	<!-- logo end -->
	<script type="text/javascript">
		(function(window) {
			var isFirst = true;
			var n = function() {
				var allWidth = $(".container").css("width").replace("px", "") * 1;
				var len = "${len}" * 1 || 0;
				if (isFirst) {
					if (len > 0 && len <= 4) {
						$(".templatemo_link").css({
							"height" : "300px",
							"line-height" : "300px"
						});
					} else if (len > 4 && len <= 8) {
						$(".templatemo_link").css({
							"height" : "225px",
							"line-height" : "225px"
						});
					} else if (len > 8 && len <= 12) {
						$(".templatemo_link").css({
							"height" : "175px",
							"line-height" : "175px"
						});
					}
					if (len % 4 != 0) {
						var clazzName = $(".templatemo_leftgap:last").attr(
								"class");
						$(".templatemo_leftgap:last")
								.attr(
										"class",
										"col-md-"
												+ (clazzName.substring(7, 8) * 1 + (4 - len % 4) * 3)
												+ " col-sm-6 col-xs-12 templatemo_leftgap");
					}
				}
				isFirst = false;
				var screenH = window.innerHeight;
				var containerH = $("#menu-container")[0].clientHeight;
				var offset = screenH - containerH - 170;
				if (offset <= 0)
					offset = 0;
				$("#cttop").css({
					"height" : offset / 2 + "px"
				});
				$("#divbottom").css({
					"height" : offset / 2 + "px"
				});
			}
			n();
			window.onresize = function() {
				n();
			};
		})(window);
		$(function() {
			$("#menu-1").click(function(ev) {
				var target = ev.target;
				if (target.className == 'templatemo_link') {
					target.children[0].submit();
				}
				if (target.tagName == "FORM") {
					target.submit();
				} else
					return;

			});
		});
	</script>
</body>
</html>