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
			<h3 class="animated rubberBand">药剂申请审批</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post" action="">
			<input type="hidden" name="yaoJiShenQingFormMap.id"
				value="${yaoJiShenQingFormMap.id }"> <input type="hidden"
				name="yaoJiShenQingFormMap.version"
				value="${yaoJiShenQingFormMap.version}"> <input
				type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂名称</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrName"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrName}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂品牌</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrBrand"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrBrand}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂包装</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrPage"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrPage}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂规格</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrStandard"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrStandard}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂单价(元)</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrPrice"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrPrice}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂库存数量</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrNumber"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrNumber}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">单位</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrUnit"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrUnit}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">生产日期</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrManufactureDate"
							disabled="disabled"
							value="${yaoJiKuCunFormMap.mrManufactureDate}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">生产厂家</div>
				<div class="col-md-11">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrProductCompany"
							disabled="disabled" value="${yaoJiKuCunFormMap.mrProductCompany}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">领用数量</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="number"
							value="${yaoJiShenQingFormMap.maQuantity}" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">申请人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="auditor"
							value="${yaoJiShenQingFormMap.maApplicant}" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">用途</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							disabled="disabled">${yaoJiShenQingFormMap.maUsed }</textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">备注</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							disabled="disabled">${yaoJiShenQingFormMap.remark }</textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">
					审批意见<span>*</span>
				</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20"
							class="form-control easyui-validatebox" missingMessage="请输入审批意见"
							data-options="required:true"
							name="yaoJiShenQingFormMap.maOpinion" placeholder="请输入 ：审批意见"
							maxlength="256">${yaoJiShenQingFormMap.maOpinion }</textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">审批通过</button>
				<button type="button" class="btn btn-danger bt-danger"
					onclick="_approve()">审批不通过</button>
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
							layer.confirm('审批完成，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('审批失败！', {icon:5});
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
			$("#form")
					.attr("action",
							"${ctx}/yaojilingyongshenpi/add.shtml?yaoJiShenQingFormMap.maProcess=1");
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
		function _approve() {
			$("#form")
					.attr("action",
							"${ctx}/yaojilingyongshenpi/add.shtml?yaoJiShenQingFormMap.maProcess=2");
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
