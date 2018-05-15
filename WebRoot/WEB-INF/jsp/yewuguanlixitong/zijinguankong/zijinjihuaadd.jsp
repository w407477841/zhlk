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
			<h3 class="animated rubberBand">资金计划</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/zijinjihua/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					拨款人<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入拨款人" data-options="required:true"
							name="ziJinJiHuaFormMap.bpGrandPerson" placeholder="请输入 ：拨款人"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					收款人<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入收款人" data-options="required:true"
							name="ziJinJiHuaFormMap.bpPayee" placeholder="请输入 ：收款人"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					金额(小写)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入拨款金额" data-options="required:true" id="money"
							maxlength="10" onkeyup="chengeUpper(this)"
							onblur="validInt(this)" value=""
							name="ziJinJiHuaFormMap.bpLowerMoney" placeholder="请输入 ：拨款金额(小写)">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">金额(大写)</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="upmoney"
							placeholder="请输入 ：拨款金额(大写)" disabled="disabled"> <input
							type="hidden" id="upmoneyt" name="ziJinJiHuaFormMap.bpUpperMoney">

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					收款帐号<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入收款帐号" data-options="required:true"
							id="account" onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" name="ziJinJiHuaFormMap.bpAccount"
							placeholder="请输入 ：收款帐号" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					拨款时间<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" id="dateformat"
							class="form-control easyui-validatebox" missingMessage="请输入拨款时间"
							data-options="required:true" placeholder="请输入 ：拨款时间"
							name="ziJinJiHuaFormMap.bpGrandDate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">用途<span>*</span></div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control easyui-validatebox" missingMessage="请输入用途"
								data-options="required:true"
							name="ziJinJiHuaFormMap.bpUse" placeholder="请输入 ：用途"
							maxlength="128"></textarea>
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
		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.confirm('添加成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('添加失败！', 3);
						}
					}
				});
			},
			rules : {

			},
			messages : {

			},
			errorPlacement : function(error, element) {// 自定义提示错误位置

			},
			success : function(label) {// 验证通过后

			}
		});

		function chengeUpper(obj) {
			var result = chengeToUpper(obj);
			
			$("#upmoney").val(result);
			$("#upmoneyt").val(result);
			
		}
		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
