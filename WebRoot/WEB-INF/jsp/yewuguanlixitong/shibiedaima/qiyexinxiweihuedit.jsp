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
	<div id="errorDiv" class="col-md-12"></div>
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">企业修改</h3>
		</div>
	</div>
	<div class='col-md-12'>
		<form class="form-horizontal" id="form" name="form" role="form"
			method="post" action="${ctx}/qiyexinxiweihu/edit.shtml">
			<input type="hidden" name="enterpriseFormMap.id"
				value="${enterpriseFormMap.id}">
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">企业名称</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="eName"
							name="enterpriseFormMap.eName" value="${enterpriseFormMap.eName}"
							placeholder="请输入：企业名称" maxlength="40">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">组织机构代码</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="eGroupCode"
							name="enterpriseFormMap.eGroupCode"
							value="${enterpriseFormMap.eGroupCode }" placeholder="请输入：组织机构代码" maxlength="20">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">行政区划代码</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="eAddrCode"
							name="enterpriseFormMap.eAddrCode"
							value="${enterpriseFormMap.eAddrCode }" placeholder="请输入：行政区划代码" maxlength="20">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">企业性质</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="eNature"
							name="enterpriseFormMap.eNature"
							value="${enterpriseFormMap.eNature }" placeholder="请输入：企业性质" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">企业经营种类</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="eClassify"
							name="enterpriseFormMap.eClassify"
							value="${enterpriseFormMap.eClassify }" placeholder="请输入：企业经营种类" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">联系地址</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="eLocation"
							name="enterpriseFormMap.eLocation"
							value="${enterpriseFormMap.eLocation }" placeholder="请输入：联系地址" maxlength="40">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">法人名称</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="ePerson"
							name="enterpriseFormMap.ePerson"
							value="${enterpriseFormMap.ePerson }" placeholder="请输入：法人名称" maxlength="20">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6 ">
				<div class="col-md-3 div_label">联系电话</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="ePhone"
							name="enterpriseFormMap.ePhone"
							value="${enterpriseFormMap.ePhone }" placeholder="请输入：联系电话" maxlength="20">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">资信情况</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="eCredit"
							name="enterpriseFormMap.eCredit"
							value="${enterpriseFormMap.eCredit }" placeholder="请输入：资信情况" maxlength="20">
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
			$("#form").submit();
		}
	</script>
</body>
</html>
