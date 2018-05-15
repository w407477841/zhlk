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
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">出库申请</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<div class=" col-md-12">
			<div class=" col-md-6">
				<h4 class="animated rubberBand">申请信息</h4>
			</div>
		</div>
		<div class=" col-md-6"></div>
		<form id="form" name="form" method="post"
			action="${ctx}/chukushenqing/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class=" col-md-12">
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
								name="chuKuShenQingFormMap.gsaWId" data-rel="chosen"
								data-placeholder="请选择仓号">
							</select>
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">申请单编号<span>*</span></div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入申请单编号" data-options="required:true"
								name="chuKuShenQingFormMap.gsaApplyBill" value=""
								placeholder="请输入 ：申请单编号" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">发货日期</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" id="dateformat"
								placeholder="请输入 ：发货日期"
								name="chuKuShenQingFormMap.gsaSendOutDate">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">买受人(需方)<span>*</span></div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入买受人" data-options="required:true"
								name="chuKuShenQingFormMap.gsaPurchaser"
								placeholder="请输入 ：买受人(需方)" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">合同号<span>*</span></div>
					<div class="col-md-9">
						<div class="has-warning">
							<select class="form-control" id="agreementNo"
								name="chuKuShenQingFormMap.gsaAgreementBill" data-rel="chosen"
								data-placeholder="请选择合同号">
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">货款到账情况</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select class="form-control"
								name="chuKuShenQingFormMap.gsaPaymentSituation"
								data-rel="chosen" data-placeholder="请选择货款到账情况">
								<option value="未到账" selected="selected">未到账</option>
								<option value="已到账">已到账</option>

							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">计划出库数量(kg)<span>*</span></div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入计划出库数量" data-options="required:true"
								onkeyup="this.value=this.value.replace(/\D/g,'')"
							   onblur="validInt(this)"
								name="chuKuShenQingFormMap.gsaPlanOutWeight"
								placeholder="请输入 ：计划出库数量(kg)" maxlength="12">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">当前数量(kg)</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" id="gsaCurrentWeight"
								name="chuKuShenQingFormMap.gsaCurrentWeight"
								readonly="readonly">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">申请人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="chuKuShenQingFormMap.gsaApplyPerson"
								placeholder="请输入 ：申请人" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">部门<span>*</span></div>
					<div class="col-md-9">
						<div class="has-warning">
							<select class="form-control" id="department"
								name="chuKuShenQingFormMap.gsaApplyDepartment" data-rel="chosen"
								data-placeholder="请选择部门">
							</select>
						</div>
					</div>
				</div>

				<input type="hidden" id="fjid"
					name="chuKuShenQingFormMap.gsaTransferTools">

			</div>
			<div class=" col-md-12">
				<div class=" col-md-6">
					<h4 class="animated rubberBand">需方运输工具情况</h4>
				</div>
			</div>
			<div class=" col-md-6"></div>
			<div class="form-group col-md-12">
				<div class="form-group col-md-12">
					<a class="btn-sm btn-info" href="javascript:void(0)" id="addsuFun"
						style="text-shadow: black 5px 3px 3px;"> <i
						class="glyphicon glyphicon-plus icon-white"></i>登记
					</a> &nbsp; <a class="btn-sm btn-danger" href="javascript:void(0)"
						id="delesuFun" style="text-shadow: black 5px 3px 3px;"> <i
						class="glyphicon glyphicon-remove icon-white"></i>删除
					</a>
				</div>
				<table id="sbfjGrid" style="width:95%;height:400px">
				</table>

			</div>

			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">保存</button>
				<button type="button" class="btn btn-info bt-submit"
					onclick="_approve()">提交审批</button>
			</div>
		</form>
	</div>
	<script type="text/javascript"
		src="${ctx}/js/system/yewuguanlixiytong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqingtools.js"></script>
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
				getWeight();
			}, function() {
				//初始化执行方法
			});
		}
		
		function getWeight(){
			var wId = $("#warehouseName").val();
			$.ajax({
				type:'post',
				dataType:'json',
				url:'${ctx}/store/findById.shtml',
				data:{wId:wId},
				success:function(data){
					if(data != null){
						$("#gsaCurrentWeight").val(parseFloat(data.cangKu));
					}else{
						$("#gsaCurrentWeight").val("");
					}
				}
			});
		}
		
		
		//部门
		var sele = new myselect({
			obj_id : "department",
			url : "${ctx}/code/findCodeItemTreeGrid.shtml",
			data : {
				"codeItemFormMap.codeid" : 9
			},
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "text" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});
		$("#department").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
		//合同
		var sel = new myselect({
			obj_id : "agreementNo",
			url : "${ctx}/businessManager/findAllAgreementBill.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "agreementID" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});
		$("#agreementNo").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
		function _submit() {
			var result = "";
			var rows = grid.datagrid('getRows');
			for (var i = 0; i < rows.length; i++) {
				result += rows[i].id;
				result += ",";
			}
			$("#fjid").val(result.substring(0, result.length - 1));

			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
		function _approve() {
			var result = "";
			var rows = grid.datagrid('getRows');
			for (var i = 0; i < rows.length; i++) {
				result += rows[i].id;
				result += ",";
			}
			$("#fjid").val(result.substring(0, result.length - 1));

			if ($("#form").form("validate")) {
				$("#form").attr("action", "${ctx}/chukushenqing/approve.shtml");
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
