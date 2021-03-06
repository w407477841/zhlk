<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<c:set var="ctx" value="${pageContext.request.contextPath }"></c:set>
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
	<div class="col-md-12">
		<!-- 点击图片显示大图 -->
		<img id="showImg" alt="" src="" width="600px" height="400px">
	</div>
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">基础信息</h3>
		</div>
	</div>
	<div class=" col-md-12">
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">单据号</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control" id="bill"
						value="${reportHarborFormMap.bId }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">身份证</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.IDCard }" readonly="readonly">
				</div>
			</div>
		</div>

		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">姓名</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.userName }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">联系电话</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.phoneNumber }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">联系地址</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.address }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">车船号</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.shipId }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">粮库地点</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.wlName }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">仓号</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.wName }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">粮食品种</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.grainVariety }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">粮食性质</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.grainProperty }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">报港员</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.checker }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">报港日期</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.addDate }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">总毛重</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.grossWeight }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">总皮重</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.tare }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">净重</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.totalWeight }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">结算重量</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.trueWeight }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">单价(50kg)</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.buyPrice }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">结算金额</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.sumMoney }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">司磅员</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.weightAuthor }" readonly="readonly">
				</div>
			</div>
		</div>
		<div class="form-group col-md-4">
			<div class="col-md-3 div_label">称重结束日期</div>
			<div class="col-md-9">
				<div class="has-warning">
					<input type="text" class="form-control"
						value="${reportHarborFormMap.weightEndDate }" readonly="readonly">
				</div>
			</div>
		</div>


	</div>
	<div class="col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">称重信息</h3>
		</div>
	</div>
	<div class="col-md-12">
		<div class="form-group col-md-12">
			<table id="magazineGrid" style="width:95%;height:300px;">
			</table>
		</div>
	</div>
	<div class="col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">结算信息</h3>
		</div>
	</div>
	<form id="form" name="form" method="post"
		action="${ctx}/reportHarbor/settleAccount.shtml">
		<input type="hidden" name="token" value="${token }"> <input
			type="hidden" name="reportHarborFormMap.version"
			value="${reportHarborFormMap.version }"> <input type="hidden"
			name="reportHarborFormMap.id" value="${reportHarborFormMap.id }">
		<div class="col-md-12">
			<div class="form-group col-md-4">
				<div class="col-md-3 div_label">结算方式</div>
				<div class="col-md-9">
					<div class="has-warning">
						<select class="form-control" id="payType" data-rel="chosen"
							name="reportHarborFormMap.payType" onchange="change_pay_type()">
							<option value="现金">现金</option>
							<option value="转账">转账</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-4">
				<div class="col-md-3 div_label">银行</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="bankName"
							name="reportHarborFormMap.bankName" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-4">
				<div class="col-md-3 div_label">银行卡</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control" id="bankId"
							name="reportHarborFormMap.bankId" disabled="disabled">
					</div>
				</div>
			</div>
			<div class="form-group col-md-4">
				<div class="col-md-3 div_label">计划编号</div>
				<div class="col-md-9">
					<div class="has-warning">
						<select class="form-control" id="payPlanId" data-rel="chosen"
							name="reportHarborFormMap.payPlanId" data-placeholder="请选择资金计划编号"
							${reportHarborFormMap.inOrOut == '1'?'disabled="disabled"':'' }>
						</select>
					</div>
				</div>
			</div>
		</div>

		<div class="form-group col-md-12">
			<button type="button" class="btn btn-info bt-submit"
				onclick="_submit()">提交</button>
			<button type="button" class="btn btn-warning" onclick="printBill()">打印凭证</button>
		</div>
	</form>

	<script type="text/javascript"
		src="${ctx}/js/system/weight/settleAccount/weighinglist.js"></script>
	<script type="text/javascript" src="${ctx}/js/LodopFuncs.js">
	</script>
	<script type="text/javascript"
		src="${ctx }/js/system/weight/print/print.js"></script>
	<script type="text/javascript">
		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.confirm('结算完成，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('结算失败！', {
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
		$("#showImg").hide();

		var planId;
		var wId = "${reportHarborFormMap.wId}";
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : rootPath + '/reportHarbor/payPlanId.shtml',
			data : {
				wId : wId
			},
			async : false,
			success : function(data) {
				if (data != null && data != "") {
					planId = data;
				}
			},
			error : function(data) {

			}
		});
		var sel = new myselect({
			obj_id : "payPlanId",
			url : "${ctx}/zijinjihua/findAllZiJinJiHua.shtml",
			option_val : [ "bpBill" ],
			option_val_prefix : ",",
			option_html : [ "bpBill" ],
			option_html_prefix : ",",
			selected_val : planId == undefined ? "" : planId
		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});

		function change_pay_type() {
			var type = $("#payType").val();
			if (type == '转账') {
				$("#bankName").removeAttr("disabled");
				$("#bankId").removeAttr("disabled");

			} else {
				$("#bankName").attr("disabled", "disabled");
				$("#bankId").attr("disabled", "disabled");
			}
		}

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}

		function printBill() {
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : rootPath + '/reportHarbor/findDetailByBill.shtml',
				data : {
					bId : $("#bill").val()
				},
				success : function(data) {
					if (data != null) {
						myPrint(data);
					} else {
						layer.alert("打印异常！", {
							icon : 7
						});
					}
				},
				error : function(data) {
					layer.alert("打印异常！", {
						icon : 7
					});
				}
			});
		}
	</script>
</body>
</html>
