<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE >
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
		<form id="form" name="form" method="post" action="${ctx}/storage/editWeight.shtml">
			<input type="hidden" name="token" value="${token}">
			<input type="hidden" name="WeightingFormMap.basicid" value="${WeightingFormMap.basicid}">
			<input type="hidden" name="WeightingFormMap.in" value="${WeightingFormMap.inorout}">
			
		<div class="form-group col-md-12" style=" padding: 10px;margin: 10px 0">
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">车牌号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="WeightingFormMap.carid" value="${WeightingFormMap.carid}" placeholder="车牌号">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总毛重:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="WeightingFormMap.TotalWeight" value="${WeightingFormMap.totalWeight}" placeholder="总毛重">
							<input type="hidden"name="WeightingFormMap.wTotalWeight" value="${WeightingFormMap.totalWeight}" >
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总皮重:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="WeightingFormMap.CarWeight" value="${WeightingFormMap.carWeight}" placeholder="总皮重">
						<input type="hidden"name="WeightingFormMap.wCarWeight" value="${WeightingFormMap.carWeight}" >
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">毛重时间:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="WeightingFormMap.totalWeightingTime" value="${WeightingFormMap.totalWeightingTime}" placeholder="毛重时间">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">皮重时间:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="WeightingFormMap.carWeightingTime" value="${WeightingFormMap.carWeightingTime}" placeholder="皮重时间">
						</div>
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
