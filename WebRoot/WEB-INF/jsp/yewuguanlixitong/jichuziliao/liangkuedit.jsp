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
	<div class=" col-md-6">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">粮库信息</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/warehouseLocation/edit.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					库点编号<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text"
							class="form-control"
							 name="warehouseLocationFormMap.id"
							placeholder="请输入 ：库点编号" maxlength="9" value="${warehouseLocationFormMap.id }" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					库点名称<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入库点名称" data-options="required:true"
							name="warehouseLocationFormMap.wName" placeholder="请输入 ：库点名称"
							maxlength="64" value="${warehouseLocationFormMap.wName }">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">经度</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="warehouseLocationFormMap.wLog" placeholder="请输入 ：经度"
							maxlength="32" value="${warehouseLocationFormMap.wLog }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">纬度</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control "
							name="warehouseLocationFormMap.wLat" placeholder="请输入 ：纬度"
							maxlength="16" value="${warehouseLocationFormMap.wLat }">

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库全称</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="warehouseLocationFormMap.wFullName" placeholder="请输入 ：粮库全称"
							maxlength="16" value="${warehouseLocationFormMap.wFullName }">

					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">粮库简介</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea class="form-control" rows="6"
							name="warehouseLocationFormMap.wSummary" placeholder="请输入 ：粮库简介"
							maxlength="512">${warehouseLocationFormMap.wSummary }</textarea>
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
