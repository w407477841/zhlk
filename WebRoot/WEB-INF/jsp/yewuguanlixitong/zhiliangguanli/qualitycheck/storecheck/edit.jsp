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

.title_header_label {
	padding: 0 0 0 0;
	border-left: 1px #ffffff solid;
	border-right: 1px #ffffff solid;
	text-align: center;
	height: 35px;
	line-height: 35px;
	background-color: #D1D1D1;
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">库存统仓信息</h3>
		</div>
	</div>
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h4 class="animated rubberBand">基础信息</h4>
		</div>
	</div>
	<form id="form" name="form" method="post"
		action="${ctx}/qualityManager/editQualityCheck.shtml">
		<input type="hidden" name="token" value="${token }"> <input
			type="hidden" name="qualityManagerFormMap.id"
			value="${qualityManagerFormMap.id }"> <input type="hidden"
			name="qualityManagerFormMap.version"
			value="${qualityManagerFormMap.version }">
		<div class=" col-md-12">
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
							name="qualityManagerFormMap.wId" data-rel="chosen"
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
						<input type="text" class="form-control"
							id="variety" name="qualityManagerFormMap.grainVariety"
							readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮食性质</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="property"
							name="qualityManagerFormMap.grainProperty" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">包装方式</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="packageWay"
							name="qualityManagerFormMap.packageWay" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">当前重量</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="currentWeight"
							name="qualityManagerFormMap.currentWeight" readonly="readonly">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮权归属</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="qualityManagerFormMap.grainOwnership" value="${qualityManagerFormMap.grainOwnership }" placeholder="请输入：粮权归属" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">管理方式</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="qualityManagerFormMap.managerWay" value="${qualityManagerFormMap.managerWay }" placeholder="请输入：管理方式" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">入仓方式</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="qualityManagerFormMap.putinWay" value="${qualityManagerFormMap.putinWay }" placeholder="请输入：入仓方式" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">业务类型</div>
				<div class="col-md-10">
					<div class="has-warning">
					<select class="form-control"
							name="qualityManagerFormMap.businessType" data-rel="chosen"
							data-placeholder="请选择业务类型">
							<option value="1">入库</option>
							<option value="2">出库</option>
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
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入收获年度" data-options="required:true"
							id="dateformat" name="qualityManagerFormMap.buyYear"
							value="${qualityManagerFormMap.buyYear }" placeholder="请输入：收获年度">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					检测日期<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入检测日期" data-options="required:true"
							id="dateformat1" name="qualityManagerFormMap.checkDate"
							value="${qualityManagerFormMap.checkDate }"
							placeholder="请输入：检测日期">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">摘要/备注</div>
				<div class="col-md-11">
					<div class="has-warning">
					 <textarea rows="4" cols="20" class="form-control" name="qualityManagerFormMap.remark" placeholder="请输入：摘要/备注">${qualityManagerFormMap.remark}</textarea>
					</div>
				</div>
			</div>
		</div>
		<div class=" col-md-12">
			<div class=" col-md-6">
				<h4 class="animated rubberBand">质检信息</h4>
			</div>
		</div>
		<div class="form-group col-md-12">
			<div class="col-md-12">
				<div class="col-md-1 title_header_label">容重|出糙</div>
				<div class="col-md-1 title_header_label">水分</div>
				<div class="col-md-1 title_header_label">杂质</div>
				<div class="col-md-1 title_header_label">其中矿物质</div>
				<div class="col-md-1 title_header_label">不完善粒度</div>
				<div class="col-md-1 title_header_label">整精米粒</div>
				<div class="col-md-1 title_header_label">谷外糙米</div>
				<div class="col-md-1 title_header_label">黄粒米</div>
				<div class="col-md-1 title_header_label">互混</div>
				<div class="col-md-1 title_header_label">赤霉病粒</div>
				<div class="col-md-1 title_header_label">硬度指数</div>
				<div class="col-md-1 title_header_label">色泽气味</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 title_header_label">
					<input type="text" id="01or02" class="form-control"
						name="qualityManagerFormMap.rz" value="0.0" readonly="readonly"
						onblur="onChange_price(this)">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="03" class="form-control"
						name="qualityManagerFormMap.sf" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('03')">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="04" class="form-control"
						name="qualityManagerFormMap.zz" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('04')">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="05" class="form-control"
						name="qualityManagerFormMap.kwz" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('05')">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="06" class="form-control"
						name="qualityManagerFormMap.bwsld" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('06')">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="07" class="form-control"
						name="qualityManagerFormMap.zjml" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('07')">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="08" class="form-control"
						name="qualityManagerFormMap.gwcm" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('08')">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="09" class="form-control"
						name="qualityManagerFormMap.hlm" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('09')">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="10" class="form-control"
						name="qualityManagerFormMap.hh" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly"
						onblur="change_reduce_rate('10')">
				</div>

				<div class="col-md-1 title_header_label">
					<input type="text" id="14" class="form-control"
						name="qualityManagerFormMap.cmbl" value="0.0"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
						onblur="change_cmbl('14')" maxlength="5">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="12" class="form-control"
						name="qualityManagerFormMap.ydzs" value="48"
						onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
						onblur="validFloat(this)" maxlength="5">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="13" class="form-control"
						name="qualityManagerFormMap.szqw" value="正常" maxlength="12">
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-1 title_header_label">等级</div>
				<div class="col-md-8 title_header_label">分项扣量(%)</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 title_header_label">
					<input type="text" id="01or02_val" class="form-control"
						name="qualityManagerFormMap.level" value="3" readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="03_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="04_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="05_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="06_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="07_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="08_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="09_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
				<div class="col-md-1 title_header_label">
					<input type="text" id="10_val" class="form-control" value="0.0"
						readonly="readonly">
				</div>
			</div>
		</div>

		<div class="form-group col-md-12">
			<button type="button" class="btn btn-info bt-submit"
				onclick="_submit()">提交</button>
		</div>
	</form>
	<script type="text/javascript">
		laydate({
			elem : '#dateformat',
			event : 'focus',
			format : 'YYYY'
		});
		laydate({
			elem : '#dateformat1',
			event : 'focus',
			format : 'YYYY-MM-DD hh:mm:ss'
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
							layer.alert('修改失败！', {
								icon : 5
							});
						}
					}
				});
			},
			rules : {

			},
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
			selected_val : '${qualityManagerFormMap.wlId}'

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
				selected_val : '${qualityManagerFormMap.wId}'
			}, function() {
				//给change事件添加方法
				find_variety_property($("#warehouseName").val());
			}, function() {
				//初始化执行方法
				find_variety_property($("#warehouseName").val());
			});
		}
		//根据仓号获取粮食品种和粮食属性
		function find_variety_property(warehouse_id) {
			$.ajax({
				dataType : 'json',
				type : 'post',
				url : '${ctx}/kcxx/findVAndPByWId.shtml',
				data : {
					id : warehouse_id
				},
				success : function(data) {
					if (data.name != null) {
						$("#variety").val(data.variety);
						$("#property").val(data.property);
						$("#packageWay").val(data.packageText);
						$("#dateformat").val(data.buyYear);
						$("#currentWeight").val(parseFloat(data.cangKu));
						find_quality(data.name);
					} else {
						$("#variety").val('');
						$("#property").val('');
						$("#packageWay").val('');
						$("#dateformat").val('');
						$("#currentWeight").val('');
						readOnly();
					}
				}
			});
		}
		function readOnly() {
			$("#01or02").val("0.0");
			$("#01or02").attr("readonly", "readonly");
			for (var i = 3; i <= 10; i++) {
				if (i < 10) {
					$("#0" + i).val("0.0");
					$("#0" + i).attr("readonly", "readonly");
				} else {
					$("#" + i).val("0.0");
					$("#" + i).attr("readonly", "readonly");
				}
			}
		}
		//根据粮食品种获取国标质检信息
		function find_quality(grainId) {
			$.ajax({
				dataType : 'json',
				type : 'post',
				url : '${ctx}/quality/findQualityByVarietyId.shtml',
				data : {
					id : grainId
				},
				success : function(data) {
					if (data != null) {
						//console.log(data);
						qualityArr = data;
						for (var i = 0; i < data.length; i++) {
							var id = data[i].id;
							var vId = data[i].aId;
							if (vId != undefined) {
								if (id == '01' || id == '02') {
									$("#01or02").val(data[i].standard);
									$("#01or02").removeAttr("readonly");
								} else {
									$("#" + id).val(data[i].standard);
									$("#" + id).removeAttr("readonly");
								}
							} else {
								if (id == '01' || id == '02') {
									//$("#01|02").val(data[i].standard);
								} else {
									$("#" + id).val("0.0");
									$("#" + id).attr("readonly", "readonly");
								}
							}
						}

					} else {
						layer.alert('国标质检信息获取失败！', {
							icon : 7
						});
					}
				}
			});
		}
		var qualityArr;
		var variety;
		//改变容重或出糙，进行等级计算和价格计算
		function onChange_price(obj) {
			var temp = null;
			for (var i = 0; i < qualityArr.length; i++) {
				if (qualityArr[i].id == '01' || qualityArr[i].id == '02') {
					if (qualityArr[i].vId != undefined) {
						temp = qualityArr[i];
						break;
					}
				}
			}
			if (temp != null) {
				var maxVal = temp.maxiValue; //最大区间
				var minVal = temp.miniValue; //最小区间
				var standard = temp.standard; //标准值
				var rank = temp.rank; //等级差

				var valu = $(obj).val();
				if (valu > maxVal || valu < minVal) {
					$(obj).val(standard);
					$("#01or02_val").val("3");
					layer.alert("超出范围【" + minVal + "-" + maxVal + "】", {
						icon : 7
					});
				} else {
					var diff = Math.floor((valu - standard) / rank);
					if (3 - diff < 1) {
						$("#01or02_val").val("1");
					} else if (3 - diff > 5) {
						$("#01or02_val").val("等外");
					} else {
						$("#01or02_val").val(3 - diff);
					}
				}
			}
		}

		//根据质检信息进行扣量计算
		function change_reduce_rate(obj) {
			var temp = null;
			for (var i = 0; i < qualityArr.length; i++) {
				if (qualityArr[i].id == obj) {
					temp = qualityArr[i];
				}
			}
			if (temp != null) {
				var maxVal = temp.maxiValue; //最大区间
				var minVal = temp.miniValue; //最小区间
				var standard = temp.standard; //标准值
				var reduceRate = temp.reduceStandard;
				var reduceValue = temp.reduceValue;
				var increaseRate = temp.increaseRange;
				var increaseValue = temp.increaseValue;

				var valu = $("#" + obj).val();
				if ($("#" + obj).attr("readonly") != 'readonly') {
					if (valu > maxVal || valu < minVal) {
						$("#" + obj).val(standard);
						$("#" + obj + "_val").val("0.0");
						layer.alert("超出范围【" + minVal + "-" + maxVal + "】", {
							icon : 7
						});
					} else {
						if (valu >= standard) {
							if (reduceRate != 0) {
								var diff = Math.floor((valu - standard)
										/ reduceRate);
								$("#" + obj + "_val").val(diff * reduceValue);
							} else {
								$("#" + obj + "_val").val("0.0");
							}
						} else {
							if (increaseRate != 0) {
								var diff = Math.floor((standard - valu)
										/ increaseRate);
								$("#" + obj + "_val").val(
										-(diff * increaseValue));
							} else {
								$("#" + obj + "_val").val("0.0");
							}
						}
						get_total_reduce();
					}
				}
			}
		}
		//获取总的扣量
		function get_total_reduce() {
			var total = 0.0;
			for (var i = 3; i < 10; i++) {
				total += parseFloat($("#0" + i + "_val").val());
			}
			total += parseFloat($("#10_val").val());
			total += parseFloat($("#11").val());
			$("#totalReduce").val(total);
		}
		//赤霉病粒
		function change_cmbl(obj) {
			var txt = $("#" + obj).val();
			if (txt<0 || txt >4) {
				$("#" + obj).val("0.0");
				layer.alert("超出范围【0-4】", {
					icon : 7
				});
			}
		}
		window.onload = function() {
			init();
		}
		function init() {
			$("#01or02").val('${qualityManagerFormMap.rz}');
			$("#03").val('${qualityManagerFormMap.sf}');
			$("#04").val('${qualityManagerFormMap.zz}');
			$("#05").val('${qualityManagerFormMap.kwz}');
			$("#06").val('${qualityManagerFormMap.bwsld}');
			$("#07").val('${qualityManagerFormMap.zjml}');
			$("#08").val('${qualityManagerFormMap.gwcm}');
			$("#09").val('${qualityManagerFormMap.hlm}');
			$("#10").val('${qualityManagerFormMap.hh}');

			$("#12").val('${qualityManagerFormMap.ydzs}');
			$("#14").val('${qualityManagerFormMap.cmbl}');
			$("#13").val('${qualityManagerFormMap.szqw}');
		}

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>


</body>
</html>
