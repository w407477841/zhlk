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
			<h3 class="animated rubberBand">人员档案</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/renyuandangan/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					姓名<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true" id="mrBrand"
							name="renYuanDangAnFormMap.paName" placeholder="请输入 ：姓名"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">性别</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" name="renYuanDangAnFormMap.paSex"
							data-rel="chosen" data-placeholder="请选择性别">
							<option></option>
							<option value="男">男</option>
							<option value="女">女</option>
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					手机号码<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							validType="mobile" data-options="required:true"
							invalidMessage="请输入正确的手机号码"
							name="renYuanDangAnFormMap.paTelephone" placeholder="请输入 ：手机号码"
							maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">办公电话</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							validType="telephone" invalidMessage="请输入正确的办公电话"
							name="renYuanDangAnFormMap.paOfficePhone" placeholder="请输入 ：办公电话"
							maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">电子邮箱</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							validType="email" invalidMessage="请输入正确的邮箱"
							name="renYuanDangAnFormMap.paEmail" placeholder="请输入 ：电子邮箱"
							maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">QQ</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							validType="qq" invalidMessage="请输入正确的QQ"
							name="renYuanDangAnFormMap.paQQ" placeholder="请输入 ：QQ"
							maxlength="12">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">民族</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="renYuanDangAnFormMap.paNation" placeholder="请输入 ：民族"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">出生日期</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="dateformat"
							placeholder="请输入 ：出生日期" name="renYuanDangAnFormMap.paBirthday">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">文化程度</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="renYuanDangAnFormMap.paDegree" placeholder="请输入 ：文化程度"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">健康证号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="renYuanDangAnFormMap.paHealth" placeholder="请输入 ：健康证号"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					上岗证号
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="renYuanDangAnFormMap.paWorkLicence" placeholder="请输入 ：上岗证号"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">单位</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="renYuanDangAnFormMap.paDepartment" placeholder="请输入 ：单位"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">职位</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="renYuanDangAnFormMap.paDuty" placeholder="请输入 ：职位"
							maxlength="32">
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
							layer.alert('添加失败！', {icon:5});
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
