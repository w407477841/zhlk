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
			<h3 class="animated rubberBand">出库审批</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<div class=" col-md-12">
			<div class=" col-md-6">
				<h4 class="animated rubberBand">出库信息</h4>
			</div>
		</div>
		<div class=" col-md-6"></div>
		<div class=" col-md-12">
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">粮库地点</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.wlName }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">仓号</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.wlName }" disabled="disabled">
					</div>
				</div>
			</div>


			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">申请单编号</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.gsaApplyBill }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">发货日期</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.gsaSendOutDate }"
							disabled="disabled">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">买受人(需方)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.gsaPurchaser }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">合同号</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.agreementID }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">货款到账情况</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.gsaPaymentSituation }"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">计划出库数量(吨)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.gsaPlanOutWeight }"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">当前数量(kg)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.gsaCurrentWeight }"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">申请人</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.gsaApplyPerson }"
							disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">部门</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${chuKuShenQingFormMap.department }" disabled="disabled">
					</div>
				</div>
			</div>

			<input type="hidden" id="fjid"
				name="chuKuShenQingFormMap.gsaTransferTools"
				value="${chuKuShenQingFormMap.gsaTransferTools }">

		</div>
		<div class=" col-md-12">
			<div class=" col-md-6">
				<h4 class="animated rubberBand">需方运输工具情况</h4>
			</div>
		</div>
		<div class=" col-md-6"></div>
		<div class="form-group col-md-12">
			<div class="col-md-1"></div>
			<div class="col-md-11">
				<table id="sbfjGrid" style="width:85%;height:400px;">
				</table>
			</div>
		</div>
		<form id="form" name="form" method="post" action="">
			<input type="hidden" name="chuKuShenQingFormMap.id"
				value="${chuKuShenQingFormMap.id }"> <input type="hidden"
				name="chuKuShenQingFormMap.version"
				value="${chuKuShenQingFormMap.version }"> <input
				type="hidden" name="chuKuShenQingFormMap.gsaApplyBill"
				value="${chuKuShenQingFormMap.gsaApplyBill }"> <input
				type="hidden" name="token" value="${token }">
			<div class=" col-md-12">
				<div class=" col-md-6">
					<h4 class="animated rubberBand">出库申请审批</h4>
				</div>
			</div>
			<div class=" col-md-6"></div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">审批意见<span>*</span></div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control easyui-validatebox"
							missingMessage="请输入审批意见" data-options="required:true" 
							name="chuKuShenQingFormMap.gsaRemark" placeholder="请输入：审批意见"></textarea>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">审批通过</button>
				<button type="button" class="btn btn-danger bt-submit"
					onclick="_notthrough()">审批不通过</button>
			</div>
		</form>
	</div>
	<script type="text/javascript"
		src="${ctx}/js/system/yewuguanlixiytong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqingtools.js"></script>
	<script type="text/javascript">
		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.confirm('审批成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('审批失败！', {
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
			$("#form")
					.attr("action",
							"${ctx}/chukushenpi/add.shtml?chuKuShenQingFormMap.gsaProcess=1");
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
		function _notthrough() {
			$("#form")
					.attr("action",
							"${ctx}/chukushenpi/add.shtml?chuKuShenQingFormMap.gsaProcess=2");
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
