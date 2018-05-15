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
	<div class=" col-md-6">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">入库方案</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/rukufangan/edit.shtml">
			<input type="hidden" name="ruKuFangAnFormMap.id"
				value="${ruKuFangAnFormMap.id }"> <input type="hidden"
				name="ruKuFangAnFormMap.version"
				value="${ruKuFangAnFormMap.version }"> <input type="hidden"
				name="token" value="${token }"> <input type="hidden"
				name="ruKuFangAnFormMap.pspVariety"
				value="${ruKuFangAnFormMap.pspVariety}"> <input
				type="hidden" name="ruKuFangAnFormMap.pspCategory"
				value="${ruKuFangAnFormMap.pspCategory }"> <input
				type="hidden" name="ruKuFangAnFormMap.pspWId"
				value="${ruKuFangAnFormMap.pspWId}">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" value="${ruKuFangAnFormMap.wlName }"
							class="form-control" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					仓号<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" value="${ruKuFangAnFormMap.wName }"
							class="form-control" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮食品种<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" value="${ruKuFangAnFormMap.variety }"
							class="form-control" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮食性质<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" value="${ruKuFangAnFormMap.category }"
							class="form-control" readonly="readonly">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">文件名称</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="ruKuFangAnFormMap.pspFileName"
							value="${ruKuFangAnFormMap.pspFileName }" placeholder="请输入 ：文件名称"
							maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					数量(kg)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入重量" data-options="required:true"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							   onblur="validInt(this)" name="ruKuFangAnFormMap.pspWeight"
							value="${ruKuFangAnFormMap.pspWeight }" placeholder="请输入 ：数量(kg)"
							maxlength="11">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					开始日期<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入开始日期" data-options="required:true"
							id="dateformat" placeholder="请输入 ：开始日期"
							name="ruKuFangAnFormMap.pspBeginDate"
							value="${ruKuFangAnFormMap.pspBeginDate }">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					结束期日<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入结束日期" data-options="required:true"
							id="dateformat1" placeholder="请输入 ：结束期日"
							name="ruKuFangAnFormMap.pspEndDate"
							value="${ruKuFangAnFormMap.pspEndDate }">
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">内容</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="10" class="form-control"
							name="ruKuFangAnFormMap.pspContent" placeholder="请输入 ：内容"
							maxlength="512">${ruKuFangAnFormMap.pspContent }</textarea>
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
		laydate({
			elem : '#dateformat',
			event : 'focus'
		});
		laydate({
			elem : '#dateformat1',
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
