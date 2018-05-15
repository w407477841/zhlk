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
	<div class="col-md-12 col-sm-12 col-xs-12">
		<div class="col-md-6 col-sm-6 col-xs-6">
			<h3 class="animated rubberBand">用户授权</h3>
		</div>
	</div>
	<div class="col-md-12 col-sm-12 col-xs-12">
		<form id="form" name="form" method="post"
			action="${ctx}/mobile/user/edit.shtml">
			<input type="hidden" name="token" value="${token }"> <input
				type="hidden" name="userFormMap.userId" value="${id }">
			<div class="form-group col-md-12 col-sm-12 col-xs-12">
				<div class="col-md-2 col-sm-2 col-xs-2 div_label">
					角色<span>*</span>
				</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<div class="has-warning">
						<select id="roleId" data-rel="chosen" data-placeholder="请选择：角色"
							name="userFormMap.roleId" style="width:100%">
							<option value=""></option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12 col-sm-12 col-xs-12" >
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	new myselect({
		obj_id : "roleId",
		url : rootPath + "/mobile/role/findBySelect.shtml",
		option_val : [ "id" ],
		option_val_prefix : ",",
		option_html : [ "name" ],
		option_html_prefix : ",",
		selected_val:"${roleId}"
	}, function() {
		//给change事件添加方法
		ck();
	}, function() {
		//初始化执行方法

	});
	$("#roleId").chosen({
		no_results_text : "未找到此选项!",
		width : "100%"
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
