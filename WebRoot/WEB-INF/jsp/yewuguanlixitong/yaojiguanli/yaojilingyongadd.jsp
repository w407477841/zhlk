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
			<h3 class="animated rubberBand">药剂领用</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/yaojilingyongguanli/add.shtml">
			<input type="hidden" name="yaoJiKuCunFormMap.id"
				value="${yaoJiKuCunFormMap.id}"> <input type="hidden"
				name="yaoJiKuCunFormMap.mrNumber"
				value="${yaoJiKuCunFormMap.mrNumber}"> <input type="hidden"
				name="yaoJiKuCunFormMap.version"
				value="${yaoJiKuCunFormMap.version}"> <input type="hidden"
				name="yaoJiLingYongFormMap.mrId" value="${yaoJiKuCunFormMap.id}">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库地点</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrDrug"
							value="${yaoJiKuCunFormMap.wName }" placeholder="请输入 ：药剂类型"
							disabled="disabled"> <input type="hidden"
							class="form-control" name="yaoJiLingYongFormMap.muWLNo"
							value="${yaoJiKuCunFormMap.mrWLNo }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂类型</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrDrug"
							value="${yaoJiKuCunFormMap.drug }" placeholder="请输入 ：药剂类型"
							disabled="disabled"> <input type="hidden"
							class="form-control" name="yaoJiLingYongFormMap.muDrug"
							value="${yaoJiKuCunFormMap.mrDrug }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂名称</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="name"
							name="yaoJiLingYongFormMap.muName"
							value="${yaoJiKuCunFormMap.mrName }" disabled="disabled">
						<input type="hidden" class="form-control"
							name="yaoJiLingYongFormMap.muName"
							value="${yaoJiKuCunFormMap.mrName }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂品牌</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiLingYongFormMap.muBrand"
							value="${yaoJiKuCunFormMap.mrBrand }" disabled="disabled">
						<input type="hidden" class="form-control"
							name="yaoJiLingYongFormMap.muBrand"
							value="${yaoJiKuCunFormMap.mrBrand }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">单位</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiLingYongFormMap.muPage"
							value="${yaoJiKuCunFormMap.page }" disabled="disabled"> <input
							type="hidden" class="form-control"
							name="yaoJiLingYongFormMap.muPage"
							value="${yaoJiKuCunFormMap.mrPage }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂规格</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="guige"
							name="yaoJiLingYongFormMap.muStandard"
							value="${yaoJiKuCunFormMap.mrStandard }" disabled="disabled">
						<input type="hidden" class="form-control"
							name="yaoJiLingYongFormMap.muStandard"
							value="${yaoJiKuCunFormMap.mrStandard }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂单价(元)</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="price"
							name="yaoJiLingYongFormMap.muPrice"
							value="${yaoJiKuCunFormMap.mrPrice }" disabled="disabled">
						<input type="hidden" class="form-control"
							name="yaoJiLingYongFormMap.muPrice"
							value="${yaoJiKuCunFormMap.mrPrice }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂库存数量</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="mrNumber"
							name="yaoJiLingYongFormMap.mrNumber"
							value="${yaoJiKuCunFormMap.mrNumber }" disabled="disabled">
						<input type="hidden" name="yaoJiLingYongFormMap.muNumber"
							value="${yaoJiKuCunFormMap.mrNumber }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂包装</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="danwei"
							name="yaoJiLingYongFormMap.muUnit"
							value="${yaoJiKuCunFormMap.mrUnit }" disabled="disabled">
						<input type="hidden" class="form-control"
							name="yaoJiLingYongFormMap.muUnit"
							value="${yaoJiKuCunFormMap.mrUnit }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">生产日期</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${yaoJiKuCunFormMap.mrManufactureDate }"
							name="yaoJiLingYongFormMap.muManufactureDate" disabled="disabled">
						<input type="hidden" class="form-control"
							value="${yaoJiKuCunFormMap.mrManufactureDate }"
							name="yaoJiLingYongFormMap.muManufactureDate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">生产厂家</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="productCompany"
							name="yaoJiLingYongFormMap.muProductCompany"
							value="${yaoJiKuCunFormMap.mrProductCompany }"
							disabled="disabled"> <input type="hidden"
							class="form-control" name="yaoJiLingYongFormMap.muProductCompany"
							value="${yaoJiKuCunFormMap.mrProductCompany }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">领用日期<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入领用日期" data-options="required:true" id="dateformat"
							placeholder="请输入 ：领用日期" name="yaoJiLingYongFormMap.muUsedDate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">领用数量<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入领用数量" data-options="required:true" id="operator"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validIOK(this)" name="yaoJiLingYongFormMap.muQuantity"
							placeholder="请输入 ：领用数量" maxlength="9">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">经办人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="operator"
							name="yaoJiLingYongFormMap.muApplicant" value=""
							placeholder="请输入 ：经办人" maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">核批人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="auditor"
							name="yaoJiLingYongFormMap.muAuditor" value=""
							placeholder="请输入 ：批核人" maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">使用监管人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="auditor"
							name="yaoJiLingYongFormMap.muSupervisor" value=""
							placeholder="请输入 ：使用监管人" maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">用途</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							name="yaoJiLingYongFormMap.muUsed" placeholder="请输入 ：用途"
							maxlength="256"></textarea>
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
		function validIOK(obj) {
			var val = obj.value;
			while (val.length > 0) {
				var first = val.substring(0, 1);
				if (first != '0') {
					break;
				} else {
					val = val.substring(1);
				}
			}
			if (val.length > 0) {
				var repository = document.getElementById("mrNumber").value;
				if (parseInt(val) > parseInt(repository)) {
					obj.value = repository;
				} else {
					obj.value = val;
				}
			} else {
				obj.value = 1;
			}
		}

		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.confirm('领用成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('领用失败！', {icon:5});
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
			$("#form").submit();if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
