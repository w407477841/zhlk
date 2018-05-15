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
	<div class=" col-md-12">
		<h3 class="animated rubberBand">发货明细档案</h3>
	</div>

	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/deliverGoodsDetail/edit.shtml">
			<input type="hidden" name="token" value="${token }">
			<input type="hidden" name="deliverGoodsDetailFormMap.id" value="${deliverGoodsDetailFormMap.id }">
			<input type="hidden" name="deliverGoodsDetailFormMap.version" value="${deliverGoodsDetailFormMap.version }">
			<div class=" col-md-12">
				<h4 class="animated rubberBand">发货方信息</h4>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">合同编号</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.agreementBill"
							value="${deliverGoodsDetailFormMap.agreementBill }"
							placeholder="请输入 ：合同编号" maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">合同对方单位</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="agreementName"
							name="deliverGoodsDetailFormMap.agreementName"
							value="${deliverGoodsDetailFormMap.agreementName }"
							placeholder="请输入 ：合同对方单位" maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">出库单编号</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="getoutBill"
							name="deliverGoodsDetailFormMap.getoutBill"
							value="${deliverGoodsDetailFormMap.getoutBill }"
							placeholder="请输入 ：出库单编号" maxlength="32" onkeyup="find_data()">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">发货单位</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="deliverGoodsName"
							name="deliverGoodsDetailFormMap.deliverGoodsName"
							value="${deliverGoodsDetailFormMap.deliverGoodsName }"
							placeholder="请输入 ：发货单位" maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">发货站(港)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" placeholder="请输入 ：发货站(港)"
							name="deliverGoodsDetailFormMap.deliverGoodsStation"
							value="${deliverGoodsDetailFormMap.deliverGoodsStation }"
							maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">发货日期</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="deliverGoodsDate"
							name="deliverGoodsDetailFormMap.deliverGoodsDate"
							value="${deliverGoodsDetailFormMap.deliverGoodsDate }"
							placeholder="请输入 ：发货日期" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">品种</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="grainVariety"
							name="deliverGoodsDetailFormMap.grainVariety"
							value="${deliverGoodsDetailFormMap.grainVariety }"
							placeholder="请输入 ：品种" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">仓号</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="warehouseName"
							name="deliverGoodsDetailFormMap.warehouseName"
							value="${deliverGoodsDetailFormMap.warehouseName }"
							placeholder="请输入 ：仓号" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">发货数量(小写)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							id="deliverGoodsNumberLower"
							name="deliverGoodsDetailFormMap.deliverGoodsNumberLower"
							value="${deliverGoodsDetailFormMap.deliverGoodsNumberLower }"
							placeholder="请输入 ：发货数量(小写)" maxlength="16"
							onkeyup="upperNumber(this,'1')">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">发货数量(大写)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							id="deliverGoodsNumberUpper"
							name="deliverGoodsDetailFormMap.deliverGoodsNumberUpper"
							value="${deliverGoodsDetailFormMap.deliverGoodsNumberUpper }"
							placeholder="请输入 ：发货数量(大写)" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">发货方经办人</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.deliverGoodsPerson"
							value="${deliverGoodsDetailFormMap.deliverGoodsPerson }"
							placeholder="请输入 ：发货方经办人" maxlength="16">
					</div>
				</div>
			</div>
			<div class=" col-md-12">
				<h4 class="animated rubberBand">收货方信息</h4>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">收货单位</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.takeDeliveryName"
							value="${deliverGoodsDetailFormMap.takeDeliveryName }"
							placeholder="请输入 ：收货单位" maxlength="128" id="takeDeliveryName">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">到货站(港)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" placeholder="请输入 ：到货站(港)"
							name="deliverGoodsDetailFormMap.takeDeliveryStation"
							value="${deliverGoodsDetailFormMap.takeDeliveryStation }"
							maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">收货日期</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="takeDeliveryDate"
							name="deliverGoodsDetailFormMap.takeDeliveryDate"
							value="${deliverGoodsDetailFormMap.takeDeliveryDate }"
							placeholder="请输入 ：收货日期" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">接收数量(小写)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.takeDeliveryNumberLower"
							placeholder="请输入 ：接收数量(小写)" maxlength="16"
							value="${deliverGoodsDetailFormMap.takeDeliveryDate }"
							onkeyup="upperNumber(this,'2')">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">接收数量(大写)</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							id="takeDeliveryNumberUpper"
							name="deliverGoodsDetailFormMap.takeDeliveryNumberUpper"
							value="${deliverGoodsDetailFormMap.takeDeliveryNumberUpper }"
							placeholder="请输入 ：接收数量(大写)" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">实际损耗量</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.tureLossNumber"
							value="${deliverGoodsDetailFormMap.tureLossNumber }"
							placeholder="请输入 ：实际损耗量" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">超耗量</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.overstepNumber"
							value="${deliverGoodsDetailFormMap.overstepNumber }"
							placeholder="请输入 ：超耗量" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">收货方经办人</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.takeDeliveryPerson"
							value="${deliverGoodsDetailFormMap.takeDeliveryPerson }"
							placeholder="请输入 ：收货方经办人" maxlength="16">
					</div>
				</div>
			</div>
			<div class=" col-md-12">
				<h4 class="animated rubberBand">运输方信息</h4>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">运输单位</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.transportName"
							value="${deliverGoodsDetailFormMap.transportName }"
							placeholder="请输入 ：运输单位" maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">运输工具</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.transportTool"
							value="${deliverGoodsDetailFormMap.transportTool }"
							placeholder="请输入 ：运输工具" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">车（船）号</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control" id="carOrShipNo"
							name="deliverGoodsDetailFormMap.carOrShipNo"
							value="${deliverGoodsDetailFormMap.carOrShipNo }"
							placeholder="请输入 ：车（船）号" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">运单号</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.transportBill"
							value="${deliverGoodsDetailFormMap.transportBill }"
							placeholder="请输入 ：运单号" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">定额运输损耗率</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.transportLossRate"
							value="${deliverGoodsDetailFormMap.transportLossRate }"
							placeholder="请输入 ：定额运输损耗率" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">定额损耗量</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.transportLossNumber"
							value="${deliverGoodsDetailFormMap.transportLossNumber }"
							placeholder="请输入 ：定额损耗量" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-4 div_label">承运方经办人</div>
				<div class="col-md-8">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="deliverGoodsDetailFormMap.transportPerson"
							value="${deliverGoodsDetailFormMap.transportPerson }"
							placeholder="请输入 ：运输方经办人" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-2 div_label">备注</div>
				<div class="col-md-10">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							name="deliverGoodsDetailFormMap.remark" placeholder="请输入 ：备注"
							maxlength="128">${deliverGoodsDetailFormMap.remark }</textarea>
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
			elem : '#deliverGoodsDate',
			event : 'focus'
		});
		laydate({
			elem : '#takeDeliveryDate',
			event : 'focus',
			format : 'YYYY-MM-DD'
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
		function find_data() {
			var bId = $("#getoutBill").val();
			if (bId.length == 12) {
				find_reportHarbor(bId);
			} else {
				clear();
			}
		}
		function find_reportHarbor(bId) {
			$
					.ajax({
						type : 'post',
						dataType : 'json',
						data : {
							bId : bId
						},
						url : rootPath + '/reportHarbor/findDetailByBill.shtml',
						success : function(data) {
							if (data != null) {
								var inOrOut = data.inOrOut;
								if (inOrOut == '1') { //出库
									var totalWeight = data.totalWeight;
									if (totalWeight != null) {//有称重信息
										$("#agreementName").val(data.userName);
										$("#takeDeliveryName").val(
												data.userName);
										$("#grainVariety").val(
												data.grainVariety);
										$("#warehouseName").val(data.wName);
										$("#carOrShipNo").val(data.shipId);
										$("#deliverGoodsNumberLower").val(
												data.totalWeight / 1000);
										$("#deliverGoodsName").val(data.companyName);
										var obj = document
												.getElementById("deliverGoodsNumberLower");
										$("#deliverGoodsNumberUpper").val(
												chengeFloatToUpper(obj));
									} else {
										layer.msg("未进行称重或称重未完成！", {
											icon : 5
										});
										clear();
									}
								} else {
									layer.msg("此单据号为入库单据号！", {
										icon : 5
									});
									clear();
								}
							} else {
								layer.msg("获取信息失败！", {
									icon : 5
								});
								clear();
							}
						},
						error : function(data) {
							layer.alert("获取信息失败！", {
								icon : 5
							});
							clear();
						}
					});
		}

		function clear() {
			$("#agreementName").val("");
			$("#takeDeliveryName").val("");
			$("#grainVariety").val("");
			$("#warehouseName").val("");
			$("#deliverGoodsNumberLower").val("");
			$("#deliverGoodsName").val("");
		}
		function upperNumber(obj, type) {
			if (type == '1') {
				$("#deliverGoodsNumberUpper").val(chengeFloatToUpper(obj));
			} else if (type == '2') {
				$("#takeDeliveryNumberUpper").val(chengeFloatToUpper(obj));
			}

		}
	</script>
</body>
</html>
