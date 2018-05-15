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
	height: 55px;
	text-align: center;
}

.icon {
	background: url(${pageContext.servletContext.contextPath}/img/play1.png)
		no-repeat; /*url为png图片的路径*/
	/*width和line-height分别对应每个小图标的宽和高*/
	width: 55px;
	height: 53px;
	display: inline-block;
}

.icon-left { /*png图片左上角为原点,往右往下均为负值*/
	background-position: -3px -67px; /*对应小图标的坐标*/
}

.icon-right { /*png图片左上角为原点,往右往下均为负值*/
	background-position: -148px -67px; /*对应小图标的坐标*/
}

.icon-top { /*png图片左上角为原点,往右往下均为负值*/
	background-position: -73px -3px; /*对应小图标的坐标*/
}

.icon-bottom { /*png图片左上角为原点,往右往下均为负值*/
	background-position: -73px -140px; /*对应小图标的坐标*/
}

.icon-ok { /*png图片左上角为原点,往右往下均为负值*/
	background-position: -73px -70px; /*对应小图标的坐标*/
}

.icon-no { /*png图片左上角为原点,往右往下均为负值*/
	background-position: -147px -3px; /*对应小图标的坐标*/
}

.button {
	border: none;
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
<script charset="utf-8" src="${ctx}/js/jquery.js"></script>
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
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span>三位展示</span>
						</h2>
					</div>
					<div class="box-content">
					<div style="height: 100px;">
					<div style="width: 90%;">
					<h5>最高温度:<div id="maxs" style="width: 15%;height:10px; display: inline-block;"></div> 
					 最低温度:<div id="mins" style="width: 15%;height:10px; display: inline-block;"></div>
					 平均温度:<div id="avgs" style="width: 15%;height:10px; display: inline-block;"></div>
					 </h5>
					</div>
					<div>
					<h5>
					 仓内温度:<div id="cnwd" style="width: 15%;height:10px; display: inline-block;"></div> 
					 仓外温度:<div id="cwwd" style="width: 15%;height:10px; display: inline-block;"></div> 
					 仓内湿度:<div id="cnsd" style="width: 15%;height:10px; display: inline-block;"></div> 
					 仓外湿度:<div id="cwsd" style="width: 15%;height:10px; display: inline-block;"></div> 
					 </h5>
					</div>
					</div>
					<div>
						<embed width='100%' height='500' name='Scene1'  id="3dshow"
							src='${ctx}/warehouse/getSVG.shtml' wmode='transparent'
							type='image/svg+xml'
							pluginspage="http://www.adobe.com/svg/viewer/install/"/>
					</div>
					</div>
				</div>
			</div>
		</div>
		<div class="body_right">
		<div class="col-md-6">
		   <div class="box col-md-12 no-padding">
				<div class="box-inner">
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span>请选择仓号</span>
						</h2>
					</div>
					<div class="box-content">
						<div id="cks"></div>
					</div>
				</div>
			</div>
			<div class="box col-md-12 no-padding">
				<div class="box-inner">
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span>请选择层</span>
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
							<i class="glyphicon glyphicon-tint"></i> <span>请选择测温时间</span>
						</h2>
					</div>
					<div class="box-content">
						检测日期:<select id='f_rq' style="width: 60%;"></select><br /> <br />
						检测时点:<select id='f_sj' style="width: 60%;"></select>
					</div>
				</div>
			</div>
			<div class="box col-md-12 no-padding">
				<div class="box-inner">
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span>数据操作</span>
						</h2>
					</div>
					<div class="box-content">
						<button class="btn btn-primary" onclick='query();'>查询</button>
						<button class="btn btn-info" onclick='print();'>打印</button>
						<button class="btn btn-default" onclick='print();'>导出</button>
						<!-- 
							<form class="form-inline" role="form" action="${pageContext.servletContext.contextPath}/warehouse/report.shtml"  method="post">
							<input type="hidden" id="p_id" name="pId">
							<input type="submit" class="btn btn-default" value="导出">
					</form>
					 -->
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
		<div class="box col-md-12 no-padding">
				<div class="box-inner">
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span>温度参照图</span>
						</h2>
					</div>
					<div class="box-content">
						<div id='contentss'></div>
					</div>
				</div>
			</div>
			<div class="box col-md-12 no-padding">
				<div class="box-inner">
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span>旋转控制</span>
						</h2>
					</div>
					<div class="box-content">
						<div class="operation_line">
							<input type="button" class="button icon icon-top"
								onclick="ChangeViewer(10,0)">
						</div>
						<div class="operation_line">
							<input type="button" class="button icon icon-left"
								onclick="ChangeViewer(0,-5)"> <input type="button"
								id="contr" class="button icon icon-ok"
								style="transition: all 0s ease 0s;" onclick="clickxuanzhuan()">
							<input type="button" class="button icon icon-right"
								onclick="ChangeViewer(0,5)">
						</div>
						<div class="operation_line">
							<input type="button" class="button icon icon-bottom"
								onclick="ChangeViewer(-10,0)">
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</div>


	<div class="row">
		<!--/span-->
		<div class="col-md-8">
			<form action="" method="post" id="formn1">
				<div id="div1" style="display: block">
					<input type="hidden" id="siteid" value="" /> <input type="hidden"
						id="xh" value="" /> <input type="hidden" id="storageid" value="}" />
					<input type="hidden" id="sectionCount" value="7" /> <input
						type="hidden" id="layerCount" value="4" /> <input type="hidden"
						id="colCount" value="7" />

					<div class="titileDiv">
						<img src="images/3dleft.png" style="width: 555px; height: 58px;" />
						<div class="myfont"
							style="width: 85px; height: 29px;  line-height: 29px; position: absolute; z-index: 120; top: 10px; left: 8px; font-size: 11px; text-align: center; black; font-weight: 900;">
							品种</div>

						<div
							style="width: 45px; height: 29px;  line-height: 29px; position: absolute; z-index: 120; top: 10px; left: 113px; font-size: 11px; text-align: center; black; font-weight: 900;">
							气温</div>
						<div
							style="width: 45px; height: 29px;  line-height: 29px; position: absolute; z-index: 120; top: 10px; left: 160px; font-size: 11px; text-align: center; black; font-weight: 900;">
							气湿</div>
						<div
							style="width: 45px; height: 29px;  line-height: 29px; position: absolute; z-index: 120; top: 10px; left: 207px; font-size: 11px; text-align: center; black; font-weight: 900;">
							仓温</div>
						<div
							style="width: 45px; height: 29px;  line-height: 29px; position: absolute; z-index: 120; top: 10px; left: 254px; font-size: 11px; text-align: center; black; font-weight: 900;">
							仓湿</div>
						<div
							style="width: 45px; height: 29px;  line-height: 12px; position: absolute; z-index: 120; top: 10px; left: 304px; font-size: 11px; text-align: center; black; font-weight: 900;">
							平均 <br /> 粮温
						</div>
						<div
							style="width: 45px; height: 29px;  line-height: 12px; position: absolute; z-index: 120; top: 10px; left: 354px; font-size: 11px; text-align: center; black; font-weight: 900;">
							最高 <br /> 粮温
						</div>
						<div
							style="width: 45px; height: 29px;  line-height: 12px; position: absolute; z-index: 120; top: 10px; left: 404px; font-size: 11px; text-align: center; black; font-weight: 900;">
							最低 <br /> 粮温
						</div>
						<div
							style="width: 45px; height: 29px;  line-height: 29px; position: absolute; z-index: 120; top: 10px; left: 454px; font-size: 11px; text-align: center; black; font-weight: 900;">
							库存(吨)</div>

						<div
							style="width: 90px; height: 29px;  line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 7px; font-size: 12px; text-align: center;  font-weight: 900;">
							粳稻谷</div>


						<div id="qw"
							style="width: 50px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 110px; font-size: 13px; text-align: center;  font-weight: 900;">
							14.9℃</div>
						<div id="qs"
							style="width: 40px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 162px; font-size: 13px; text-align: center;  font-weight: 900;">
							97.4%</div>
						<div id="cw"
							style="width: 50px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 205px; font-size: 13px; text-align: center;  font-weight: 900;">
							20.3℃</div>
						<div id="cs"
							style="width: 50px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 252px; font-size: 13px; text-align: center;  font-weight: 900;">
							78.4%</div>
						<div id="avgLw"
							style="width: 50px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 305px; font-size: 13px; text-align: center;  font-weight: 900;">
							13.2℃</div>
						<div id="maxLw"
							style="width: 50px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 357px; font-size: 13px; text-align: center;  font-weight: 900;">

						</div>
						<div id="minLw"
							style="width: 50px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 407px; font-size: 13px; text-align: center;  font-weight: 900;">

						</div>
						<div id="minLw"
							style="width: 50px; height: 29px; line-height: 29px; position: absolute; z-index: 120; top: 30px; left: 457px; font-size: 13px; text-align: center;  font-weight: 900;">
							2238.0</div>
					</div>
					<div style="margin-top:70px">
						<table width="100%" cellpadding="0" cellspacing="0" align="left">
							<tr>
								<td colspan="2">
									<table width="100%" cellpadding="0" cellspacing="0"
										align="left" style="border: 0px; margin-left: 0px;"
										class="con" id="demo">
										<tr>
											<td colspan="4">
												<table>
													<tr>
														<td vlign="top"></td>
														<td valign="top">
															<table border=0
																style="margin-top: 0px; margin-right: 50px;">

															</table>
														</td>
													</tr>

												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>

<script type="text/javascript">
	
	$(document).ready(function() {
		if (parseFloat("14.9") > 50) {
			$("#maxLw").html("*");
		} else {
			$("#maxLw").html("14.9" + "℃");
		}
		if (parseFloat("9.3") < 0) {
			$("#minLw").html("*");
		} else {
			$("#minLw").html("9.3" + "℃");
		}
	});
	 function fresh() {
         $("#3dshow").html("<embed width='100%' height='500' name='Scene1' src='${ctx}/warehouse/getSVG.shtml' wmode='transparent' type='image/svg+xml' pluginspage='http://www.adobe.com/svg/viewer/install/'/>");
        // $("#3dshow").load();
     }  
	var S, B;
	var arraylist = [];
	var orderno;
	var code;

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

	function drowSvgData(dataarr,col,row,layer) {
		// fresh();
		$("#cengshuTd").html("");
		$("#pingjunwen").html("");
		$("#zuigaowen").html("");
		$("#zuidiwen").html("");
		//$(".Scene1").html("");
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
		ZoomPicture(1);

	}

	function random(vv) {
		return (Math.floor(Math.random() * vv));
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
						if (Number(arraylist[(zmax - h - 2) * xmax * ymax + n
								+ xmax * m]) > max)
							max = Number(arraylist[(zmax - h - 2) * xmax * ymax
									+ n + xmax * m]);
						if (Number(arraylist[(zmax - h - 2) * xmax * ymax + n
								+ xmax * m]) < min)
							min = Number(arraylist[(zmax - h - 2) * xmax * ymax
									+ n + xmax * m]);
						var tempnumber = Number(arraylist[(zmax - h - 2) * xmax
								* ymax + n + xmax * m]);
						if (tempnumber != undefined && !isNaN(tempnumber)) {
							sum += tempnumber;
							num++;
						}
						zPoly[h][n + xmax * m].Update();
					}
				}
			} catch (e) {
			}
			if (num > 0 && !isNaN(sum))
				$("#pingjunwen").append(
						"<div class='div-control-height'>"
								+ (sum / num).toFixed(2) + "</div>");
			else
				$("#pingjunwen")
						.append(
								"<div class='div-control-height' style='color:black;'>ER</div>");
			if (max > 50) {
				$("#zuigaowen").append(
						"<div class='div-control-height' style='color: red;'>"
								+ max + "</div>");
			} else if (50 > max && max > 0)
				$("#zuigaowen").append(
						"<div class='div-control-height'>" + max + "</div>");
			else
				$("#zuigaowen").append(
						"<div class='div-control-height' style='color: red;'>"
								+ max + "</div>");
			if (min < 0) {
				$("#zuidiwen").append(
						"<div class='div-control-height'>" + min + "</div>");
			} else if (0 < min && min < 100) {
				$("#zuidiwen").append(
						"<div class='div-control-height'>" + min + "</div>");
			} else
				$("#zuidiwen").append(
						"<div class='div-control-height'>" + min + "</div>");
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
			$("#contr").attr('class', 'button icon icon-ok');
			clearInterval(a);
		} else {
			isRotating = true;
			$("#contr").attr('class', 'button icon icon-no');
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
	function toDate(v) {
		return v.substring(0, 4) + '年' + eval(v.substring(4, 6)) + '月'
				+ eval(v.substring(6)) + '日';
	}
	function toTime(v) {
		return v.substring(0, 2) + '时' + eval(v.substring(2, 4)) + '分'
				+ eval(v.substring(4)) + '秒';
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
		var right = num == 0 ? temp.substring(ws + 1, ws + 2) : temp
				.substring(ws, ws + 1);
		if ("56789".indexOf(right) != -1)
			left = bmAddOne(left);
		if (eval(left) == 0)
			left = '';
		return left;
	}
	
	var _url = rootPath + '/warehouse/find.shtml';
	var kd = null;
	$(function() {
		window.moveTo(0, 0);
		var w = screen.width;
		var h = screen.height;
		window.resizeTo(w, h);
		kd = "${param.kd}";
		var ck = "${param.ck}";
		//alert(kd+"-"+ck);
		if (kd == null || ck == null) {
			if (window.opener != null)
				self.close();
			else
				history.go(-1);
		} else {
			findck(ck);
		}
	});
	//得到仓库信息，如果ck == null 选择第一个，否则选中ck
	//参数action=ckda 表示查询仓库数据
	function findck(ck) {
		$.ajax({
			type : "POST",
			url : _url,
			async : false,
			data : "action=ckda&f_kdbm=" + kd + "&time=" + new Date(),
			success : function(t) {
				//console.log(t);
				if (t == null || t == "") {

				} else {
					var arr = $.trim(t).split(';');
					var s = arr.length;
					var li = null, inp = null, info = null;
					var p = $('#cks');
					var obj = null;
					//遍历库点
					for (var i = 0; i < s; i++) {
						info = arr[i].split(' ');
						//console.log(info);
						if (info.length == 1)
							continue;

						inp = $('<input type="radio">').attr({
							'name' : 'ckbm',
							'title' : info[0],
							'lys' : info[2],
							'cols' : info[3],
							'lines' : info[4]
						}).val(info[0]).appendTo(p);
						$('<span>' + info[1] + '&nbsp;&nbsp;</span>').appendTo(
								p);
						if (i % 3 == 2)
							$('<br/>').appendTo(p);
						inp.click(function() {
							findrq();
						});
						if (ck == null || ck == '') {
							if (i == 0) {
								obj = inp;
								obj.attr('checked', true);
							}
						} else if (info[0] == ck) {
							obj = inp;
							obj.attr('checked', true);
						}
					}
					if (obj != null) {
						findrq();
					}
				}
			}
		});
	}

	//根据仓库得到日期
	//action = date 表示查询仓库日期
	function findrq() {
		var obj = $('#cks').find('input:checked');
		if (obj.length == 0) {
			alert('请选择仓库!');
			return false;
		}
		var v_ck = obj.val();
		var p = $('#f_rq').html('');
		$('#f_sj').html('');
		$.ajax({
			type : "POST",
			url : _url,
			async : false,
			data : "action=date&f_kdbm=" + kd + "&f_ckbm=" + v_ck + "&time="
					+ new Date(),
			success : function(t) {
				if (t == null || t == "") {
				} else {
					var arr = $.trim(t).split(';');
					var s = arr.length;
					var li = null;
					for (var i = 0; i < s; i++) {
						if (trim(arr[i]) == '')
							continue;
						li = $('<option>').html(toDate(arr[i])).val(arr[i])
								.appendTo(p);
					}
					p.change(function() {
						findtime();
					});
					findtime();
				}
			}
		});
	}

	var fst = true;
	//根据仓库编号和日期获取时间
	//action = time 获取时间
	function findtime() {
		var f_rq = $('#f_rq').val();
		var obj = $('#cks').find('input:checked');
		if (obj.length == 0) {
			alert('请选择仓库!');
			return false;
		}
		var ck = obj.val();
		var p = $('#f_sj').html('');
		var val = "action=time&f_kdbm=" + kd + "&f_ckbm=" + ck + "&f_rq="
				+ f_rq + "&time=" + new Date();
		$.ajax({
			type : "POST",
			url : _url,
			async : false,
			data : val,
			success : function(t) {
				if (t == null || t == "") {
				} else {

					var arr = $.trim(t).split(';');
					var s = arr.length;
					var li = null;
					for (var i = 0; i < s; i++) {
						if (arr[i] == '')
							continue;
						li = $('<option>').html(toTime(arr[i])).val(arr[i])
								.appendTo(p);
					}
				}
			}
		});
		if (fst) {
			fst = false;
			query();
		}
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

	function query() {//查询详细数据
		var obj = $('#cks').find('input:checked');
		if (obj.length == 0) {
			alert('请选择仓库!');
			return false;
		}
		var param = "action=info&f_kdbm=" + kd + "&f_ckbm=" + obj.val();
		param += "&f_rq=" + $('#f_rq').val();
		param += "&f_sj=" + $('#f_sj').val();
		param += "&time=" + new Date();
		$.ajax({
			type : "POST",
			url : _url,
			async : true,
			data : param,
			success : function(t) {
				var arr = $.trim(t).split(';');

				var lys = eval(obj.attr('lys'));
				var lines = eval(obj.attr('lines'));
				var cols = eval(obj.attr('cols'));

				//var lk = 48, lg = 30;
				var s = arr.length;

				var j = -1;
				var k = null, v = null;
				for (var i = 0; i < s - 1; i++) {
					j = arr[i].indexOf('=');
					k = arr[i].substring(0, j);
					v = arr[i].substring(j + 1);
					v = sswr_value(v, 2);
					if (k == 'cnwd' || k == 'cwwd') {
						$('#' + k).html(v + '℃');
					} else if (k == 'cnsd' || k == 'cwsd') {
						$('#' + k).html(v + 'RH');
					} else if (k == 'p_id') {

						$('#' + k).val(v.substring(0, v.indexOf('.')));
					}

				}
				var d = arr[s - 1].substring(6);
				if (d != '') {
					var dataarr = toArr(d);
					if (dataarr.length < lines * cols * lys) {
						alert("数据有误！");
					} else {
						drowSvgData(dataarr,cols,lines,lys);
						//console.log(dataarr);
					}
					//createCanvas(p,lys,lines,cols,lk,lg,'blue',d);
				}
			}
		});
	}
	
	function query1() {//查询详细数据
		$("#3dshow").empty();
		$("#3dshow").attr("src","${ctx}/warehouse/getSVG.shtml");
		var obj = $('#cks').find('input:checked');
		if (obj.length == 0) {
			alert('请选择仓库!');
			return false;
		}
		var param = "action=info&f_kdbm=" + kd + "&f_ckbm=" + obj.val();
		param += "&f_rq=" + $('#f_rq').val();
		param += "&f_sj=" + $('#f_sj').val();
		param += "&time=" + new Date();
		$.ajax({
			type : "POST",
			url : _url,
			async : true,
			data : param,
			success : function(t) {
				var arr = $.trim(t).split(';');

				var lys = eval(obj.attr('lys'));
				var lines = eval(obj.attr('lines'));
				var cols = eval(obj.attr('cols'));

				//var lk = 48, lg = 30;
				var s = arr.length;

				var j = -1;
				var k = null, v = null;
				for (var i = 0; i < s - 1; i++) {
					j = arr[i].indexOf('=');
					k = arr[i].substring(0, j);
					v = arr[i].substring(j + 1);
					v = sswr_value(v, 2);
					if (k == 'cnwd' || k == 'cwwd') {
						$('#' + k).html(v + '℃');
					} else if (k == 'cnsd' || k == 'cwsd') {
						$('#' + k).html(v + 'RH');
					} else if (k == 'p_id') {

						$('#' + k).val(v.substring(0, v.indexOf('.')));
					}

				}
				var d = arr[s - 1].substring(6);
				if (d != '') {
					var dataarr = toArr(d);
					if (dataarr.length < lines * cols * lys) {
						alert("数据有误！");
					} else {
						drowSvgData(dataarr,cols,lines,lys);
						//console.log(dataarr);
					}
					//createCanvas(p,lys,lines,cols,lk,lg,'blue',d);
				}
			}
		});
	}
</script>

</html>
