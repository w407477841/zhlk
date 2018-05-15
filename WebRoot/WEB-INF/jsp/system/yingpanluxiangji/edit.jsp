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
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">硬盘录像机</h3>
		</div>
	</div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/yingpanluxiangji/edit.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="yingPanLuXiangJiFormMap.id"
				value="${yingPanLuXiangJiFormMap.id}">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					用户名称<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入用户名称" data-options="required:true" id="name"
							name="yingPanLuXiangJiFormMap.name" value="${yingPanLuXiangJiFormMap.name }"
							placeholder="请输入 ：用户名称 ">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="selectLocation" data-rel="chosen"
							data-placeholder="请选择粮库地点"
							name="yingPanLuXiangJiFormMap.location_id">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					IP地址<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入IP地址" data-options="required:true" id="yIp"
							name="yingPanLuXiangJiFormMap.yIp" value="${yingPanLuXiangJiFormMap.yIp }"
							placeholder="请输入 ：IP地址">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
				HTTP端口<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入HTTP端口" data-options="required:true"
							id="yPort" name="yingPanLuXiangJiFormMap.yPort" value="${yingPanLuXiangJiFormMap.yPort }"
							placeholder="请输入 ：HTTP端口">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
				RTSP端口
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							id="yPort" name="yingPanLuXiangJiFormMap.yRTSP" value="${yingPanLuXiangJiFormMap.yRTSP }"
							placeholder="请输入 ：RTSP端口">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
				HTTPS端口
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							id="yPort" name="yingPanLuXiangJiFormMap.yHTTPS" value="${yingPanLuXiangJiFormMap.yHTTPS }"
							placeholder="请输入 ：HTTPS端口">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
				服务端口
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							id="yPort" name="yingPanLuXiangJiFormMap.yServer" value="${yingPanLuXiangJiFormMap.yServer }"
							placeholder="请输入 ：服务端口">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					登录名<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入硬盘录像机登录名" data-options="required:true"
							id="yName" name="yingPanLuXiangJiFormMap.yName" value="${yingPanLuXiangJiFormMap.yName }"
							placeholder="请输入 ：硬盘录像机登录名">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					登录密码<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入硬盘录像机密码" data-options="required:true"
							id="yPassword" name="yingPanLuXiangJiFormMap.yPassword" value="${yingPanLuXiangJiFormMap.yPassword }"
							placeholder="请输入 ：硬盘录像机密码">
					</div>
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
			selected_val : '${yingPanLuXiangJiFormMap.location_id}'
		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});

		$("#form").validate({
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
			rules : {},
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
