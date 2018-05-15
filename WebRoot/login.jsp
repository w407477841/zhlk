<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<c:set var="ctx" value="${pageContext.servletContext.contextPath}"></c:set>
<html lang="en">
<head>
<meta charset="UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<title>${prop.appName}</title>
<link rel="shortcut icon" href="${ctx}/img/ico.png">
<style>
* {margin: 0 auto;padding: 0;}
body {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
	-khtml-user-select: none;
	user-select: none;
}
html,body {height: 100%;}
#img-bj {
	height: 100%;
	background-size: cover;
	background-position: center center;
}
#img-bj {
	background-image: url(img/4.jpg);
}
.div-bj {
	width: 600px;
	height: 320px;
}
.div-t {
	width: 604px;
	height: 324px;
}
.div-t,.div-bj {
	position: inherit;
}
h1 {
	height: 100px;
	line-height: 100px;
	text-align: center;
	white-space: nowrap;
}
.div-x {
	width: 80%;
	font-size: 1em;
	text-align: center;
}

.div-x>div {
	font-weight: 900;
}

.div-x>div>input {
	width: 40%;
	border: 0;
	font-size: 1em;
	vertical-align: top;
	border-radius: 2px;
}

.sub {
	width: 40%;
	color: white;
	background-color: #0C4CA3;
	border-radius: 5px;
	border: 1px solid #0C4CA3;
}

#dj,#xz,#sub {
	cursor: pointer;
	cursor: hand;
}

#dj {
	display: inline-block;
	right: 2px;
	bottom: 2px;
}

#dj>input {
	vertical-align: middle;
}

#dj>span {
	vertical-align: middle;
}

.div-cw {
	width: 80%;
	color: #990000;
	font-size: 1.2em;
	margin-top: 2%;
	text-align: center;
	position: relative;
}

.zyiot>a>img {
	width: 100px;
	height: 50px;
	cursor: pointer;
	cursor: hand;
	border: 0;
	margin: 0;
	padding: 0;
}

#div_dw {
	position: absolute;
	left: 50%;
	margin-left: -302px;
	width: 600px;
	height: 320px;
}

@media screen and (min-width:601px) {
	.zyiot {
		position: absolute;
		bottom: 2%;
		left: 2%;
	}
	#div_dw {
		top: 40%;
		margin-top: -182px;
	}
	#dj {
		width: 100px;
	}
	.sub {
		height: 40px;
		font-size: 1.5em;
	}
	h1 {
		font-size: 2.4em;
	}
	.div-bj {
		border: 2px solid;
		border-radius: 15px;
		background-color: white;
		opacity: 0.50;
	}
	.div-x>div>input {
		height: 36px;
	}
	.div-cw {
		left: 10%;
	}
}

@media screen and (max-width:600px) {
	#div_dw {
		top: 50%;
		margin-top: -162px;
	}
	.div-x {
		padding-right: 8%;
	}
	.zyiot {
		position: relative;
		margin-left: -50px;
		left: 51%;
		top: 2%;
	}
	.div-cw {
		left: 3%;
	}
	.div-t {
		width: 100%;
	}
	.div-bj {
		display: none;
	}
	#dj {
		width: 60px;
	}
	.sub {
		height: 36px;
		font-size: 1.2em;
	}
	h1 {
		font-size: 2em;
	}
	.div-x>div>input {
		height: 24px;
	}
	.div-x img {
		height: 24px;
	}
	#dj>label {
		display: none;
	}
	#xz {
		
	}
}

@media screen and (max-device-width:480px) {
	h1 {
		font-size: 1.6em;
	}
}
</style>
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<script language="javascript">
	var url_ = top.location.href;
	var index = url_.indexOf("login");
	if (index < 0) {
		var last = url_.lastIndexOf("/");
		var lastP = url_.lastIndexOf(".");
		var href_ = url_.substring(0, last) + "/login" + url_.substring(lastP);
		console.log(href_);
		top.location.href = href_;
	}
</script>
</head>
<body onkeydown="keyOnClick(event)">
	<div id="img-bj">
		<div id="div_dw">
			<div class="div-bj"></div>
			<div class="div-t">
				<h1>${prop.appName}</h1>
				<form action="${pageContext.servletContext.contextPath}/login.shtml"
					method="post" id="formLogin">
					<input type="hidden" id="macaddress" name="macAddress">
					<input type="hidden" id="password2" name="password">
					<div class="div-x">
						<div>
							<span style="font-size: 26px;">帐  号：</span> <input type="text"
								id="username" name="username" value="${userSession.accountName}">
						</div>
						<br />
						<div>
							<span style="font-size: 26px;">密  码：</span> <input type="password"
								id="password" value="${userSession.password}">
						</div>
						<br />
						<div>
							<span id="dj"><input type="checkbox" name="memberPass"
								id="xz" checked="checked"><label for="xz"> 记住密码</label></span>
							<span><input type="button" value="登陆" class="sub" id="sub" onclick="_login()"></span>
						</div>
					</div>
					<input type="hidden" name="encrypted_pwd" id="encrypted_pwd" value="zhlk" />
				</form>
				<div class="div-cw">
					<c:if test="${error!=null}">
                    ${error}
                </c:if>
				</div>
				<div class="zyiot">
					<a href="http://www.jszyiot.com/" target="_blank"> <img
						src="img/4.png"></a>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	//回调函数
	function getMACCallback(data) {
		if (data.result == 'success') {
			$("#macaddress").val(data.mac);
		} else {
			//layer.alert(data.result,{icon: 5});
		}
	}
	//获取MAC地址
	(function() {
		$.ajax({
			async : false,
			type : 'GET',
			dataType : 'jsonp',
			url : 'http://127.0.0.1:9898/websocket/websocket/getLocalMac',
			jsonpCallback : "getMACCallback",
			error : function() {
				//layer.alert("网络配置失败！",{icon: 5});
			}
		});
	})();

	//地磅数据
	(function() {
		$.ajax({
			async : false,
			type : 'GET',
			dataType : 'jsonp',
			url : 'http://127.0.0.1:9898/websocket/websocket/weighbridge',
			error : function() {
				//alert("网络配置失败");
			}
		});
	})();
</script>
<script src="${ctx}/js/rsa/security.js" type="text/javascript"></script>
<script type="text/JavaScript">
    function keyOnClick(e){
    var theEvent = window.event || e;
    var code = theEvent.keyCode || theEvent.which;
    if (code==13) {  //回车键的键值为13
    	_login();  //调用搜索事件
    }
}
</script>
<script type="text/javascript">
	function _login() {
		var password = $("#password").val();
		RSAUtils.setMaxDigits(200);
		var key = new RSAUtils.getKeyPair("${publicKeyExponent}", "",
				"${publicKeyModulus}");
		var encrypedPwd = RSAUtils.encryptedString(key, password);
		$("#password2").attr("value", encrypedPwd);
		$("#formLogin").submit();
	}
</script>
</html>