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
			<h3 class="animated rubberBand">药剂库存续增</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/yaojikucunguanli/increase.shtml">
			<input type="hidden" name="yaoJiKuCunFormMap.id"
				value="${yaoJiKuCunFormMap.id}"> <input type="hidden"
				name="yaoJiKuCunFormMap.version"
				value="${yaoJiKuCunFormMap.version}"> <input type="hidden"
				name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库地点</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${yaoJiKuCunFormMap.wName }" disabled="disabled">
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
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂名称</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrName"
							value="${yaoJiKuCunFormMap.mrName }" placeholder="请输入 ：药剂名称"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂品牌</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrBrand"
							value="${yaoJiKuCunFormMap.mrBrand }" placeholder="请输入 ：药剂品牌"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">单位</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrPage"
							value="${yaoJiKuCunFormMap.page }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂规格</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrStandard"
							value="${yaoJiKuCunFormMap.mrStandard }" placeholder="请输入 ：药剂规格"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂单价(元)</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrPrice"
							value="${yaoJiKuCunFormMap.mrPrice }" placeholder="请输入 ：药剂单价(元)"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					续增数量<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入续增数量" data-options="required:true"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" name="yaoJiKuCunFormMap.mrNumber"
							placeholder="请输入 ：续增药剂数量" maxlength="8">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂包装</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrUnit"
							value="${yaoJiKuCunFormMap.mrUnit }" placeholder="请输入 ：药剂包装"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">生产日期</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${yaoJiKuCunFormMap.mrManufactureDate }"
							placeholder="请输入 ：生产日期"
							name="yaoJiKuCunFormMap.mrManufactureDate" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">生产厂家</div>
				<div class="col-md-11">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrProductCompany"
							value="${yaoJiKuCunFormMap.mrProductCompany }"
							placeholder="请输入 ：生产厂家" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">经办人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrOperator"
							value="${yaoJiKuCunFormMap.mrOperator }" placeholder="请输入 ：经办人"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">批核人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrAuditor"
							value="${yaoJiKuCunFormMap.mrAuditor }" placeholder="请输入 ：批核人"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">备注</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							name="yaoJiKuCunFormMap.mrRemark" placeholder="请输入 ：备注"
							disabled="disabled">${yaoJiKuCunFormMap.mrRemark }</textarea>
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
							layer.confirm('续增成功，是否关闭?', function(index) {
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
				$("#errorDiv").css('display', 'block');
				// element.css('border','3px solid #FFCCCC');
				$("#errorDiv").html(error.html());
			},
			success : function(label) {// 验证通过后
				label.parent().attr("class", "has-success");
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
