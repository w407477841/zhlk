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
			action="${ctx}/foodStorageManager/addPlan.shtml">
			<input type="hidden" name="token" value="${token}">
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
								name="FoodStoragePlanFormMap.times" placeholder="请输入：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">结束时间<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="start1" type="text"
								class="form-control easyui-validatebox" missingMessage="请输入结束时间" data-options="required:true"
								name="FoodStoragePlanFormMap.timee" placeholder="请输入：结束时间">
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
			messages : {},
			errorPlacement : function(error, element) {
			},
			success : function(label) {// 验证通过后
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
