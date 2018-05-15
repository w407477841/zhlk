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
			<h3 class="animated rubberBand">合同模版</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/businessManager/addAgreementForm.shtml">
			<input type="hidden" name="token" value="${token}"> 
			<div class="form-group col-md-12">

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">模版名称<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox" missingMessage="请输入模版名称" data-options="required:true"
								name="businessAgreementFormFormMap.fName"
								placeholder="请输入 ：模版名称" maxlength="64">
						</div>
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
							layer.confirm('添加成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('添加失败！', {icon:5});
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
			success : function(label,a) {// 验证通过后
				
			}
		});
		function _submit() {
			if($("#form").form("validate")){
				$("#form").submit();     
		     }
		}
	</script>
</body>
</html>
