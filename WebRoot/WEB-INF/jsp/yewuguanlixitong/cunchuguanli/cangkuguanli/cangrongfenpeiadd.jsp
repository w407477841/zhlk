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
			<h3 class="animated rubberBand">仓容分配</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/cangrongfenpei/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">粮库地点<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen" data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">仓号<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<select class="form-control" id="warehouseName"
							name="cangRongFenPeiFormMap.wscId" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">内墙长(米)<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入内墙长" data-options="required:true" id="innerlong"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validAndSum(this)"
							name="cangRongFenPeiFormMap.wscInnerLong"
							placeholder="请输入 ：内墙长(米)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">内墙宽(米)<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入内墙宽" data-options="required:true" id="innerwidth"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validAndSum(this)"
							name="cangRongFenPeiFormMap.wscInnerWidth"
							placeholder="请输入 ：内墙宽(米)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">堆粮限高(米)<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入堆粮限高" data-options="required:true" id="limitheight"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validAndSum(this)"
							name="cangRongFenPeiFormMap.wscLimitHeight"
							placeholder="请输入 ：堆粮限高(米)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">粳稻密度(kg/m³)<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入粳稻堆放密度" data-options="required:true" id="JaponicaRiceDensity"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validAndSum(this)"
							name="cangRongFenPeiFormMap.wscJaponicaRiceDensity"
							placeholder="请输入 ：粳稻堆放密度(kg/m³)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">小麦密度(kg/m³)<span>*</span></div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入小麦堆放密度" data-options="required:true" id="WheatDensity"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validAndSum(this)"
							name="cangRongFenPeiFormMap.wscWheatDensity"
							placeholder="请输入 ：小麦堆放密度(kg/m³)" maxlength="5">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">粳稻仓容(kg)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="JaponicaRiceWeight"
							readonly="readonly"
							name="cangRongFenPeiFormMap.wscJaponicaRiceWeight">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">小麦仓容(kg)</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="WheatWeight"
							readonly="readonly" name="cangRongFenPeiFormMap.wscWheatWeight">
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
			}, function() {
				//初始化执行方法
			});
		}

		function validAndSum(obj) {
			var val = obj.value;
			while (val.length > 0) {
				var ind = val.indexOf(".");
				if (ind >= 0) { // 判断是否有小数点
					var temp = val.substring(ind + 1);
					var tind = temp.indexOf(".");
					if (tind >= 0) { // 判断是否有两个小数点
						val = '0.0';
						break;
					} else {
						var integer = val.substring(0, ind);
						var decimal = val.substring(ind + 1);
						if (integer == null || integer == '') {
							integer = 0;

						} else {
							while (integer.indexOf("-") >= 0) {
								integer = integer.replace("-", "");
							}

							while (integer.length > 0) { // 去除整数前的0
								var first = integer.substring(0, 1);
								if (first != '0') {
									break;
								} else {
									integer = integer.substring(1);
								}
							}
							if (integer == null || integer == '') {
								integer = 0;
							}
						}
						if (decimal.length != null && decimal.length != "") {
							while (decimal.indexOf("-") >= 0) {
								decimal = decimal.replace("-", "");
							}
						}
						if (decimal.length > 2) {
							decimal = decimal.substring(0, 2);
						}
						val = integer + "." + decimal;
						break;
					}
				} else { // 去除整数前的0
					var first = val.substring(0, 1);
					if (first != '0') {
						break;
					} else {
						val = val.substring(1);
					}
				}
			}
			if (val.length > 0) {
				obj.value = val;
			} else {
				obj.value = 0;
			}

			getSum();
		}
		/**
		 * 根据长、宽、高、密度计算容量
		 */
		function getSum() {
			var long = $("#innerlong").val();
			var width = $("#innerwidth").val();
			var height = $("#limitheight").val();

			var japonicaRiceDensity = $("#JaponicaRiceDensity").val();
			var WheatDensity = $("#WheatDensity").val();

			if (!isEmpty(long) && !isEmpty(width) && !isEmpty(height)) {
				if (!isEmpty(japonicaRiceDensity)) {
					$("#JaponicaRiceWeight").val(
							formatFloat(long * width * height
									* japonicaRiceDensity));
				}
				if (!isEmpty(WheatDensity)) {

				}
				$("#WheatWeight").val(
						formatFloat(long * width * height * WheatDensity));
			}
		}
		/**
		 * 判断是否为空
		 */
		function isEmpty(target) {
			if (target == null || target == "") {
				return true;
			} else {
				return false;
			}
		}
		/**
		 * 格式化浮点数
		 */
		function formatFloat(data) {
			return data.toFixed(2);
		}

		function _submit() {
			if($("#form").form("validate")){
				$("#form").submit();     
		     }
		}
	</script>
</body>
</html>
