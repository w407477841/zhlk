<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<style>
.form-control {
	padding: 0px 12px
}

* {
	margin: 0;
	padding: 0;
}

.btn {
	font-size: 12px;
}

#page {
	font: 16px/1 'Open Sans', sans-serif;
	color: #555;
	background: #e5e5e5;
}

.togglebox {
	width: 100%;
	margin: 0 auto;
	background: #fff;
	transform: translateZ(0);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .1);
}

input[type="radio"] {
	position: absolute;
	opacity: 0;
}

label {
	position: relative;
	display: block;
	height: 50px;
	line-height: 50px;
	padding: 0 20px;
	font-size: 14px;
	font-weight: 700;
	border-top: 1px solid #ddd;
	background: #fff;
	cursor: pointer;
	margin: 0;
}

label[for*='1'] {
	border: 0;
}

label:after {
	content: '\e113';
	position: absolute;
	top: 0px;
	right: 20px;
	font-family: 'Glyphicons Halflings';
	transform: rotate(-90deg);
	transition: 0.3s transform;
}

section {
	height: 0;
	transition: 0.3s all;
	overflow: hidden;
	background: #f6f6f6;
}

#content1>div,#content2>div,#content3>div,#content4>div,#content6>div,#content5>div
	{
	margin-top: 10px;
	display: flex;
	flex-flow: row wrap;
	align-items: center;
	justify-content: flex-start;
	align-content: flex-start
}

#content2>div::nth-child(2) {
	
}

#toggle1:checked  ~ label[for*='1']:after,#toggle2:checked  ~ label[for*='2']:after,#toggle3:checked  
	~ label[for*='3']:after,#toggle4:checked  ~ label[for*='4']:after,#toggle6:checked  
	~ label[for*='6']:after,#toggle5:checked  ~ label[for*='5']:after {
	transform: rotate(-180deg);
}

#toggle1:checked ~ #content1 {
	height: 680px;
}

#toggle2:checked ~ #content2 {
	height: 120px;
}

#toggle3:checked ~ #content3 {
	height: 120px
}

#toggle4:checked  ~ #content4 {
	height: 680px
}

#toggle5:checked  ~ #content5 {
	height: 590px
}

#toggle6:checked ~ #content6 {
	height: 120px
}

p {
	margin: 15px 0;
	padding: 0 20px;
	font-size: 12px;
	line-height: 1.5;
}

#content1 input,#content2 input,#content3 input,#content4 input,#content5 input
	{
	height: 32px;
}

.chosen-single {
	height: 32px;
	border-radius: 4px;
}

.s-detil-inst {
	height: 0;
	padding: 0;
	min-height: 0px;
	display: flex;
	flex-flow: row wrap;
	align-items: center;
	margin: 0 4px;
	transition: all .5s;
	overflow: hidden;
}

.desc-span {
	font-weight: bold;
}

.output {
	display: flex;
	justify-content: flex-end;
	width: 100%;
	color: red;
}

.no_padding {
	padding-left: 0px;
	padding-right: 0px;
}

.slider-h {
	margin-top: 10px;
	height: 22px;
}

.chosen-container-single .chosen-single {
	height: 38px;
}
</style>
<script language="javascript">
	(function() {
		var mac = '${mac_addr}';
		if (mac == null || mac == '') {
			layer.alert('未获得本机MAC地址，请查看本机程序是否运行！若未启动，请启动后重新登录！', {
				icon : 7
			});
		}
	})();
	var str;
	function doopen() {
		var Port = document.getElementById("ComName").value;
		var Baud = document.getElementById("BaudRate").value;
		var sum = TUHFReader09.Open(Port, Baud);
		if (sum == "00") {
			$("#txtReceive").val("设备连接成功");
			doquery();
		} else if (sum == "35") {
			$("#txtReceive").val("设备已连接");
			doquery();
		} else
			$("#txtReceive").val("设备连接失败");
	}
	function doclose() {
		var sum = TUHFReader09.Close();
		if (sum == "00")
			$("#txtReceive").val($("#txtReceive").val() + "\r\n设备关闭成功");
		else
			$("#txtReceive").val($("#txtReceive").val() + "\r\n设备关闭失败");
	}
	function doquery() {
		var sum = TUHFReader09.Inventory();
		if (sum == "") {
			$("#txtReceive").val($("#txtReceive").val() + "\r\n未询查到电子标签");
		} else {
			$("#txtReceive").val($("#txtReceive").val() + "\r\n询查到电子标签");
			$("#txtReceive").val($("#txtReceive").val() + "\r\n" + sum);
			$("#txtReceive").val(
					$("#txtReceive").val() + "\r\n" + sum.substr(2, 32));
			doRead(sum);
		}
	}
	function doRead(Temp) {
		if (Temp == "")
			return;

		var WordPtr = $("#SnWpt").val();
		if (WordPtr == "")
			return;

		var WordNum = $("#SnNum").val();
		if (WordNum == "")
			return;

		var EPC_Len = parseInt(Temp.substr(0, 2), 16);
		var EPC = Temp.substr(2, EPC_Len * 2);
		var Mem = 1;

		var sum = TUHFReader09.Read(EPC, WordPtr, WordNum, Mem);

		if (sum == "") {
			$("#txtReceive").val($("#txtReceive").val() + "\r\n读数据失败");
			$("#txtReceive").val($("#txtReceive").val() + "\r\n" + sum);
		} else {
			$("#txtReceive").val($("#txtReceive").val() + "\r\n读数据成功");
			$("#txtReceive").val($("#txtReceive").val() + "\r\n" + sum);
			$("#txtReceive").val($("#txtReceive").val() + "\r\n" + EPC);
		}
		doclose();
	}

	function save_setting() {
		var port = $("#ComName").val();
		var rate = $("#BaudRate").val();
		var start = $("#SnWpt").val();
		var num = $("#SnNum").val();
		var remark = $("#remark").val();
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : rootPath + '/config/carConfig.shtml',
			data : {
				port : port,
				rate : rate,
				start : start,
				num : num,
				remark : remark
			},
			success : function(data) {
				if (data == 'success') {
					layer.alert("保存成功！", {
						icon : 6
					});
				} else {
					layer.alert("保存失败！", {
						icon : 5
					});
				}
			},
			error : function(data) {
				layer.alert("保存失败！", {
					icon : 5
				});
			}
		});
	}
	//一卡通启用设置
	function oneCar_setting() {
		var usedOrNot = $("#usedOrNot").is(':checked') ? '1' : '2';
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : rootPath + '/config/oneCardSetting.shtml',
			data : {
				usedOrNot : usedOrNot
			},
			success : function(data) {
				if (data == 'success') {
					layer.alert("设置成功！", {
						icon : 6
					});
				} else {
					layer.alert("设置失败！", {
						icon : 5
					});
				}
			},
			error : function(data) {
				layer.alert("设置失败！", {
					icon : 5
				});
			}
		});
	}
	//地磅视频添加
	function shipin_add() {
		$("#weighingVideoid").val("");
		shipin_save();
	}
	//地磅视频修改或添加
	function shipin_save() {
		var szIP = $("#ipAddress").val(), szPort = $("#ipPort").val(), szUsername = $(
				"#userName").val(), szPassword = $("#password").val(), szRemark = $(
				"#szRemark").val(), szMac = $("#macaddress").val(), szThrough = $(
				"#throughPort").val(), screenshotPath = $("#screenshotPath")
				.val(), id = $("#weighingVideoid").val(), turnweighing = $(
				"#turnweighing").is(':checked') ? '1' : '2', printType = $(
				"#printType").is(':checked') ? '1' : '2';
		if (szMac == null || szMac == '') {
			layer.alert("无MAC地址！", {
				icon : 5
			});
		} else {
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : rootPath + '/config/shipinSetting.shtml',
				data : {
					port : szPort,
					ip : szIP,
					userName : szUsername,
					password : szPassword,
					remark : szRemark,
					through : szThrough,
					mac : szMac,
					turnweighing : turnweighing,
					screenshotPath : screenshotPath,
					id : id,
					printType : printType
				},
				success : function(data) {
					if (data == 'success') {
						layer.alert("保存成功！", {
							icon : 6
						});
					} else {
						layer.alert("保存失败！", {
							icon : 5
						});
					}
				},
				error : function(data) {
					layer.alert("保存失败！", {
						icon : 5
					});
				}
			});
		}

	}
	//称重语音控制
	function speech_control() {
		var mac = $("#vmacAddress").val();
		var isOpen = $("#isOpen").is(':checked') ? '1' : '2';
		var speechRate = $("#speechRate").val();
		var speechContent = $("#speechContent").val();
		var speechRemark = $("#speechRemark").val();
		if (mac == null || mac == '') {
			layer.alert("无MAC地址！", {
				icon : 5
			});
		} else {
			$.ajax({
				url : rootPath + '/config/addOrUpdateSpeck.shtml',
				type : 'post',
				dataType : 'json',
				data : {
					mac : mac,
					isOpen : isOpen,
					speechRate : speechRate,
					speechContent : speechContent,
					speechRemark : speechRemark
				},
				success : function(data) {
					if (data == 'success') {
						layer.alert("保存成功！", {
							icon : 6
						});
					} else {
						layer.alert("保存失败！", {
							icon : 5
						});
					}
				},
				error : function(data) {
					layer.alert("保存失败！", {
						icon : 5
					});
				}

			});
		}

	}

	function company_setting() {
		var companyName = $("#companyName").val();
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : rootPath + '/config/companySetting.shtml',
			data : {
				companyName : companyName
			},
			success : function(data) {
				if (data == 'success') {
					layer.alert("设置成功！", {
						icon : 6
					});
				} else {
					layer.alert("设置失败！", {
						icon : 5
					});
				}
			},
			error : function(data) {
				layer.alert("设置失败！", {
					icon : 5
				});
			}
		});
	}

	function speech_control_test() {
		var speechRate = $("#speechRate").val();
		var speechContent = $("#speechContent").val();
		speechContent = speechContent.replace("#[userName]", "张三").replace(
				"#[weighingType]", "重量").replace("#[weight]", "1000").replace(
				"#[carId]", "苏F12345");
		speckText(speechContent, speechRate);
	}

	function speckText(str, volum) {
		//spd  1-9
		var url = "http://tts.baidu.com/text2audio?lan=zh&ie=UTF-8&spd="
				+ volum + "&text=" + encodeURI(str);
		var n = new Audio(url);
		n.src = url;
		n.play();
	}

	function download_file() {
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : rootPath + '/config/fileDownload.shtml',
			success : function(data) {
			},
			error : function(data) {
			}
		});
	}

	$('#speechRate').slider({
		min : '1',
		max : '9',
		value : '0',
		tipFormatter : function(value) {
			return '语速：' + value;
		}
	});
</script>

	<div class="row">
		<div class="box col-md-12" style="padding-left: 0px; padding-right: 0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-list"></i> <span id="pageTitle"></span>
					</h2>
				</div>
				<div class="box-content " id="page">

					<div class="togglebox">
						<input id="toggle1" type="radio" name="toggle" /> <label
							for="toggle1" class=''>RFID卡设置</label>
						<section id="content1">
							<div class="col-md-12">
								<div class="form-group col-md-6">
									<span class="col-md-3 div_label">串口号： </span>
									<div class="col-md-9">
										<select id="ComName" class="chosen form-control "
											data-rel="chosen" data-placeholder="串口号">
											<option value="1">COM1</option>
											<option value="2">COM2</option>
											<option value="3">COM3</option>
											<option value="4">COM4</option>
											<option value="5">COM5</option>
											<option value="6">COM6</option>
											<option value="7">COM7</option>
											<option value="8">COM8</option>
											<option value="9">COM9</option>
											<option value="10">COM10</option>
										</select>
									</div>
								</div>

								<div class="form-group col-md-6">
									<span class="col-md-3 div_label">波特率： </span>
									<div class="col-md-9">
										<select id="BaudRate" class=" chosen form-control"
											data-rel="chosen" data-placeholder="波特率">
											<option value="0">9600bps</option>
											<option value="1">19200bps</option>
											<option value="2">38400bps</option>
											<option value="5" selected="selected">57600bps</option>
											<option value="6">115200bps</option>
										</select>
									</div>
								</div>

								<div class="form-group col-md-6">
									<span class="col-md-3 div_label">起始地址： </span>
									<div class="col-md-9">
										<input type="text" id="SnWpt" value="2" class="form-control"
											maxlength="8" placeholder="请输入：起始地址">
									</div>
								</div>

								<div class="form-group col-md-6">
									<span class="col-md-3 div_label">字数： </span>
									<div class="col-md-9">
										<input type="text" id="SnNum" value="8" class="form-control"
											maxlength="8" placeholder="请输入：字数">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-3 div_label">备注： </span>
									<div class="col-md-9">
										<input type="text" id="remark" class="form-control"
											maxlength="64" placeholder="请输入：备注">
									</div>
								</div>
								<div class="form-group col-md-6">
									<div class="col-md-4">
										<input type="button" class="btn btn-default radius" value="测试"
											id="button1" onclick="doopen();"></input>
									</div>
									<div class="col-md-4">
										<input type="button" class="btn btn-primary radius" value="保存"
											onclick="save_setting()"></input>
									</div>
									<div class="col-md-4">
										<a class="btn btn-info"
											href="${ctx }/config/fileDownload.shtml">插件下载</a>
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<textarea id="txtReceive" class="form-control" rows="8"
									cols="20"></textarea>
							</div>
							<div class="col-md-12">
								<table id="magazineGrid" style="width:100%;height:300px">
								</table>
							</div>

						</section>

						<input id="toggle2" type="radio" name="toggle" /> <label
							for="toggle2">一卡通设置</label>
						<section id="content2">
							<div class="col-md-12">
								<div class="form-group col-md-12">
									<span class="col-md-2 div_label">是否启用： </span>
									<div class="col-md-10">
											<input type="checkbox" id="usedOrNot"
												${usedOrNot == '1'?'checked="checked"':'' }>
									</div>
								</div>

								<div class="form-group form-group-w">
									<input type="button" class="btn btn-primary radius" value="保存"
										onclick="oneCar_setting()"></input>
								</div>
							</div>

						</section>

						<input id="toggle3" type="radio" name="toggle" /> <label
							for="toggle3">打印凭证</label>
						<section id="content3">
							<div class="col-md-12">
								<div class="form-group col-md-12">
									<span class="col-md-2 div_label">收购单位： </span>
									<div class="col-md-10">
										<input type="text" id="companyName" class="form-control"
											value="${companyName }" placeholder="请输入：收购单位">
									</div>
								</div>

								<div class="form-group form-group-w">
									<input type="button" class="btn btn-primary radius" value="保存"
										onclick="company_setting()"></input>
								</div>
							</div>
						</section>
						<input id="toggle4" type="radio" name="toggle" /> <label
							for="toggle4">称重视频设置</label>
						<section id="content4">
							<input id="weighingVideoid" type="hidden">
							<div class="col-md-12">
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">MAC地址： </span>
									<div class="col-md-8">
										<input id="macaddress" type="text" value="${mac_addr}"
											class=" form-control" maxlength="32">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">IP地址： </span>
									<div class="col-md-8">
										<input type="text" id="ipAddress"
											class=" form-control" maxlength="16" placeholder="请输入：IP地址">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">IP端口号： </span>
									<div class="col-md-8">
										<input type="text" id="ipPort"
											class=" form-control" maxlength="8" placeholder="请输入：IP端口号">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">视频通道号： </span>
									<div class="col-md-8">
										<input type="text" id="throughPort"
											class=" form-control" maxlength="4" placeholder="请输入：视频通道号">
									</div>
								</div>

								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">用户名： </span>
									<div class="col-md-8">
										<input type="text" id="userName"
											class=" form-control" maxlength="16" placeholder="请输入：用户名">
									</div>
								</div>

								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">密码： </span>
									<div class="col-md-8">
										<input type="text" id="password"
											class=" form-control" maxlength="32" placeholder="请输入：密码">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">备注： </span>
									<div class="col-md-8">
										<input type="text" id="szRemark" class=" form-control"
											maxlength="64" placeholder="请输入：备注">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">轮询称重： </span>
									<div class="col-md-8">
											<input type="checkbox" id="turnweighing">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">逐条打印： </span>
									<div class="col-md-8">
											<input type="checkbox" id="printType">
									</div>
								</div>
								<div class="form-group col-md-12">
									<span class="col-md-2 div_label">抓图路径： </span>
									<div class="col-md-10">
										<input type="text" id="screenshotPath" class=" form-control"
											maxlength="64" placeholder="请输入：抓图路径">
									</div>
								</div>
								<div class="form-group col-md-12">
									<div class="col-md-4"></div>
									<div class="col-md-2">
										<input type="button" class="btn btn-primary radius"
											onclick="shipin_add()" value="新增"></input>
									</div>
									<div class="col-md-2">
										<input type="button" class="btn btn-warning radius" value="更新"
											onclick="shipin_save()"></input>
									</div>
									<div class="col-md-4"></div>
								</div>
								<div class="col-md-12" style="margin: 4px;padding: 0">
									<table id="magazine"
										style="width:100%;height:300px;display: block"></table>
								</div>
							</div>
						</section>

						<input id="toggle5" type="radio" name="toggle" /> <label
							for="toggle5">语音播报</label>
						<section id="content5">
							<div class="col-md-12">
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">MAC地址： </span>
									<div class="col-md-8">
										<input id="vmacAddress" type="text" value="${mac_addr}"
											class=" form-control" maxlength="32">
									</div>
								</div>
								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">是否开启： </span>
									<div class="col-md-8">
											<input id="isOpen" type="checkbox" />
									</div>
								</div>

								<div class="form-group col-md-6">
									<span class="col-md-4 div_label">播放速度： </span>
									<div class="col-md-8">
										<input id="speechRate" data-slider-id='ex2Slider' type="text"
											data-options="showTip:true" />
									</div>
								</div>
								<div class="form-group col-md-12">
									<span class="col-md-2 div_label">播放格式： </span>
									<div class="col-md-10">
										<input id="speechContent" class=" form-control"
											value="客户：#[userName],#[weighingType]:#[weight]公斤,车牌号:#[carId]"
											type="text" maxlength="128" />
									</div>
								</div>
								<div class="form-group col-md-12">
									<span class="col-md-2 div_label">备注： </span>
									<div class="col-md-10">
										<input id="speechRemark" class=" form-control" type="text"
											maxlength="128" placeholder="请输入：备注"/>
									</div>
								</div>

								<div class="form-group col-md-12">
									<input type="button" class="btn btn-default radius"
										onclick="speech_control_test()" value="测试"></input> <input
										type="button" class="btn btn-primary radius"
										onclick="speech_control()" value="保存"></input>
								</div>

								<div class="col-md-12" style="margin: 4px;padding: 0">
									<table id="magazineSpeck"
										style="width:100%;height:300px;display: block"></table>
								</div>
							</div>
						</section>

						<input id="toggle6" type="radio" name="toggle" /> <label
							for="toggle6">客户端设置</label>
						<section id="content6">
							<div class="col-md-12">
								<div class="form-group col-md-12">
									<a href="http://localhost:9898/websocket/config/"
										target="_blank">本机硬件设备设置</a>
								</div>
							</div>
						</section>
					</div>
				</div>
			</div>
		</div>
	</div>

<OBJECT id="TUHFReader09" codebase="UHFReader09Proj.ocx"
	TYPE="application/x-itst-activex"
	clsid="{14428901-AF2B-4B45-ACBD-0B4779551E5D}" width="0" height="0"
	hspace="0" vspace="0"> </OBJECT>

<script type="text/javascript" src="js/system/weight/config/config.js"></script>
<script type="text/javascript"
	src="js/system/weight/config/weighingvideoconfig.js"></script>
<script type="text/javascript"
	src="js/system/weight/config/weighingspeckconfig.js"></script>

<script type="text/javascript">
$('[data-rel="chosen"],[rel="chosen"]').chosen();
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>