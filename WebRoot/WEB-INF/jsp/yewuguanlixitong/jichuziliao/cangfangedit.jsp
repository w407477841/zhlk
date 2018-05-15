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
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">仓房信息</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/warehouse/edit.shtml">
			<input type="hidden" name="token" value="${token }">

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen" name="warehouseFormMap.wLocation"
							data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库编号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" id="warehouseLocationId" class="form-control easyui-validatebox"
							data-options="required:true" readonly="readonly" value="${warehouseFormMap.wLocation }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					仓库编号<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="warehouseId" readonly="readonly"
							onkeyup="this.value=this.value.replace(/\D/g,'')" name="warehouseFormMap.id" value="${warehouseFormMap.id }"
							placeholder="请输入 ：仓库编号" maxlength="9">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					仓库名称<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true" name="warehouseFormMap.wName"
							placeholder="请输入 ：仓库名称" maxlength="32"  value="${warehouseFormMap.wName }">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">对应仓号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" value="${warehouseFormMap.wNo }"
							name="warehouseFormMap.wNo" placeholder="请输入 ：对应仓号" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮温行</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" value="${warehouseFormMap.wRow }"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" name="warehouseFormMap.wRow"
							placeholder="请输入 ：粮温行" maxlength="3">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮温列</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" value="${warehouseFormMap.wColumn }"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" name="warehouseFormMap.wColumn"
							placeholder="请输入 ：粮温列" maxlength="3">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮温层</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" value="${warehouseFormMap.wHeight }"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" name="warehouseFormMap.wHeight"
							placeholder="请输入 ：粮温层" maxlength="3">
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

		var sel = new myselect({
			obj_id : "warehouseLocation",
			url : "${ctx}/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ",",
			selected_val:"${warehouseFormMap.wLocation}"

		}, function() {
			//给change事件添加方法
			$("#warehouseLocationId").val($("#warehouseLocation").val());
		}, function() {
			//初始化执行方法
		});

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
