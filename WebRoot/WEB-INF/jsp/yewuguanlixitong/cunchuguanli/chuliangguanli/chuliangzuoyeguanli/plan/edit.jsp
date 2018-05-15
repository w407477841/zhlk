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
			<h3 class="animated rubberBand">作业计划</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/foodStorageManager/editPlan.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="FoodStoragePlanFormMap.id"
				value="${FoodStoragePlanFormMap.id}">

				<div class="form-group col-md-12">
					<div class="form-group col-md-6">
						<div class="col-md-2 div_label">方案类型<span>*</span></div>
						<div class="col-md-10">
							<div class="has-warning">
								<select id="selectRs" data-rel="chosen" data-placeholder="请选择方案类型"
									name="FoodStoragePlanFormMap.title">
									<option value=""></option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-group col-md-6">
						<div class="col-md-2 div_label">开始时间<span>*</span></div>
						<div class="col-md-10">
							<div class="has-warning">
								<input id="start" type="text"
									class="form-control easyui-validatebox" missingMessage="请输入开始时间" data-options="required:true"
									name="FoodStoragePlanFormMap.times"
									value="${FoodStoragePlanFormMap.times}" placeholder="请输入：开始时间">
							</div>
						</div>
					</div>

					<div class="form-group col-md-6">
						<div class="col-md-2 div_label">结束时间<span>*</span></div>
						<div class="col-md-10">
							<div class="has-warning">
								<input id="start1" type="text"
									class="form-control easyui-validatebox" missingMessage="请输入结束时间" data-options="required:true"
									name="FoodStoragePlanFormMap.timee"
									value="${FoodStoragePlanFormMap.timee}" placeholder="请输入：结束时间">
							</div>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<button type="button" class="btn btn-info bt-submit"
						onclick="_submit()">提交</button>
				</div>
				<div class="form-group col-md-12" style="height:100px;">
				</div>
		</form>
	</div>
	<script type="text/javascript">
		laydate({
			elem : '#start',
			event : 'focus'
		});
		laydate({
			elem : '#start1',
			event : 'focus'
		});
		$.ajax({
			url : rootPath + "/foodStorageManager/queryTotalProjects.shtml",
			type : "post",
			async : false,
			success : function(rs) {
				var sel = document.getElementById("selectRs");
				if (rs.success) {
					for (var i = 0; i < rs.rs.length; i++) {
						var title = rs.rs[i].wName
								+ CONFIGURE.TYPE[rs.rs[i].type] + "方案";
						sel.add(new Option(title, title));
					}
				}

			}
		})

		var autoSettingValue = (function() {
			var ls = []
			return function() {
				for (var i = 0; i < document.forms[0].elements.length; i++) {
					if (document.forms[0].elements[i].type == "select-one") {
						ls.push(document.forms[0].elements[i]);
					}
				}
				return ls
			}

		})()
		var elem = autoSettingValue();
		var v = document.getElementsByClassName("temp");
		for (var i = 0; i < elem.length; i++) {
			for (var j = 0; j < elem[i].options.length; j++) {
				if (elem[i].options[j].value == v[i].value)
					elem[i].options[j].selected = true;

			}
		}

		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data) {
							layer.alert('修改成功！', 3);
						} else {
							layer.alert('修改失败！', 3);
						}
					}
				});
			},
			rules : {

			},
			messages : {},
			errorPlacement : function(error, element) {
				

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
