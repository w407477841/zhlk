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
	<div class=" col-md-6">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">仓房维修信息</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/cangfangweixiu/edit.shtml">
			<input type="hidden" name="cangFangWeiXiuFormMap.id"
				value="${cangFangWeiXiuFormMap.id }"> <input type="hidden"
				name="cangFangWeiXiuFormMap.version"
				value="${cangFangWeiXiuFormMap.version }"> <input
				type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库地点<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen" data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">仓号<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseName"
							name="cangFangWeiXiuFormMap.wId" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">维修日期<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入维修日期" data-options="required:true" id="dateformat1"
							placeholder="请输入 ：维修日期" name="cangFangWeiXiuFormMap.wrDate"
							value="${cangFangWeiXiuFormMap.wrDate}">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">保修到期日<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入保修到期" data-options="required:true" id="dateformat"
							placeholder="请输入 ：保修到期日" name="cangFangWeiXiuFormMap.wrMaturity"
							value="${cangFangWeiXiuFormMap.wrMaturity }">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">保修年限(年)</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)" name="cangFangWeiXiuFormMap.wrWarranty"
							placeholder="请输入 ：保修年限(年)"
							value="${cangFangWeiXiuFormMap.wrWarranty }" maxlength="10">
					</div>
				</div>
			</div>



			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">维修内容<span>*</span></div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="10" class="form-control easyui-validatebox" missingMessage="请输入维修内容" data-options="required:true"
							name="cangFangWeiXiuFormMap.wrContent" placeholder="请输入 ：维修内容"
							maxlength="256">${cangFangWeiXiuFormMap.wrContent }</textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">维修情况摘要</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="10" class="form-control"
							name="cangFangWeiXiuFormMap.wrSummary" placeholder="请输入 ：维修情况摘要"
							maxlength="256">${cangFangWeiXiuFormMap.wrSummary }</textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">效果</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="10" class="form-control"
							name="cangFangWeiXiuFormMap.wrEffect" placeholder="请输入 ：效果"
							maxlength="256">${cangFangWeiXiuFormMap.wrEffect}</textarea>
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
			elem : '#dateformat1',
			event : 'focus'
		});
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
							layer.confirm('修改成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('修改失败！', {icon:5});
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

		var sel = new myselect({
			obj_id : "warehouseLocation",
			url : "${ctx}/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ",",
			selected_val : "${cangFangWeiXiuFormMap.wLocation}"
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
				selected_val : "${cangFangWeiXiuFormMap.wId}"
			}, function() {
				//给change事件添加方法
			}, function() {
				//初始化执行方法
			});
		}

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
