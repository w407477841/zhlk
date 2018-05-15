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
			<h3 class="animated rubberBand">仓房信息</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/cangfangxinxi/edit.shtml">
			<input type="hidden" name="cangFangXinXiFormMap.id"
				value="${cangFangXinXiFormMap.id }"> <input type="hidden"
				name="cangFangXinXiFormMap.version"
				value="${cangFangXinXiFormMap.version}"> <input
				type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen" data-placeholder="请选择粮库地点">
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
							name="cangFangXinXiFormMap.wId" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">隔热设施</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="cangFangXinXiFormMap.waHeatInsulator"
							value="${cangFangXinXiFormMap.waHeatInsulator}"
							placeholder="请输入 ：隔热设施" maxlength="32">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					窗户数量(扇)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true" id="number"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" value="${cangFangXinXiFormMap.waWindow}"
							name="cangFangXinXiFormMap.waWindow" placeholder="请输入 ：窗户数量(扇)"
							maxlength="3">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">仓型</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select name="cangFangXinXiFormMap.waWarehouseType"
							id="waWarehouseType" data-rel="chosen" data-placeholder="请选择仓型"
							class="form-control">
							<option value=""></option>
							<option value="基建房式仓">基建房式仓</option>
							<option value="高大平房仓">高大平房仓</option>
							<option value="普通平房仓">普通平房仓</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					厫门数量(扇)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true" id="number"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)"
							value="${cangFangXinXiFormMap.waDoorNumber}"
							name="cangFangXinXiFormMap.waDoorNumber"
							placeholder="请输入 ：厫门数量(扇)" maxlength="3">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">结构</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="cangFangXinXiFormMap.waStructure"
							value="${cangFangXinXiFormMap.waStructure}" placeholder="请输入 ：结构"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">通风形式</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select name="cangFangXinXiFormMap.waAeration" id="waAeration"
							data-rel="chosen" data-placeholder="请选择通风形式" class="form-control">
							<option value=""></option>
							<option value="地下槽通风">地下槽通风</option>
							<option value="地上笼通风">地上笼通风</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">熏蒸方式</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select name="cangFangXinXiFormMap.waFumigate" id="waFumigate"
							data-rel="chosen" data-placeholder="请选择熏蒸方式" class="form-control">
							<option value=""></option>
							<option value="常规熏蒸">常规熏蒸</option>
							<option value="环流熏蒸">环流熏蒸</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">建造时间</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="dateformat"
							placeholder="请输入 ：建造时间"
							value="${cangFangXinXiFormMap.waConstructDate}"
							name="cangFangXinXiFormMap.waConstructDate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					设计容量(kg)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)"
							value="${cangFangXinXiFormMap.waDesignCapacity}"
							name="cangFangXinXiFormMap.waDesignCapacity"
							placeholder="请输入 ：设计容量(kg)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					堆粮高度(米)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							value="${cangFangXinXiFormMap.waDesignHeight}"
							name="cangFangXinXiFormMap.waDesignHeight"
							placeholder="请输入 ：堆粮高度(米)" maxlength="6">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					内墙长(米)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							value="${cangFangXinXiFormMap.waInnerLong}"
							name="cangFangXinXiFormMap.waInnerLong" placeholder="请输入 ：内墙长(米)"
							maxlength="6">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					内墙宽(米)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							data-options="required:true"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)"
							value="${cangFangXinXiFormMap.waInnerWidth}"
							name="cangFangXinXiFormMap.waInnerWidth"
							placeholder="请输入 ：内墙宽(米)" maxlength="6">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">保管员</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select name="cangFangXinXiFormMap.waStoreman" id="waStoreman"
							data-rel="chosen" data-placeholder="请选择保管员" class="form-control">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">排序号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="cangFangXinXiFormMap.waSequence"
							value="${cangFangXinXiFormMap.waSequence}" placeholder="请输入 ：排序号"
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
			selected_val : '${cangFangXinXiFormMap.wLocationId}'

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

		var sele = new myselect({
			obj_id : "waStoreman",
			url : "${ctx}/renyuandangan/findRenYuanDangAn.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "paName" ],
			option_html_prefix : ",",
			selected_val : '${cangFangXinXiFormMap.waStoreman}'

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
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
				selected_val : '${cangFangXinXiFormMap.wId}'
			}, function() {
				//给change事件添加方法

			}, function() {
				$("#waWarehouseType option[value='${cangFangXinXiFormMap.waWarehouseType}'] ").attr("selected", true);
		        $("#waAeration option[value='${cangFangXinXiFormMap.waAeration}'] ").attr("selected", true);
		        $("#waFumigate option[value='${cangFangXinXiFormMap.waFumigate}'] ").attr("selected", true);
		        $("#waStoreman option[value='${cangFangXinXiFormMap.waStoreman}'] ").attr("selected", true);
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
