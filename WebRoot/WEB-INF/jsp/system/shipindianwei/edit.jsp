<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div id="errorDiv" class="col-md-12"></div>
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">视频点位修改</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/shipindianwei/edit.shtml">
			<input type="hidden" id="id" name="shiPinDianWeiFormMap.id"
				value="${shiPinDianWeiFormMap.id}"> <input type="hidden"
				name="token" value="${token}">
			<div class="form-group col-md-6">
				<div class="form-group col-md-12">
				    <div class="col-md-2 div_label">点位名称<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入点位名称" data-options="required:true" id="name"
							name="shiPinDianWeiFormMap.name" value="${shiPinDianWeiFormMap.name }" placeholder="请输入 ：点位名称">
					</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">粮库地点<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<select id="selectLocation" data-rel="chosen"
							data-placeholder="请选择粮库地点" name="shiPinDianWeiFormMap.location_id">
							<option value=""></option>
						</select>
					</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">IP通道号<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入IP通道号号" data-options="required:true" id="ipNum"
							name="shiPinDianWeiFormMap.ipNum" value="${shiPinDianWeiFormMap.ipNum }"
							placeholder="请输入 ：ip通道号">
					</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">横轴位置<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入横轴位置" data-options="required:true" id="sLeft"
							name="shiPinDianWeiFormMap.sLeft" value="${shiPinDianWeiFormMap.sLeft }"
							placeholder="请输入 ：横轴位置">
					</div>
					</div>
				</div>



				<div class="form-group col-md-12">
				<div class="col-md-2 div_label">纵轴位置<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入纵轴位置" data-options="required:true" id="top"
							name="shiPinDianWeiFormMap.top" value="${shiPinDianWeiFormMap.top }" placeholder="请输入 ：纵轴位置">
					</div>
					</div>
				</div>
				<div class="form-group col-md-12">
				<div class="col-md-2 div_label">硬盘录像机</div>
					<div class="col-md-10">
					<div class="has-warning">
						<select id="selectYplxj" data-rel="chosen"
							data-placeholder="请选中硬盘录像机">
							<option value=""></option>
						</select>
					</div>
					</div>
				</div>
				<div class="form-group col-md-12">
				<div class="col-md-2 div_label">IP地址<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入IP地址" data-options="required:true" id="ip"
							name="shiPinDianWeiFormMap.ip" value="${shiPinDianWeiFormMap.ip }" placeholder="请输入 ：ip">
					</div>
					</div>
				</div>

				<div class="form-group col-md-12">
				<div class="col-md-2 div_label">IP端口<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入IP端口号" data-options="required:true" id="port"
							name="shiPinDianWeiFormMap.port" value="${shiPinDianWeiFormMap.port }" placeholder="请输入 ：port">
					</div>
					</div>
				</div>
				<div class="form-group col-md-12">
				<div class="col-md-2 div_label">用户名<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入用户名" data-options="required:true" id="userName"
							name="shiPinDianWeiFormMap.userName" value="${shiPinDianWeiFormMap.userName }"
							placeholder="请输入 ：用户名">
					</div>
					</div>
				</div>
				<div class="form-group col-md-12">
				<div class="col-md-2 div_label">密码<span>*</span></div>
					<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入密码" data-options="required:true" id="password"
							name="shiPinDianWeiFormMap.password" value="${shiPinDianWeiFormMap.password }"
							placeholder="请输入 ：密码">
					</div>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div id="img_cangku">
					<div id="shexiangtouImg"
						style='width: 20px; height: 20px; position: absolute; left: ${shiPinDianWeiFormMap.sLeft}; top: ${shiPinDianWeiFormMap.top}; background: transparent url("/zhlk/img/cangku/jk.png") repeat scroll 0% 0% / 100% 100%; color: white; cursor: pointer;'></div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		var sel = new myselect({
			obj_id : "selectLocation",
			url : "${ctx}/warehouse/findMap.shtml",
			option_val : [ "wNo" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ",",
			selected_val : '${shiPinDianWeiFormMap.location_id}'
		}, function() {
			//给change事件添加方法

			$("#selectYplxj").html(""); //两级联动需要
			$("#selectYplxj").chosen("destroy"); //两级联动需要
			findYplxjs($("#selectLocation").val());
			$("#selectYplxj").chosen({ //两级联动需要
				no_results_text : "未找到此选项!",
				width : "100%"
			});
			getImagePath();
		}, function() {
			//初始化执行方法
			findYplxjs($("#selectLocation").val());
			getImagePath();
		});

		function findYplxjs(location) {
			new myselect({
				obj_id : "selectYplxj",
				url : "${ctx}/yingpanluxiangji/findByLocation.shtml",
				data : {
					"location_id" : location
				},
				option_val : [ "yIp", "yPort", "yName", "yPassword" ],
				option_val_prefix : ",",
				option_html : [ "name" ],
				option_html_prefix : ","
			}, function() {
				//给change事件添加方法
				var vals = $("#selectYplxj").val().split(",");
				$("#ip").val(vals[0]);
				$("#port").val(vals[1]);
				$("#userName").val(vals[2]);
				$("#password").val(vals[3]);
			}, function() {

				//初始化执行方法
			});

		}
		function getImagePath() {
			$.ajax({
				type : 'post',
				dataType : 'json',
				data : {
					id : $("#selectLocation").val()
				},
				url : '${ctx}/warehouseLocation/imagePath.shtml',
				success : function(data) {
					$("#img_cangku").css("background",
							"url(${ctx}/" + data + ")").css("background-size",
							"100% 100%").css("height", "300px");
				}

			});
		}

		var shexiangtouImg = $("#shexiangtouImg");
		$("#img_cangku")
				.click(
						function(event) {
							imgL = $("#img_cangku").css("width");
							imgL = imgL.substr(0, imgL.length - 2);
							imgH = $("#img_cangku").css("height");
							imgH = imgH.substr(0, imgH.length - 2);
							cL = event.offsetX;
							cH = event.offsetY;
							$("#sLeft").val(
									CommnUtil.roundFun(cL / imgL * 100, 1)
											+ "%");
							$("#top").val(
									CommnUtil.roundFun(cH / imgH * 100, 1)
											+ "%");
							if (shexiangtouImg == null) {
								shexiangtouImg = $("<div>")
										.css("width", "20px")
										.css("height", "20px")
										.attr("id", "shexiangtouImg")
										.css("position", "absolute")
										.css(
												"left",
												CommnUtil.roundFun(cL / imgL
														* 100, 1)
														+ "%")
										.css(
												"top",
												CommnUtil.roundFun(cH / imgH
														* 100, 1)
														+ "%")
										.css("background",
												"url(${pageContext.servletContext.contextPath}/img/cangku/jk.png)")
										.css("background-size", "100% 100%")
										.css("color", "white").attr("data-id",
												"shipin" + i).css("cursor",
												"pointer").appendTo(
												$("#img_cangku"));
							} else {
								shexiangtouImg.css(
										"left",
										CommnUtil.roundFun(cL / imgL * 100, 1)
												+ "%").css(
										"top",
										CommnUtil.roundFun(cH / imgH * 100, 1)
												+ "%")
							}
						});

		$("#form")
				.validate(
						{
							submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
								ly.ajaxSubmit(form, {//验证新增是否成功
									type : "post",
									dataType : "json",
									success : function(data) {
										if (data == "success") {
											layer.confirm('修改成功，是否关闭?', function(index) {
												layer.close(index);
												parent.layer.close(parent.pageii);
											});
										} else {
											layer.alert('修改失败！', {
												icon : 5
											});
										}
									}
								});
							},
							rules : {
							},
							messages : {
							},
							errorPlacement : function(error, element) {// 自定义提示错误位置
							},
							success : function(label) {// 验证通过后
							}
						});

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
