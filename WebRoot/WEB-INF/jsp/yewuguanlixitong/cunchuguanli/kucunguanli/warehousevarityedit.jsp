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
		<div class=" col-md-6">
			<h3 class="animated rubberBand">仓库品种/性质</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/store/edit.shtml">
			<input type="hidden" name="token" value="${token }"> <input
				type="hidden" name="storageInfoFormMap.id"
				value="${storageInfoFormMap.id }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							name="storageInfoFormMap.source" data-rel="chosen"
							data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					仓号<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseName"
							name="storageInfoFormMap.storageID" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮食品种<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="varity"
							name="storageInfoFormMap.name" data-rel="chosen"
							data-placeholder="请选择粮食品种">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮食性质<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="category"
							name="storageInfoFormMap.quanZhong" data-rel="chosen"
							data-placeholder="请选择粮食性质">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					收获年度<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入收获年度" data-options="required:true" id="buyYear"
							placeholder="请输入 ：收获年度" name="storageInfoFormMap.buyYear"
							value="${storageInfoFormMap.buyYear }" maxlength="4">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					包装方式<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="packageWay"
							name="storageInfoFormMap.packageWay" data-rel="chosen"
							data-placeholder="请选择包装方式">
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
	<script type="text/javascript"
		src="${pageContext.servletContext.contextPath}/common/common_code.js">
		
	</script>
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
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}

		var sel = new myselect({
			obj_id : "warehouseLocation",
			url : "${ctx}/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ",",
			selected_val : "${storageInfoFormMap.source}"

		}, function() {
			//给change事件添加方法
			$("#warehouseName").html("");
			$("#warehouseName").chosen("destroy");
			findWarehouse($("#warehouseLocation").val());
			$("#warehouseName").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法
			findWarehouse($("#warehouseLocation").val());
		});

		function findWarehouse(location) {
			new myselect({
				obj_id : "warehouseName",
				url : "${ctx}/warehouse/findWareHouseByLocation.shtml",
				data : {
					"location_id" : location
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ",",
				selected_val : "${storageInfoFormMap.storageID}"

			}, function() {
				//给change事件添加方法
				find_variety_property($("#warehouseName").val());
			}, function() {
				//初始化执行方法
			});
		}

		new myselect({
			obj_id : "category",
			url : rootPath + "/property/findEnable.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "text" ],
			option_html_prefix : ",",
			selected_val : "${storageInfoFormMap.quanZhong}"

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});

		new myselect({
			obj_id : "varity",
			url : "${ctx}/variety/findEnableVariety.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "text" ],
			option_html_prefix : ",",
			selected_val : "${storageInfoFormMap.name}"

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});

		//包装方式 开始
		Util.code({
			obj_id : "packageWay",
			codeid : "26",
			selected_val : "${storageInfoFormMap.packageWay}"
		});
		$("#packageWay").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
		//包装方式 结束

		(function() {
			var weight = '${storageInfoFormMap.cangKu}';
			$("#warehouseLocation").prop("disabled", true);
			$("#warehouseLocation").trigger("chosen:updated");
			$("#warehouseName").prop("disabled", true);
			$("#warehouseName").trigger("chosen:updated");
			if (weight != null && weight != 0) {
				$("#varity").prop("disabled", true);
				$("#varity").trigger("chosen:updated");
				$("#category").prop("disabled", true);
				$("#category").trigger("chosen:updated");
				$("#packageWay").prop("disabled", true);
				$("#packageWay").trigger("chosen:updated");
			}
		})();
	</script>
</body>
</html>
