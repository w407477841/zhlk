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
.laydate-icon{
height: 38px;
line-height: 38px
}
.div_lable1{
text-align: center; height: 56px;line-height: 56px
}
.form-control{
padding: 0px 12px
}
.form-control{
padding: 0px 12px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<form id="form" name="form" method="post" action="${ctx}/storage/addWeight.shtml">
			<input type="hidden" name="token" value="${token}">
			<input type="hidden" name="WeightingFormMap.id" value="${id}">	
		<div class="form-group col-md-6" style=" padding: 10px;margin: 10px 0">
					<div class="col-md-12">
						<div class="has-warning">
							<input type="text" class="form-control" name="WeightingFormMap.TotalWeight" placeholder="重量(净重)">
						</div>
					</div>
		</div>									

			<div class="form-group col-md-12" style="text-align: center;">
				<button type="button" class="btn btn-info bt-submit"onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		
		

		$("#form").validate({
		submitHandler : function(form) {
								ly.ajaxSubmit(form, {
									type : "post",
									dataType : "json",
									success : function(data) {
										if (data) {
											layer.alert('添加成功！', 3);
											parent.searchBtn.click()
											setTimeout(function(){parent.layer.closeAll()},1000);
										} else {
											layer.alert('添加失败！', 3);
										}
									}
								});
							},
							rules : {
								"WeightingFormMap.TotalWeight" : {required : true,number : true},
							},
							messages : {
								},
							errorPlacement : function(error, element) {
							if (element[0].classList.contains("error")) {
									element[0].style.cssText = "border: 1px solid #ff0000";
								} else if (element[0].classList.contains("valid")) {
									element[0].style.cssText = "";
								}
							
							},
							success : function(label) {// 验证通过后
								label.parent().attr("class", "has-success");
							}
						});



		function _submit() {
				$("#form").submit();
		}
	</script>
</body>
</html>
