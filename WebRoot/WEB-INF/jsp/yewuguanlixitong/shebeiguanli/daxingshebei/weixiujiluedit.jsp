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
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">设备维修</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/daxingshebeiweixiu/edit.shtml">
			<input type="hidden" name="daXingSheBeiWeiXiuFormMap.id"
				value="${daXingSheBeiWeiXiuFormMap.id}"> <input
				type="hidden" name="daXingSheBeiWeiXiuFormMap.version"
				value="${daXingSheBeiWeiXiuFormMap.version}"> <input
				type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">设备名称</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${daXingSheBeiWeiXiuFormMap.leName }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">设备编号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${daXingSheBeiWeiXiuFormMap.leNo }" disabled="disabled">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">维护日期<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入维修日期" data-options="required:true" id="dateformat"
							placeholder="请输入 ：维护日期"
							name="daXingSheBeiWeiXiuFormMap.lerRepairDate"
							value="${daXingSheBeiWeiXiuFormMap.lerRepairDate }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">维护人员<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入维修人员" data-options="required:true"
							name="daXingSheBeiWeiXiuFormMap.lerRepairUser"
							value="${daXingSheBeiWeiXiuFormMap.lerRepairUser }"
							placeholder="请输入 ：维护人员" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">维护内容<span>*</span></div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control easyui-validatebox"
							missingMessage="请输入维修内容" data-options="required:true"
							name="daXingSheBeiWeiXiuFormMap.lerContent"
							placeholder="请输入 ：维护内容" maxlength="256">${daXingSheBeiWeiXiuFormMap.lerContent}</textarea>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript"
		src="${ctx}/js/system/yewuguanlixiytong/shebeiguanli/daxingshebei/daxingshebeifujianlist.js"></script>
	<script type="text/javascript">
		laydate({
			elem : '#dateformat',
			event : 'focus'
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
							layer.alert('修改失败！', {icon:5});
						}
					}
				});
			},
			rules : {},
			messages : {},
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
