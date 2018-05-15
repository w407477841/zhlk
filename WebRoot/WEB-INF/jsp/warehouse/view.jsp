<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<style>
.body_all {
	width: 100%;
}

.body_right {
	width: 30%;
	float: right;
}

.body_left {
	width: 70%;
	float: left;
}

.stage {
	box-sizing: content-box;
	perspective: 800px;
	/*初始视角*/
	perspective-origin: 50% 50%;
}

.container-box {
	box-sizing: content-box;
	width: 300px;
	height: 500px;
	margin: 100px auto;
	position: relative;
	transform-style: preserve-3d;
	transition: 3s;
	/*旋转基准点*/
	transform-origin: center center 150px;
	/*Mozilla内核浏览器：firefox3.5+*/
	-moz-transform-origin: center center 150px;
	/*Webkit内核浏览器：Safari and Chrome*/
	-webkit-transform-origin: center center 150px;
	/*Opera*/
	-o-transform-origin: center center 150px;
	/*IE9*/
	-ms-transform-origin: center center 150px;
	/*W3C标准*/
	transform-origin: center center 150px;
	
	transform : translateY(150px)  rotateX(-40deg);
}

.container-box .side-bottom {
	box-sizing: content-box;
	position: absolute;
	width: 200px;
	height: 160px;
	border: 1px solid #CFCFCF;
	text-align: center;
	line-height: 160px;
	background-color: #CFCFCF;
}

.container-box .side-right {
	box-sizing: content-box;
	position: absolute;
	width: 160px;
	height: 240px;
	border: 1px solid #CFCFCF;
	text-align: center;
	line-height: 240px;
	background-color: #CFCFCF;
}

.container-box .side-back {
	box-sizing: content-box;
	position: absolute;
	width: 200px;
	height: 240px;
	border: 1px solid #CFCFCF;
	text-align: center;
	line-height: 240px;
	background-color: #CFCFCF;
}

.container-box .side-layer {
	box-sizing: content-box;
	position: absolute;
	width: 200px;
	height: 240px;
	line-height: 240px;
	border: 1px solid #CFCFCF;
	text-align: center;
	background-color: #CFCFCF;
}

.right {
	left: 202px;
	box-sizing: content-box;
	/*围绕Y轴  */
	-moz-transform: rotateY(-90deg);
	-webkit-transform: rotateY(-90deg);
	-o-transform: rotateY(-90deg);
	-ms-transform: rotateY(-90deg);
	transform: rotateY(-90deg);
	/*旋转基点--X */
	-moz-transform-origin: left;
	-webkit-transform-origin: left;
	-o-transform-origin: left;
	-ms-transform-origin: left;
	transform-origin: left;
}

.bottom {
	top: 242px;
	box-sizing: content-box;
	/*围绕X轴*/
	-moz-transform: rotateX(90deg);
	-webkit-transform: rotateX(90deg);
	-o-transform: rotateX(90deg);
	-ms-transform: rotateX(90deg);
	transform: rotateX(90deg);
	/*旋转基点--Y*/
	-moz-transform-origin: top;
	-webkit-transform-origin: top;
	-o-transform-origin: top;
	-ms-transform-origin: top;
	transform-origin: top;
}

.back {
	box-sizing: content-box;
}

.layer {
	box-sizing: content-box;
	/*top:120px;*/
	/*围绕X轴*/
	-moz-transform: rotateX(90deg);
	-webkit-transform: rotateX(90deg);
	-o-transform: rotateX(90deg);
	-ms-transform: rotateX(90deg);
	transform: rotateX(90deg);
	/*旋转基点--Y*/
	-moz-transform-origin: top;
	-webkit-transform-origin: top;
	-o-transform-origin: top;
	-ms-transform-origin: top;
	transform-origin: top;
}

.blank {
	box-sizing: content-box;
	width: 39px;
	height: 39px;
	line-height: 40px;
	float: left;
	margin-right:1px;
	margin-bottom:1px;
	background-color: #E5E5E5;
}

.blank_fill {
	box-sizing: content-box;
	width: 39px;
	height: 39px;
	line-height: 40px;
	float: left;
	margin-right:1px;
	margin-bottom: 1px;
}

.content {
	width: 100%;
	float: left;
	border: 1px solid black;
	border-radius: 5px;
	margin-bottom: 20px;
}

.color_line {
	width: 100%;
	height: 20px;
	margin-top: 10px;
}

.line_text_left {
	width: 40px;
	height: 40px;
	line-height: 40px;
	text-align: left;
	float: left;
}

.line_text_right {
	width: 40px;
	height: 40px;
	line-height: 40px;
	float: left;
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

#condition {
	width: 100%;
}

#info {
	margin: 8px;
	width: 90%;
}

#info td {
	width: 10%;
	text-align: center;
	line-height: 16px;
	border-bottom: 1px solid gray;
}

#info th {
	width: 10%;
	line-height: 16px;
}

#infos td {
	width: 80px;
	text-align: center;
	line-height: 16px;
	border-bottom: 1px solid gray;
}

#infos th {
	width: 60px;
	line-height: 16px;
}

#f_rq {
	width: 120px;
}

#f_sj {
	width: 120px;
}

#tsdiv {
	position: absolute;
	top: 20px;
	left: 50px;
	width: 200px;
	height: 300px;
}

#tsdiv ul,#tsdiv li {
	padding: 0;
	text-align: left;
	list-style: none;
}
</style>
	<div class="body_all">
		<div class="body_left">
			<div class="box col-md-12" style="padding-left: 0px; padding-right: 0px;">
				<div class="box-inner">
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i> <span id="pageTitle"></span>
						</h2>
						<div class="box-icon">
							<a href="javascript:void(0)"
								class="btn btn-minimize btn-round btn-default"><i
								class="glyphicon glyphicon-chevron-up"></i> </a>
						</div>
					</div>
					<div class="box-content">
					<div class="stage" id="stage">
						<div class="container-box" id="container-box">
							<!-- back begin-->
							<div class="side-back back" id="back_line"></div>
							<!-- back begin-->

							<!-- right begin-->
							<div class="side-right right" id="right_line"></div>
							<!-- right end-->

							<!-- bottom begin-->
							<div class="side-bottom bottom" id="bottom_line"></div>
							<!-- bottom end-->
						</div>
					</div>
					</div>
				</div>
			</div>
			<div class="box col-md-12"  style="padding-left: 0px; padding-right: 0px;">
				<div class="box-inner">
					<div class="box-header well" data-original-title="">
						<h2>
							<i class="glyphicon glyphicon-tint"></i>仓库信息
						</h2>
						<div class="box-icon">
							<a href="javascript:void(0)"
								class="btn btn-minimize btn-round btn-default"><i
								class="glyphicon glyphicon-chevron-up"></i> </a>
						</div>
					</div>
				<div class="box-content">
                    
					<div>
					<h5>最高温度:<div id="maxs" style="width: 15%; display: inline-block;"></div> 
					 最低温度:<div id="mins" style="width: 15%; display: inline-block;"></div>
					 平均温度:<div id="avgs" style="width: 15%; display: inline-block;"></div>
					 </h5>
					</div>
					<div>
					<h5>
					 仓内温度:<div id="cnwd" style="width: 15%; display: inline-block;"></div> 
					 仓外温度:<div id="cwwd" style="width: 15%; display: inline-block;"></div> 
					 仓内湿度:<div id="cnsd" style="width: 15%; display: inline-block;"></div> 
					 仓外湿度:<div id="cwsd" style="width: 15%; display: inline-block;"></div> 
					 </h5>
					</div>
				</div>
				</div>
			</div>
		</div>
		<div class="body_right">
			<div class="row" >
				<div class="box col-md-12 tour" style="padding-right: 0px;">
					<div class="box-inner">
						<div class="box-header well" data-original-title="">
							<h2>
								<i class="glyphicon glyphicon-list-alt"></i> 温度参照示图：
							</h2>
							<div class="box-icon">
								<a href="javascript:void(0)"
									class="btn btn-minimize btn-round btn-default"><i
									class="glyphicon glyphicon-chevron-up"></i> </a>
							</div>
						</div>
						<div class="box-content">
							<div id='contentss'></div>
						</div>
					</div>
				</div>
				<!--/span-->
			</div>
			<!--/row-->

			<div class="row">
				<div class="box col-md-12 tour" style="padding-right: 0px;">
					<div class="box-inner">
						<div class="box-header well" data-original-title="">
							<h2>
								<i class="glyphicon glyphicon-move"></i> 旋转控制：
							</h2>
							<div class="box-icon">
								<a href="javascript:void(0)"
									class="btn btn-minimize btn-round btn-default"><i
									class="glyphicon glyphicon-chevron-up"></i> </a>
							</div>
						</div>
						<div class="box-content">
							<div class="operation_line">
								<input type="button" class="button icon icon-top"
									onclick="rotate('x',15)">
							</div>
							<div class="operation_line">
								<input type="button" class="button icon icon-left"
									onclick="rotate('z',-15)"> <input type="button"
									id="contr" class="button icon icon-no"
									style="transition: all 0s ease 0s;" onclick="run(this)">
								<input type="button" class="button icon icon-right"
									onclick="rotate('z',15)">
							</div>
							<div class="operation_line">
								<input type="button" class="button icon icon-bottom"
									onclick="rotate('x',-15)">
							</div>
						</div>
					</div>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
			<div class="row">
				<div class="box col-md-12 tour" style="padding-right: 0px;">
					<div class="box-inner">
						<div class="box-header well" data-original-title="">
							<h2>
								<i class="glyphicon glyphicon-th-large"></i> 请选择仓号：
							</h2>
							<div class="box-icon">
								<a href="javascript:void(0)"
									class="btn btn-minimize btn-round btn-default"><i
									class="glyphicon glyphicon-chevron-up"></i> </a>
							</div>
						</div>
						<div class="box-content">
							<div id="cks"></div>
						</div>
					</div>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
			<div class="row">
				<div class="box col-md-12 tour" style="padding-right: 0px;">
					<div class="box-inner">
						<div class="box-header well" data-original-title="">
							<h2>
								<i class="glyphicon glyphicon-transfer"></i> 请选择层：
							</h2>
							<div class="box-icon">
								<a href="javascript:void(0)"
									class="btn btn-minimize btn-round btn-default"><i
									class="glyphicon glyphicon-chevron-up"></i> </a>
							</div>
						</div>
						<div class="box-content">
							<div id='layers'></div>
						</div>
					</div>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
			<div class="row">
				<div class="box col-md-12 tour" style="padding-right: 0px;">
					<div class="box-inner">
						<div class="box-header well" data-original-title="">
							<h2>
								<i class="glyphicon glyphicon-time"></i> 请选择测温时间：
							</h2>
							<div class="box-icon">
								<a href="javascript:void(0)"
									class="btn btn-minimize btn-round btn-default"><i
									class="glyphicon glyphicon-chevron-up"></i> </a>
							</div>
						</div>
						<div class="box-content">
							检测日期:<select id='f_rq'></select><br /> 检测时点:<select id='f_sj'></select>
						</div>
					</div>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
			<div class="row">
				<div class="box col-md-12 tour" style="padding-right: 0px;">
					<div class="box-inner">
						<div class="box-header well" data-original-title="">
							<h2>
								<i class="glyphicon glyphicon-wrench"></i> 数据操作：
							</h2>
							<div class="box-icon">
								<a href="javascript:void(0)"
									class="btn btn-minimize btn-round btn-default"><i
									class="glyphicon glyphicon-chevron-up"></i> </a>
							</div>
						</div>
						<div class="box-content">
						<div class="row">
						   <div class="col-md-4">
							<button class="btn btn-primary" onclick='query();'>查询</button>
						   </div>
						   <div class="col-md-4">
							<button class="btn btn-info" onclick='print();'>打印</button>
						   </div>
						   <div class="col-md-4">
							<form class="form-inline" action="${pageContext.servletContext.contextPath}/warehouse/report.shtml"  method="post">
							<input type="hidden" id="p_id" name="pId">
							<input type="submit" class="btn btn-default" value="导出">
							</form>
						   </div>
						   </div>
						</div>
					</div>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
		</div>
	</div>
<script type="text/javascript">
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>
	<script type="text/javascript" charset='utf-8'>
		$('.btn-close').click(function(e) {
			e.preventDefault();
			$(this).parent().parent().parent().fadeOut();
		});
		$('.btn-minimize').click(
				function(e) {
					e.preventDefault();
					var $target = $(this).parent().parent()
							.next('.box-content');
					if ($target.is(':visible'))
						$('i', $(this)).removeClass('glyphicon-chevron-up')
								.addClass('glyphicon-chevron-down');
					else
						$('i', $(this)).removeClass('glyphicon-chevron-down')
								.addClass('glyphicon-chevron-up');
					$target.slideToggle();
		});
		var rootPath = "${pageContext.servletContext.contextPath}";
		//数据导出开始
		function export_op(){
			$.ajax({
				url:rootPath+'/warehouse/test.shtml',
				type:'POST',
				dataType:'json',
				success:function(data){
					layer.msg("success");
				},
				error:function(data){
					layer.msg("error");
				}
			});
		}
		//数据导出结束

	
		var swar = true;
		var tdq = null;
		var dsq = null;
		var _url = rootPath + '/warehouse/find.shtml';

		var degXs = -15;
		var degYs = 0;
		var _max = -1;
		var _min = -1;
		var _sum = 0;
		var trueCount =0;  //统计有效数据个数
		var timeout = false; //启动及关闭按钮 

		function rotate(type, degs) {
			timeout = true;
			$("#contr").attr('class', 'button icon icon-no');

			if (type == 'z') {
				degYs = (degs + degYs) % 360;
			}

			if (type == 'x') {
				degXs = (degs + degXs) % 360;
			}
			document.getElementById('container-box').style.transform = 'rotateX('
					+ degXs + 'deg) rotateY(' + degYs + 'deg) translateY(150px)' ;
		}

		//var degs = 0;

		function run(data) {
			if ($(data).attr('class') == 'button icon icon-no') {
				$(data).attr('class', 'button icon icon-ok');
				timeout = false;
			} else {
				$(data).attr('class', 'button icon icon-no');
				timeout = true;
			}
			;
			aaa();
		}
		var flg = false;
		function aaa() {
			if (timeout)
				return;
			runy();
			setTimeout(aaa, 2000); //time是指本身,延时递归调用自己,100为间隔调用时间,单位毫秒  

			//setInterval (runy(), 1000);
			function runy() {
				//degYs+=15;

				if (!flg) {
					degYs += 30;
					if (degYs > 90) {
						flg = true;
					}
				} else {
					degYs -= 30;
					if (degYs < -90) {
						flg = false;
					}
				}
				document.getElementById('container-box').style.transform = 'rotateY('
						+ degYs + 'deg) rotateX(' + degXs + 'deg) translateY(150px)';
			}
		}

		var rows, cols, lay; //行，列，层
		var blank_size = 40; //小方格大小

		var back_bg = $('#back_line');
		var right_bg = $('#right_line');
		var bottom_bg = $('#bottom_line');
		var container = $('#container-box');
		var consoleCon = $('#layers');
		var colorarr = [ '#00FF00', '#EEEE00', '#EE7621', '#FF3030','#ADADAD'];
		var namearr = [ '-10℃~10℃&nbsp;', '10℃~20℃&nbsp;', '20℃~30℃&nbsp;',
				'30℃~50℃&nbsp;','数据异常&nbsp;' ];

		function drowpanel(colorarr, namearr) {
			var results = "";
			for ( var i = 0; i < colorarr.length; i++) {
				results += "<div class='color_line'>";
				results += "<div style='width:50%; height:20px;display:inline; float:left; text-align:right;'>"
						+ namearr[i] + "</div>";
				results += "<div style='width:30%; height:20px;background-color:"
						+ colorarr[i]
						+ ";display:inline;float:left;'></div></div>";
			}
			results += "<div class='color_line'></div>";
			$("#contentss").html('');
			$("#contentss").append(results);
		}

		//initcontainer(5,7,4);
		//drowpanel(colorarr,namearr);
		//初始化侧面，线条，坐标
		function initcontainer(rows, cols, lay, arr) {
			lay++;
			trueCount = 0;
			_max = -1;
			var widths = cols * blank_size;
			var heights = rows * blank_size;
			var zHeights = lay * blank_size;
			back_bg.css("height", zHeights).css("width", widths).css(
					"line-height", zHeights);
			right_bg.css("height", zHeights).css("width", heights).css("left",
					widths + 2).css("line-height", zHeights);
			bottom_bg.css("height", heights).css("width", widths).css("top",
					zHeights + 2).css("line-height", heights);

			bottom_bg.html('');
			back_bg.html('');
			right_bg.html('');
			
			consoleCon.html('');
			$('.layer').remove();

			drow_bg_blank(bottom_bg, rows * cols, widths, heights);
			drow_bg_blank(right_bg, rows * lay, heights, zHeights);
			drow_bg_blank(back_bg, lay * cols, widths, zHeights);

			drow_bottom_x(bottom_bg, cols, widths, heights);
			drow_top_x(back_bg, cols, widths, heights);

			drow_bottom_y(bottom_bg, rows, widths, heights);
			drow_top_y(right_bg, rows, widths, heights);

			drow_right_z(right_bg, lay, zHeights, heights);
			drow_left_z(back_bg, lay, zHeights, heights);

			drow_data(lay, widths, heights, rows, cols, arr);
		}

		//侧面线条，bg_con：容器，countblank：方格改书，divwidth：宽，divheight：高
		function drow_bg_blank(bg_con, countblank, divwidth, divheight) {
			bg_con.html('');
			var results = "<div stype='width:"+divwidth+";height:"+divheight+";'>";
			for ( var i = 0; i < countblank; i++) {
				results += "<div class='blank'></div>";
			}
			results += "</div>";
			bg_con.append(results);
		}
		//bg_con:容器，wid：宽度，hei：高度
		//底部X轴
		function drow_bottom_x(bg_con, cols, wid, hei) {
			var results = "<div style='width:"+wid+"px;height:"+blank_size+"px;position:absolute;top:"+hei+"px;left:-"+blank_size/6+"px;'>";
			for ( var i = 0; i < cols - 1; i++) {
				results += "<div class='line_text_left'>";
				results += i;
				results += "</div>";
			}
			results += "<div class='line_text_left'>X</div>";
			results += "</div>";
			bg_con.append(results);
		}
		//bg_con:容器，wid：宽度，hei：高度
		//顶部X轴
		function drow_top_x(bg_con, cols, wid, hei) {
			var results = "<div style='width:"+wid+"px;height:"+blank_size+"px;position:absolute;top:-"+blank_size+"px;left:-"+blank_size/6+"px;'>";
			for ( var i = 0; i < cols - 1; i++) {
				results += "<div class='line_text_left'>";
				results += i;
				results += "</div>";
			}
			results += "<div class='line_text_left'>X</div>";
			results += "</div>";
			bg_con.append(results);
		}

		//bg_con:容器，wid：宽度，hei：高度
		//底部Y轴
		function drow_bottom_y(bg_con, cols, wid, hei) {
			var results = "<div style='width:"+blank_size+"px;height:"+hei+"px;position:absolute;left:-"+blank_size+"px;top:"+blank_size/3+"px;'>";
			results += "<div class='line_text_right'>Y</div>";
			for ( var i = 0; i < cols - 1; i++) {
				results += "<div class='line_text_right'>";
				results += cols - 2 - i;
				results += "</div>";
			}

			results += "</div>";
			bg_con.append(results);
		}

		//bg_con:容器，wid：宽度，hei：高度
		//顶部Y轴
		function drow_top_y(bg_con, cols, wid, hei) {
			var results = "<div style='width:"+hei+"px;height:"+blank_size+"px;position:absolute;top:-"+blank_size+"px;left:"+blank_size/3+"px;'>";
			results += "<div class='line_text_right'>Y</div>";
			for ( var i = 0; i < cols - 1; i++) {
				results += "<div class='line_text_right'>";
				results += cols - 2 - i;
				results += "</div>";
			}

			results += "</div>";
			bg_con.append(results);
		}

		//bg_con:容器，wid：宽度，hei：高度
		//右侧Z轴
		function drow_right_z(bg_con, cols, wid, hei) {
			var results = "<div style='width:"+blank_size+"px;height:"+wid+"px;position:absolute;left:"+hei+"px;top:"+blank_size/3+"px;'>";
			results += "<div class='line_text_right'>Z</div>";
			for ( var i = 0; i < cols - 1; i++) {
				results += "<div class='line_text_right'>";
				results += cols - 2 - i;
				results += "</div>";
			}

			results += "</div>";
			bg_con.append(results);
		}

		//bg_con:容器，wid：宽度，hei：高度
		//右侧Z轴
		function drow_left_z(bg_con, cols, wid, hei) {
			var results = "<div style='width:"+blank_size+"px;height:"+wid+"px;position:absolute;left:-"+blank_size+"px;top:"+blank_size/3+"px;'>";
			results += "<div class='line_text_right'>Z</div>";
			for ( var i = 0; i < cols - 1; i++) {
				results += "<div class='line_text_right'>";
				results += cols - 2 - i;
				results += "</div>";
			}
			results += "</div>";
			bg_con.append(results);
		}

		function drow_data(lay, wid, hei, rows, cols, arr) {
			var resu = "";
			_sum = 0;
			_min = -1;
			_max = -1;
			for ( var i = 0; i < lay - 1; i++) {
				drow_data_lay(i + 1, lay - i - 1, wid, hei, rows, cols, arr);
				resu += "<input type='radio' name='radioname' onclick='showdata("
						+ (lay-i-1) + ")'>";
				resu += "第 " + (i + 1) + " 层 &nbsp;&nbsp;";
				if(i%3==2)
				  resu += "<br/>";
			}
			//输出按钮
			consoleCon.append(resu);
			
			$('#maxs').html(_max+'℃');
            $('#mins').html(_min+'℃');
            $('#avgs').html(sswr_value(_sum/trueCount,2)+'℃');
		}
		//画层
		function drow_data_lay(lay_h, lay, wid, hei, rows, cols, arr) {
			var results = "<div class='side-layer layer' id='layer_"+lay_h+"' style='height:"+hei+"px;width:"+wid+"px;line-height:"+hei+"px;top:"+lay*blank_size+"px;'>";
			//results+=lay_h;
			results += "<div style='height:"+hei+";,width:"+wid+";'>";
			
			for ( var i = 0; i < rows * cols; i++) {
				var txt = arr[((lay - 1) * rows * cols + i)].toLowerCase();
				var num;
				if(!isCanConvertFloat(txt)){
					num = 300;
				}else{
					num = eval(arr[((lay - 1) * rows * cols + i)]);
				}
				//判断数据属否有效，无效数据部进行计算
				if(num>=-10 && num <=50){
					if(_min ==-1){
						_min = num;
					}
					if(num>_max){
					   _max = num;
					}else if(num<_min){
					   _min = num;
					}
					_sum+=num;
					trueCount++;
				}
				
				var colors = "";
				if (num >= -10 && num <= 10) {
					colors = colorarr[0];
				} else if (num > 10 && num <= 20) {
					colors = colorarr[1];
				} else if (num > 20 && num <= 30) {
					colors = colorarr[2];
				}else if (num > 30 && num <= 50) {
					colors = colorarr[3];
				} else {
					colors = colorarr[4];
					num='D-E';
				}
				results += "<div class='blank_fill' style='background-color:"+colors+"'>"
						+ num + "</div>";
			}
			results += "</div>";
			container.append(results);
		}

		//控制层显示
		function showdata(layid) {
			$('.layer').hide();
			$('#layer_' + layid).show();
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
				    if(t == null || t ==""){
				     
				    }else{
					var arr = $.trim(t).split(';');
					var s = arr.length;
					var li = null, inp = null, info = null;
					var p = $('#cks');
					var obj = null;
					//遍历库点
					for ( var i = 0; i < s; i++) {
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
						$('<span>' + info[1] + '&nbsp;&nbsp;</span>').appendTo(p);
						if(i%3==2)
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
				data : "action=date&f_kdbm=" + kd + "&f_ckbm=" + v_ck
						+ "&time=" + new Date(),
				success : function(t) {
				if(t == null || t==""){
				}else{
					var arr = $.trim(t).split(';');
					var s = arr.length;
					var li = null;
					for ( var i = 0; i < s; i++) {
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
			var right = num == 0 ? temp.substring(ws + 1, ws + 2) : temp
					.substring(ws, ws + 1);
			if ("56789".indexOf(right) != -1)
				left = bmAddOne(left);
			if (eval(left) == 0)
				left = '';
			return left;
		}
		function toDate(v) {
			return v.substring(0, 4) + '年' + eval(v.substring(4, 6)) + '月'
					+ eval(v.substring(6)) + '日';
		}
		function toTime(v) {
			return v.substring(0, 2) + '时' + eval(v.substring(2, 4)) + '分'
					+ eval(v.substring(4)) + '秒';
		}
		
		function isCanConvertFloat(str){
			if(isNaN(str)){
				return false;
			}else{
				return true;
			}
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
				 if(t == null || t == ""){
				 }else{
				
					var arr = $.trim(t).split(';');
					var s = arr.length;
					var li = null;
					for ( var i = 0; i < s; i++) {
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
					for ( var i = 0; i < s - 1; i++) {
						j = arr[i].indexOf('=');
						k = arr[i].substring(0, j);
						v = arr[i].substring(j + 1);
						v = sswr_value(v,2); 
						if(k=='cnwd' || k=='cwwd'){
							$('#' + k).html(v+'℃');
						}else if(k=='cnsd' || k=='cwsd'){
							$('#' + k).html(v+'RH');
						}else if(k=='p_id'){
							
							$('#' + k).val(v.substring(0,v.indexOf('.')));
						}
						
					}
					var d = arr[s - 1].substring(6);
					if (d != '') {
						var dataarr = toArr(d);
					    if(dataarr.length<lines*cols*lys){					    
					    alert("数据有误！");
					    }else{
						initcontainer(lines, cols, lys, dataarr);
						drowpanel(colorarr, namearr);
					    }
						//createCanvas(p,lys,lines,cols,lk,lg,'blue',d);
					}
				}
			});
		}

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
	</script>
