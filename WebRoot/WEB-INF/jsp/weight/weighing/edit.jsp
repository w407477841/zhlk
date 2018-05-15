<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
	<div class=" col-md-6">
		<div class=" col-md-12">
			<h3 class="animated rubberBand">称重信息</h3>
		</div>
	</div>
	<div class=" col-md-6">
	<div class=" col-md-12" style="text-align: right;">
	<h3 class="animated ">
	    <button type="button" class="btn btn-danger btn-sm" onclick="changeDisable()">修改配重</button>
	    </h3>
	 </div>
	</div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/weighing/edit.shtml">
			<input type="hidden" name="token" value="${token }"> <input
				type="hidden" name="weighingFormMap.id"
				value="${weighingFormMap.id }"> <input type="hidden"
				name="weighingFormMap.version" value="${weighingFormMap.version }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">单据号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" name="weighingFormMap.bId"
							value="${weighingFormMap.bId }" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">车牌号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="carId"
							name="weighingFormMap.carId" value="${weighingFormMap.carId }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">毛重</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="grossWeight"
							name="weighingFormMap.grossWeight"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)" value="${weighingFormMap.grossWeight }"
							placeholder="请输入 ：毛重" maxlength="8"
							${weighingFormMap.grossWeight== null?'disabled="disabled"':''}>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">皮重</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" placeholder="请输入 ：皮重"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')" id="tare"
							onblur="validFloat(this)" name="weighingFormMap.tare"
							value="${weighingFormMap.tare }" maxlength="8"
							${weighingFormMap.tare == null?'disabled="disabled"':''}>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">称毛时间</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="weighingFormMap.grossWeightDate"
							value="${weighingFormMap.grossWeightDate }" disabled="disabled">

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">称皮时间</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="weighingFormMap.tarDate"
							value="${weighingFormMap.tarDate }" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">司磅员</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="weighingFormMap.weightPerson"
							value="${weighingFormMap.weightPerson }" placeholder="请输入 ：司磅员">
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
								icon : 7
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
		function changeDisable(){
			$("#grossWeight").attr("disabled",false);
			$("#tare").attr("disabled",false);
			$("#carId").attr("disabled",false);
		}
	</script>
</body>
</html>
