<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/common/common.jspf"%>
<style type="text/css">
.col-sm-3 {
	width: 25%;
	float: left;
}

.col-sm-9 {
	width: 75%;
	float: left;
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div style="height:30px"></div>
	<div class=" col-md-12">
		<form id="formUpdatePwd" name="form" class="form-horizontal"
			method="post" action="${ctx}/user/editPassword.shtml">
			<input type="hidden" class="form-control checkacc"
				value="${userSession.id}" name="userFormMap.id" id="id"> <input
				type="hidden" class="form-control checkacc"
				value="${userSession.version}" name="userFormMap.version"
				id="version"> <input type="hidden"
				class="form-control checkacc" value="${userSession.accountName}"
				name="userFormMap.accountName" id="accountName"> <input
				type="hidden" class="form-control checkacc"
				value="${userSession.password}" name="userFormMap.password"
				id="password">

			<div class="line line-dashed line-lg pull-in"></div>
			<div class="form-group">
				<label class="col-sm-3 control-label" style="line-height: 34px;text-align: right;">新密码</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" placeholder="请输入：新密码"
						name="userFormMap.newpassword" id="newpassword">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" style="line-height: 34px;text-align: right;">确认新密码</label>
				<div class="col-sm-9">
					<input type="password" class="form-control" placeholder="请输入：确认密码"
						name="userFormMap.confirmpassword" id="confirmpassword">
				</div>
			</div>
			
			<button type="button" class="btn btn-info" onclick="_submit()">修改</button>
		</form>
	</div>
	<script type="text/javascript">
	$("#formUpdatePwd").validate({
		submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
			ly.ajaxSubmit(form, {//验证新增是否成功
				type : "post",
				dataType : "json",
				success : function(data) {
					if (data == "success") {
						layer.msg('修改成功!',{icon:6});
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
		function _submit(){
			var npwd = $("#newpassword").val();
			var cpwd = $("#confirmpassword").val();
			if(npwd != null && npwd != ''){
				if(npwd == cpwd){
					$("#formUpdatePwd").submit();
				}else{
					layer.alert("密码输入不一致！",{icon:5});
				}
			}else{
				layer.alert("请输入新密码！",{icon:5});
			}
		}
	</script>
</body>
</html>