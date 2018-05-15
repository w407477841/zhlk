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
			<h3 class="animated rubberBand">仓房移交</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/yijiaoguanli/add.shtml">
			<input type="hidden" name="token" value="${token }">
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
							name="yiJiaoGuanLiFormMap.wtId" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					当前保管员<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输选择仓号" data-options="required:true"
							id="nowStoreman" readonly="readonly"> <input
							type="hidden" id="nowStoremanId"
							name="yiJiaoGuanLiFormMap.wtOriginalStoreman">

					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					移交日期<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入移交日期" data-options="required:true"
							id="dateformat" placeholder="请输入 ：移交日期"
							name="yiJiaoGuanLiFormMap.wtTransferDate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					保管员<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="waStoreman"
							name="yiJiaoGuanLiFormMap.wtNowStoreman" data-rel="chosen"
							data-placeholder="请选择保管员">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">备注</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="10" class="form-control"
							name="yiJiaoGuanLiFormMap.wtRemark" placeholder="请输入 ：备注"
							maxlength="256"></textarea>
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
							layer.alert('添加失败！', {
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
				getStoreman($("#warehouseName").val());

			}, function() {
				//初始化执行方法
			});
		}
		/**
		 * 根据仓库获取管理员
		 */
		function getStoreman(wId) {
			var _url = "${ctx}/cangfangxinxi/findStoremanById.shtml";
			$.ajax({
				type : "POST",
				url : _url,
				async : true,
				data : "wId=" + wId,
				success : function(data) {
					if (data != null) {
						if (data.id == undefined) {
							alert("请先完善此仓库的基础信息");
							$("#nowStoremanId").val(data.id);
							$("#nowStoreman").val(data.paName);
						} else {
							$("#nowStoremanId").val(data.id);
							$("#nowStoreman").val(data.paName);
						}
					}
				}
			});
		}

		var sele = new myselect({
			obj_id : "waStoreman",
			url : "${ctx}/renyuandangan/findRenYuanDangAn.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "paName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});
		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
