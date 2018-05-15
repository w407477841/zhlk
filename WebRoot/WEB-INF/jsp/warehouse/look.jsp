<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<%@include file="/common/common.jspf"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
v\:* {
	behavior: url(#default#VML);
}

* {
	maigin: 0px;
	padding: 0px;
	font-size: 14px;
}

p {
	margin: 5px 0;
}

.floor {
	height: 10px;
}

.body_all {
	width: 100%;
}

.body_right {
	width: 50%;
	float: right;
}

.body_left {
	width: 50%;
	float: left;
}

.color_line {
	width: 100%;
	height: 20px;
	margin-top: 10px;
}

.operation_line {
	width: 100%;
	text-align: center;
}

.no-padding {
	padding-left: 0px;
	padding-right: 0px;
}

.div-control-height {
	height: 30px;
	line-height: 30px;
}
</style>
<script charset="utf-8" src="${ctx}/js/3d/kindeditor-min.js"></script>
<script charset="utf-8" src="${ctx}/js/3d/zh_CN.js"></script>

<script src="${ctx}/js/3d/a_svgvml3d_1.js" type="text/javascript"></script>
<script src="${ctx}/js/3d/a_boundingbox_2.js" type="text/javascript"></script>

<link rel="stylesheet" href="${ctx}/js/3d/default.css" />
<link href="${ctx}/js/3d/3dstyle.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/js/3d/tmp3dstyle.css" rel="stylesheet"
	type="text/css" />
</head>
<body class="myfont">
	<div class="body_all">
		<div class="body_left">
			<div class="box col-md-12">
				<div class="box-inner">
					<div class="box-header well">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span>三位展示</span>
						</h2>
					</div>
					<div class="box-content">
					    <embed width='100%' height='500' name='Scene1' id="3dshow"
								src='${ctx}/warehouse/getSVG.shtml' wmode='transparent'
								type='image/svg+xml'
								pluginspage="http://www.adobe.com/svg/viewer/install/" />
					</div>
				</div>
			</div>
		</div>
		<div class="body_right">
			<div class="col-md-6">
			  
				<div class="box col-md-12 no-padding">
					<div class="box-inner">
						<div class="box-header well">
							<h2>
								<i class="glyphicon glyphicon-transfer"></i> <span>粮层控制</span>
							</h2>
						</div>
						<div class="box-content">
							<div class="row">
								<div id="cengshuTd" class="col-md-3 no-padding">
									<div style="font-weight: bold;">显示控制</div>
								</div>
								<div id="pingjunwen" class="col-md-3 no-padding"
									style="color:#6E8B3D;">
									<div style="font-weight: bold;">平均温</div>
								</div>
								<div id="zuigaowen" class="col-md-3 no-padding"
									style="color:#CD661D;">
									<div style="font-weight: bold;">最高温</div>
								</div>
								<div id="zuidiwen" class="col-md-3 no-padding"
									style="color: #708090;">
									<div style="font-weight: bold;">最低温</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box col-md-12 no-padding">
					<div class="box-inner">
						<div class="box-header well" data-original-title="">
							<h2>
								<i class="glyphicon glyphicon-move"></i> <span>旋转控制</span>
							</h2>
						</div>
						<div class="box-content">
							<div class="operation_line">
							   <a href="javascript:void(0)" class="fa fa-caret-down fa-flip-vertical fa-3x" onclick="ChangeViewer(10,0)"> 
						       </a>
						       <!-- 
								<input type="button" class="button icon icon-top"
									onclick="ChangeViewer(10,0)">
									 -->
							</div>
							<div class="operation_line">
							<a href="javascript:void(0)" class="fa fa-caret-down fa-rotate-90 fa-3x" onclick="ChangeViewer(0,-5)"> 
						       </a>
							<a href="javascript:void(0)" id="contr" class="fa fa-pause fa-3x" style="padding-left: 10px; padding-right: 10px;" onclick="clickxuanzhuan()"> 
						    </a>
							<a href="javascript:void(0)" class="fa fa-caret-down fa-rotate-270 fa-3x" onclick="ChangeViewer(0,5)"> 
						       </a>
							</div>
							<div class="operation_line">
							
							
							<a href="javascript:void(0)" class="fa fa-caret-down fa-3x" onclick="ChangeViewer(-10,0)"> 
						       </a>
						      
							</div>
							<div class="operation_line">
							<a href="javascript:void(0)" style="padding-right: 10px;" class="fa fa-search-plus fa-2x" onclick="ZoomPicture(1);"> 
						       </a>
						        <a href="javascript:void(0)" class="fa fa-search-minus fa-2x" onclick="ZoomPicture(-1);"> 
						       </a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
			<div class="box col-md-12 no-padding">
					<div class="box-inner">
						<div class="box-header well">
							<h2>
								<i class="glyphicon glyphicon-list-alt"></i> <span>温度参照图</span>
							</h2>
						</div>
						<div class="box-content">
							<div id='contentss'></div>
						</div>
					</div>
				</div>
				<div class="box col-md-12 no-padding">
					<div class="box-inner">
						<div class="box-header well">
							<h2>
								<i class="glyphicon glyphicon-th-large"></i> <span>温/湿度数据</span>
							</h2>
						</div>
						<div class="box-content">
						  
						   <div class="row div-control-height">
						   <div class="col-md-3 div-control-height no-padding">采集时间:</div>
						   <div class="col-md-9 div-control-height no-padding">${warehouseFormMap.cjsj}</div>
						    </div>
						   <div class="row">
						   <div class="col-md-3 div-control-height no-padding">仓内温度:</div>
						   <div class="col-md-3 div-control-height no-padding" id="cnwd"></div>
						   <div class="col-md-3 div-control-height no-padding">仓外温度:</div>
						   <div class="col-md-3 div-control-height no-padding" id="cwwd"></div>
						    </div>
						   <div class="row">
						   <div class="col-md-3 div-control-height no-padding">仓内湿度:</div>
						   <div class="col-md-3 div-control-height no-padding" id="cnsd"></div>
						   <div class="col-md-3 div-control-height no-padding">仓外湿度:</div>
						   <div class="col-md-3 div-control-height no-padding" id="cwsd"></div>
						    </div>
						   <div class="row">
						   <div class="col-md-3 div-control-height no-padding">最高温度:</div>
						   <div class="col-md-3 div-control-height no-padding" id="zgwd"></div>
						   <div class="col-md-3 div-control-height no-padding">最低温度:</div>
						   <div class="col-md-3 div-control-height no-padding" id="zdwd"></div>
						    </div>
						</div>
					</div>
				</div>
				
				
				
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	var S, B;
	var arraylist = [];

	var i, j, xmin, xmax, n_x = 100, ymin, ymax, n_y = 100, zmin, zmax, x0, x1, y0, y1, z, x, y;
	//x轴开始的位置
	xmin = 0;
	xmax = 5;
	//y轴开始的位置
	ymin = 0;
	ymax = 5;
	//z轴开始的位置
	zmin = 0;
	zmax = 5;

	function drowSvgData(dataarr, col, row, layer) {
		xmax = col;
		ymax = row;
		zmax = parseInt(layer) + 1;
		arraylist = dataarr;
		for (var i = 1; i < zmax; i++) {
			var m = zmax - i;
			$("#cengshuTd")
					.append(
							""
									+ "<div class='div-control-height'><input type='checkbox' checked='checked' id='show"
									+ (m)
									+ "'"
									+ " class='floor' style='width: 20px;color:black;' onClick='checkshow(this.id);' />"
									+ "<b class='floor'>第" + (i)
									+ "层 </b></div>");
		}
		Init();
		ZoomPicture(1);
	}

	var viewerzoomed = 0, picturezoomed = 0;
	zPoly = new Array(n_x);
	for (var i = 0; i < n_x; i++)
		zPoly[i] = new Array(35);

	function Init() {
		S = null, B = null;
		if (useSVG) {
			if (!SVGObjects[0]) {
				setTimeout("Init()", 100);
				return;
			}
			S = new Scene3D(SVGObjects[0], 0, 520, 460);
		} else {
			S = new Scene3D(document.getElementById("Scene1"), 1);
		}

		S.DiffuseLight = 0.8; //只有在0和1之间的时候包含0和1，默认是0.5，才可以使用S对象一一些主要的方法如：AutoCenter、ChangeViewer、Sort、Draw等。
		B = new BoundingBox(S, "#E5E5E5", "#8B8989");
		n_f = 0;

		var h, m, n;
		//判断显示/隐藏
		var showtemp = [];
		for (var i = 0; i < zmax - 1; i++) {
			showtemp.push(i);
		}
		debugger;
		var message = '';
		var pArray = new Array();
		pArray = message.split(",");
		for (h = 0; h < showtemp.length; h++) {
			var num = 0, max = 0, min = 100, sum = 0;
			try {
				for (m = 0; m < ymax; m++) {
					for (n = 0; n < xmax; n++) {
						zPoly[h][n + xmax * m] = new Poly3D(S, "#FF0000",
								"#FFFFFF", "#000000", 1);
						zPoly[h][n + xmax * m].AddPoint(n, (m + 1),
								showtemp[h] + 1);
						zPoly[h][n + xmax * m].AddPoint((n + 1), (m + 1),
								showtemp[h] + 1);
						zPoly[h][n + xmax * m].AddPoint((n + 1), m,
								showtemp[h] + 1);
						zPoly[h][n + xmax * m].AddPoint(n, m, showtemp[h] + 1);
						zPoly[h][n + xmax * m].Id = arraylist[n + xmax * m];
						if (Number(arraylist[(zmax - h - 2) * xmax * ymax + n + xmax * m]) < 300 && Number(arraylist[(zmax - h - 2) * xmax * ymax + n + xmax * m]) > max)
							max = Number(arraylist[(zmax - h - 2) * xmax * ymax + n + xmax * m]);
						if (Number(arraylist[(zmax - h - 2) * xmax * ymax + n + xmax * m]) < min)
							min = Number(arraylist[(zmax - h - 2) * xmax * ymax + n + xmax * m]);
						var tempnumber = Number(arraylist[(zmax - h - 2) * xmax * ymax + n + xmax * m]);
						if (tempnumber != undefined && !isNaN(tempnumber)) {
							if(tempnumber<300){
							  sum += tempnumber;
							  num++;								
							}
						}
						zPoly[h][n + xmax * m].Update();
					}
				}
			} catch (e) {
			}
			if (num > 0 && !isNaN(sum)){
				if((sum / num).toFixed(2) >= 300){
				   $("#pingjunwen").append("<div class='div-control-height'>D-E</div>");
				}else{
				   $("#pingjunwen").append("<div class='div-control-height'>"+ (sum / num).toFixed(2) + "</div>");
				}
			}
			else
				$("#pingjunwen").append("<div class='div-control-height' style='color:black;'>D-E</div>");
			
			if (max > 50) {
				if(max>=300){
				   $("#zuigaowen").append("<div class='div-control-height' style='color: red;'>D-E</div>");
				}else{
				   $("#zuigaowen").append("<div class='div-control-height' style='color: red;'>"+ max + "</div>");
				}
			} else if (50 > max && max > 0)
				$("#zuigaowen").append("<div class='div-control-height'>" + max + "</div>");
			else
				$("#zuigaowen").append("<div class='div-control-height' style='color: red;'>"+ max + "</div>");
			
			if (min >= 100) {
				$("#zuidiwen").append("<div class='div-control-height'>D-E</div>");
			} else
				$("#zuidiwen").append("<div class='div-control-height'>" + min + "</div>");
		}
		S.AutoCenter();
		B.SetBorder(xmin, ymin, zmin, xmax, ymax, zmax);
		S.ChangeViewer(-20, -110);
		S.ChangeLight(-30, 30);
		S.OrderWeight.z = 0.01;
		S.Sort();
		S.Draw();

	}

	function UpdateFunction(id) {
		var h = Number(id.substr(4)) - 1, m, n;
		for (var i = 0; i < zPoly[h].length; i++) {
			if (zPoly[h][i]) {
				zPoly[h][i].Visibility = document.getElementById(id).checked ? "visible"
						: "hidden";
				//zPoly[h][i].Update();
			}
		}
		S.Sort();
		S.Draw();
	}

	function f(xx, yy) {
		x = xx;
		y = yy;
		var ff;
		ff = EvalSafe(document.forms[0].z.value);
		return (ff);
	}
	function EvalSafe(ss) {
		var jj = "";
		if (ss.indexOf("^") >= 0)
			return ("");
		try {
			with (Math)
				jj = eval(ss);
		} catch (error) {
			return ("");
		}
		return (jj);
	}
	function ChangeViewer(ttheta, ffi) {
		S.ChangeViewer(ttheta, ffi);
		S.Sort();
		S.Draw();
	}
	function ChangeLight(ttheta, ffi) {
		S.ChangeLight(ttheta, ffi);
		S.Draw();
	}
	function ZoomViewer(vv) {
		if ((viewerzoomed + vv > 5) || (viewerzoomed + vv < -5))
			return;
		viewerzoomed += vv;
		if (vv > 0)
			S.Dist *= 0.8;
		else
			S.Dist /= 0.8;
		S.Sort();
		S.Draw();
	}
	function Shift(hh, vv) {
		S.XM += hh;
		S.YM += vv;
		S.Draw();
	}
	function ZoomPicture(vv) {
		if ((picturezoomed + vv > 5) || (picturezoomed + vv < -5))
			return;
		picturezoomed += vv;
		if (vv > 0)
			S.ZoomAll *= 1.1;
		else
			S.ZoomAll /= 1.1;
		S.Draw();
	}

	var isRotating = false;
	var a;
	function clickxuanzhuan() {
		if (isRotating) {
			isRotating = false;
			$("#contr").attr('class', 'fa fa-pause fa-3x');
			clearInterval(a);
		} else {
			isRotating = true;
			$("#contr").attr('class', 'fa fa-square fa-3x');
			Rotate();
			a = setInterval("Rotate()", 200);
		}
	}

	function Rotate() {
		S.ChangeViewer(0, -5);
		S.ChangeLight(0, -5);
		S.Sort();
		S.Draw();
	}

	function checkshow(id) {
		UpdateFunction(id);

	}
</script>
<script type="text/javascript">
	var colorarr = [ '#00FF00', '#EEEE00', '#EE7621', '#FF3030', '#ADADAD' ];
	var namearr = [ '-10℃~10℃&nbsp;', '10℃~20℃&nbsp;', '20℃~30℃&nbsp;',
			'30℃~50℃&nbsp;', '数据异常&nbsp;' ];
	drowpanel(colorarr, namearr);
	function drowpanel(colorarr, namearr) {
		var results = "";
		for (var i = 0; i < colorarr.length; i++) {
			results += "<div class='color_line'>";
			results += "<div style='width:40%; height:20px;display:inline; float:left; text-align:right;'>"
					+ namearr[i] + "</div>";
			results += "<div style='width:30%; height:20px;background-color:"
					+ colorarr[i] + ";display:inline;float:left;'></div></div>";
		}
		results += "<div class='color_line'></div>";
		$("#contentss").html('');
		$("#contentss").append(results);
	}
	function trim(t) {
		return ltrim(rtrim(t));
	}
	function ltrim(t) {
		while (t.substring(0, 1) == " ")
			t = t.substring(1);
		return t;
	}
	function rtrim(t) {
		while (t.substring(t.length - 1) == " ")
			t = t.substring(0, t.length - 1);
		return t;
	}
	function bmAddOne(value) {
		var lens = value.length - 1;
		var fs = '';
		var str = value.substring(lens);
		if (str == "-") {
			value = value.substring(1);
			fs = "-";
			lens--;
		}
		if (value == '')
			return fs + "1";
		str = value.substring(lens);
		var left = value.substring(0, lens);
		var jg = '';
		if (str == ".")
			jg = fs + bmAddOne(left) + ".";
		else if (str == "9")
			jg = fs + bmAddOne(left) + "0";
		else if (!isNaN(str))
			jg = fs + left + '' + (eval(str) + 1);
		else
			jg = fs + "1";
		return jg;
	}
	function sswr_value(value, num) {//四舍五入
		var temp = value.toString();
		num = eval(num);
		if (temp.indexOf(".") == -1)
			temp += ".";
		temp += "000000000000000";
		var xsd = temp.indexOf(".");//小数点的位置
		var ws = xsd + num + 1;
		if (num == 0)
			ws--;
		var left = temp.substring(0, ws);
		var right = num == 0 ? temp.substring(ws + 1, ws + 2) : temp.substring(
				ws, ws + 1);
		if ("56789".indexOf(right) != -1)
			left = bmAddOne(left);
		if (eval(left) == 0)
			left = '';
		return left;
	}

	function toArr(str) {
		var d = new Array();
		var i = -1, j = 0;
		str = trim(str);
		while ((i = str.indexOf(' ')) != -1) {
			d[j++] = str.substring(0, i);
			str = trim(str.substring(i + 1));
		}
		if (trim(str) != '')
			d[j] = str;
		return d;
	}

	var _url = rootPath + '/warehouse/find.shtml';
	$(function() {
		var lys = eval('${warehouseFormMap.wHeight}');
		var lines = eval('${warehouseFormMap.wRow}');
		var cols = eval('${warehouseFormMap.wColumn}');
		
		var cnwd = eval('${warehouseFormMap.wTemperature}').toFixed(2);
		var cwwd = eval('${warehouseFormMap.gTemperature}').toFixed(2);
		var zgwd = eval('${warehouseFormMap.maxTemperature}').toFixed(2);
		var zdwd = eval('${warehouseFormMap.minTemperature}').toFixed(2);
		if(cnwd >= 300){
		    $('#cnwd').html('D-E');
		}else{
		    $('#cnwd').html(eval('${warehouseFormMap.wTemperature}').toFixed(2) + '℃');
		}
		if(cwwd >= 300){
		    $('#cwwd').html('D-E');
		}else{
		    $('#cwwd').html(eval('${warehouseFormMap.gTemperature}').toFixed(2) + '℃');
		}
		if(zgwd >= 300){
			$('#zgwd').html('D-E');
		}else{
			$('#zgwd').html(eval('${warehouseFormMap.maxTemperature}').toFixed(2) + '℃');
		}
		if(zdwd >= 300){
			$('#zdwd').html('D-E');
		}else{
			$('#zdwd').html(eval('${warehouseFormMap.minTemperature}').toFixed(2) + '℃');
		}
		
		$('#cnsd').html(eval('${warehouseFormMap.wHumidity}').toFixed(2) + 'RH');
		$('#cwsd').html(eval('${warehouseFormMap.gHumidity}').toFixed(2) + 'RH');
		
		var d = '${warehouseFormMap.wCoordinate}';
		if (d != '') {
			var dataarr = toArr(d);
			if (dataarr.length < lines * cols * lys) {
				alert("数据有误！");
			} else {
				drowSvgData(dataarr, cols, lines, lys);
			}
		}
	});

</script>

</html>
