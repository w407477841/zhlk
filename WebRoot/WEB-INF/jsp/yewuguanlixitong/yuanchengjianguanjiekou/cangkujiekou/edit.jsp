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
			<h3 class="animated rubberBand">库点信息对接</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/warehouseLocationInterface/edit.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="warehouseLocationInterfaceFormMap.location_no"
							value="${warehouseLocationInterfaceFormMap.location_no }"
							readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					企业名称<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入企业名称" data-options="required:true"
							name="warehouseLocationInterfaceFormMap.qiyemingcheng"
							value="${warehouseLocationInterfaceFormMap.qiyemingcheng }"
							placeholder="请输入 ：库点名称" maxlength="50">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					库区编码<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入库区编码" data-options="required:true"
							name="warehouseLocationInterfaceFormMap.kuqubianma"
							value="${warehouseLocationInterfaceFormMap.kuqubianma }"
							placeholder="请输入 ：库区编码" maxlength="3">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					统一信用代码<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入统一信用代码" data-options="required:true"
							name="warehouseLocationInterfaceFormMap.tongyixinyongdaima"
							value="${warehouseLocationInterfaceFormMap.tongyixinyongdaima }"
							placeholder="请输入 ：统一信用代码" maxlength="10">

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
