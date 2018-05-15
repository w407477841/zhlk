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
			<h3 class="animated rubberBand">用户修改</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/user/edit.shtml">
			<input type="hidden" name="userFormMap.id" value="${userFormMap.id}">
			<input type="hidden" name="userFormMap.version"
				value="${userFormMap.version}">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					用户名称<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输用户名称" data-options="required:true" id="userName"
							name="userFormMap.userName" value="${userFormMap.userName }" placeholder="请输入 ：用户名称 " maxlength="20">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					登录账户<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输登录账户" data-options="required:true" id="accountName"
							name="userFormMap.accountName" value="${userFormMap.accountName }"
							placeholder="请输入 ：登录账户 " readonly="readonly" maxlength="20">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					角色
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="selectRole" data-rel="chosen"
							data-placeholder="选择一个角色" name="userFormMap.roleId"
							style="width:200px">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					用户描述
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="description"
							name="userFormMap.description" value="${userFormMap.description }" placeholder="请输入 ：用户描述 " maxlength="100">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					用户状态
				</div>
				<div class="col-md-10">
					<div class="has-warning">
					<select id="selectLocked" data-rel="chosen" data-placeholder="用户状态"
						name="userFormMap.locked">
						<option value=""></option>
						<option value="1"
							<c:if test="${userFormMap.locked=='1'}">selected="selected"</c:if>>正常</option>
						<option value="2"
							<c:if test="${userFormMap.locked=='2'}">selected="selected"</c:if>>锁定</option>
					</select>
				</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					部门
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="departmentid" data-rel="chosen"
							data-placeholder="请选择部门" name="userFormMap.departmentid">
							<option value=""></option>
						</select>
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
		var sel = new myselect({
			obj_id : "selectRole",
			url : "${ctx}/role/findAllRole.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "name" ],
			option_html_prefix : ",",
			selected_val : "${userFormMap.roleId}"
		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});

		$("#selectLocked").css("width",
				$("#selectLocked").parent().parent().css("width"));
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
			rules : {
			},
			messages : {
			},
			errorPlacement : function(error, element) {// 自定义提示错误位置
			},
			success : function(label) {// 验证通过后
			}
		});

		new myselect({
			obj_id : "departmentid",
			url : "${ctx}/code/findCodeItemTreeGrid.shtml",
			data : {
				"codeItemFormMap.codeid" : 9
			},
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "text" ],
			option_html_prefix : ",",
			selected_val:"${userFormMap.departmentid}"

		}, function() {
			//给change事件添加方法
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
