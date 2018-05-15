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
	<div class="col-md-6">
		<h3 class="animated rubberBand">计划登记</h3>
	</div>
	<div class="col-md-6"></div>
	<div class="col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/businessManager/addJiakongPlan.shtml">
			<input type="hidden" name="token" value="${token}">
			<div class="form-group col-md-12">

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						粮库地点<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
								data-placeholder="请选择粮库地点">
								<option value=""></option>
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
							<select id="selectCk" data-rel="chosen" data-placeholder="请选择仓号"
								name="BusinessPlanForMapJiakong.wId">
								<option value=""></option>
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
							<input id="varietyName" type="text" readonly="readonly"
								class="form-control"> <input id="varietyId"
								type="hidden" name="BusinessPlanForMapJiakong.breed">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						粮食性质<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="propertyName" type="text" readonly="readonly"
								class="form-control"> <input id="propertyId"
								type="hidden" name="BusinessPlanForMapJiakong.property">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						开始时间<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="beginDate" type="text"
								class="form-control easyui-validatebox" missingMessage="请输入开始时间"
								data-options="required:true"
								name="BusinessPlanForMapJiakong.timestart"
								placeholder="请输入：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						结束时间<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="endDate" type="text"
								class="form-control easyui-validatebox" missingMessage="请输入结束时间"
								data-options="required:true"
								name="BusinessPlanForMapJiakong.timeend" placeholder="请输入：结束时间">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						架空量(kg)<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" id="amount"
								class="form-control easyui-validatebox" missingMessage="请输入架空量"
								data-options="required:true"
								onkeyup="this.value=this.value.replace(/\D/g,'')"
								onblur="validInt(this)" name="BusinessPlanForMapJiakong.amount"
								placeholder="请输入：架空量(kg)" maxlength="11">
						</div>
					</div>
				</div>

			</div>
			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
			<div class="form-group col-md-12" style="height: 100px;"></div>
		</form>
	</div>

	<script type="text/javascript">
		laydate({
			elem : '#beginDate'
		});
		laydate({
			elem : '#endDate',
			event : 'focus'
		});

		new myselect({
			obj_id : "selectLocation",
			url : rootPath + "/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
			$("#selectCk").html("");
			$("#selectCk").chosen("destroy");
			ck();
			$("#selectCk").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法

		});
		$("#selectLocation").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
		function ck() {
			new myselect({
				obj_id : "selectCk",
				url : rootPath + "/warehouse/findWareHouseByLocation2.shtml",
				data : {
					"location_id" : $("#selectLocation").val()
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","
			}, function() {
				//给change事件添加方法
				findVarietyAndProperty($("#selectCk").val());
			}, function() {
				//初始化执行方法
			});
		}
		function findVarietyAndProperty(warehouseId) {
			$.ajax({
				url : rootPath + '/kcxx/findVAndPByWId.shtml',
				type : 'post',
				dataType : 'json',
				data : {
					id : warehouseId
				},
				success : function(data) {
					if (data != null) {
						$("#varietyName").val(data.variety);
						$("#varietyId").val(data.name);
						$("#propertyName").val(data.property);
						$("#propertyId").val(data.quanZhong);
						$("#amount").val(data.cangKu);
					}
				}
			});
		}
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
			rules : {

			},
			messages : {},
			errorPlacement : function(error, element) {

			},
			success : function(label) {// 验证通过后

			}
		});

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
