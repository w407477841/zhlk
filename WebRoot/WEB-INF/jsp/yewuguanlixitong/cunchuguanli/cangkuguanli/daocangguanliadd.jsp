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
			<h3 class="animated rubberBand">倒仓信息</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/daocangguanli/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">原始粮库<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen" data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">目标粮库<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation2"
							data-rel="chosen" data-placeholder="请选择目标粮库地点">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">原仓号<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseName"
							name="daoCangGuanLiFormMap.wgtOriginalId" data-rel="chosen"
							data-placeholder="请选择原仓号">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">目标仓号<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseName2"
							name="daoCangGuanLiFormMap.wgtTargetId" data-rel="chosen"
							data-placeholder="请选择目标仓号">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">原仓内品种</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="OriginalVariety"> <input type="hidden"
							id="wgtOriginalVariety"
							name="daoCangGuanLiFormMap.wgtOriginalVariety">

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">目标仓内品种</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="TargetVariety"> <input type="hidden"
							id="wgtTargetVariety"
							name="daoCangGuanLiFormMap.wgtTargetVariety">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">原仓性质</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="OriginalCategory"> <input type="hidden"
							id="wgtOriginalCategory"
							name="daoCangGuanLiFormMap.wgtOriginalCategory">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">目标仓性质</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="TargetCategory"> <input type="hidden"
							id="wgtTargetCategory"
							name="daoCangGuanLiFormMap.wgtTargetCategory">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">原仓保管员</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="OriginalStoreman"> <input type="hidden"
							id="wgtOriginalStoreman"
							name="daoCangGuanLiFormMap.wgtOriginalStoreman">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">目标仓保管员</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="TargetStoreman"> <input type="hidden"
							id="wgtTargetStoreman"
							name="daoCangGuanLiFormMap.wgtTargetStoreman">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">原仓库存量</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="OriginalStorageRate"
							name="daoCangGuanLiFormMap.wgtOriginalStorageRate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">目标仓库存量</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" readonly="readonly"
							id="TargetStorageRate"
							name="daoCangGuanLiFormMap.wgtTargetStorageRate">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">倒仓单号<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入倒仓单号" data-options="required:true"
							name="daoCangGuanLiFormMap.wgtBill" placeholder="请输入倒仓原单号"
							maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">倒仓日期<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control  easyui-validatebox" missingMessage="请输入倒仓日期" data-options="required:true" id="dateformat"
							placeholder="请输入 ：倒仓日期"
							name="daoCangGuanLiFormMap.wgtTransferDate">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">倒仓原因<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入倒仓原因" data-options="required:true"
							name="daoCangGuanLiFormMap.wgtCause" placeholder="请输入倒仓原因"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">倒仓数量(kg)<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control  easyui-validatebox" missingMessage="请输入倒仓数量" data-options="required:true"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validNum(this)" name="daoCangGuanLiFormMap.wgtNumber"
							placeholder="请输入倒仓数量(kg)" maxlength="9">
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
		/**
		 *原始
		 */
		var sel = new myselect({
			obj_id : "warehouseLocation",
			url : "${ctx}/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ","

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
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
				findDaoCang($("#warehouseName").val());
			}, function() {
				//初始化执行方法
			});
		}

		function findDaoCang(wId) {
			$.ajax({
				url : "${ctx}/daocangguanli/findByWarehouseId.shtml",
				type : "POST",
				async : true,
				data : "id=" + wId,
				success : function(data) {
					if (data != null && data.id != undefined) {
						$("#wgtOriginalVariety").val(data.name);
						$("#OriginalVariety").val(data.variety);
						$("#wgtOriginalCategory").val(data.quanZhong);
						$("#OriginalCategory").val(data.category);
						$("#wgtOriginalStoreman").val(data.waStoreman);
						$("#OriginalStoreman").val(data.paName);
						$("#OriginalStorageRate").val(data.cangKu);
					} else {
						alert("请先完善此仓库信息！");
						$("#wgtOriginalVariety").val("");
						$("#OriginalVariety").val("");
						$("#wgtOriginalCategory").val("");
						$("#OriginalCategory").val("");
						$("#wgtOriginalStoreman").val("");
						$("#OriginalStoreman").val("");
						$("#OriginalStorageRate").val("");
					}
				}

			});
		}
		/**
		 * 目标
		 */
		var selec = new myselect({
			obj_id : "warehouseLocation2",
			url : "${ctx}/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
			$("#warehouseName2").html("");
			$("#warehouseName2").chosen("destroy");
			findWarehouse2($("#warehouseLocation2").val());
			$("#warehouseName2").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法
		});

		function findWarehouse2(location) {
			new myselect({
				obj_id : "warehouseName2",
				url : "${ctx}/warehouse/findWareHouseByLocation.shtml",
				data : {
					"location_id" : location
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
				findDaoCang2($("#warehouseName2").val());
			}, function() {
				//初始化执行方法
			});
		}
		function findDaoCang2(wId) {
			$.ajax({
				url : "${ctx}/daocangguanli/findByWarehouseId.shtml",
				type : "POST",
				async : true,
				data : "id=" + wId,
				success : function(data) {
					if (data != null && data.id != undefined) {
						$("#wgtTargetVariety").val(data.name);
						$("#TargetVariety").val(data.variety);
						$("#wgtTargetCategory").val(data.quanZhong);
						$("#TargetCategory").val(data.category);
						$("#wgtTargetStoreman").val(data.waStoreman);
						$("#TargetStoreman").val(data.paName);
						$("#TargetStorageRate").val(data.cangKu);
					} else {
						alert("请先完善此仓库信息！");
						$("#wgtTargetVariety").val("");
						$("#TargetVariety").val("");
						$("#wgtTargetCategory").val("");
						$("#TargetCategory").val("");
						$("#wgtTargetStoreman").val("");
						$("#TargetStoreman").val("");
						$("#TargetStorageRate").val("");
					}
				}

			});
		}
		function notNull(target) {
			if (target == null || target == "") {
				return false;
			} else {
				return true;
			}
		}
		function validNum(obj){
			var num = $(obj).val();
			var OriginalStorageRate = $("#OriginalStorageRate").val();
			
			if(parseFloat(OriginalStorageRate) < parseFloat(num)){
				$(obj).val(OriginalStorageRate);
				layer.alert("超出仓内库存量！");
			}
			
		}
		
		function _submit() {

			var tv = $("#wgtTargetVariety").val();
			var tc = $("#wgtTargetCategory").val();

			var ov = $("#wgtOriginalVariety").val();
			var oc = $("#wgtOriginalCategory").val();

			var wn1 = $("#warehouseName").val();
			var wn2 = $("#warehouseName2").val();

			if (notNull(tv) && notNull(tc) && notNull(ov) && notNull(oc)
					&& tv == ov && tc == oc && wn1 != wn2) {
				if($("#form").form("validate")){
					$("#form").submit();     
			     }
			} else {
				layer.alert("不符合倒仓要求",{icon:5});
			}
		}
	</script>
</body>
</html>
