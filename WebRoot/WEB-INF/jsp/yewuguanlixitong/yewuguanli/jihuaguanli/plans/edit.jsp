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
			<h3 class="animated rubberBand">计划修改</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post" action="${ctx}/businessManager/editPlan.shtml">
			<input type="hidden" name="token" value="${token}"> 
			<input type="hidden" name="BusinessPlaneFormMap.id" value="${BusinessPlaneFormMap.id}"> 
			<input type="hidden" id="plans" name="BusinessPlaneFormMap.planType" value="${BusinessPlaneFormMap.planType}">
			<input type="hidden" id="plans" name="BusinessPlaneFormMap.completedAmount" value="${BusinessPlaneFormMap.completedAmount}">
				
			<div class="form-group col-md-12">
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">计划编号<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox" missingMessage="请输入计划编号" data-options="required:true"
								name="BusinessPlaneFormMap.planId"
								placeholder="请输入 ：计划编号" maxlength="32" value="${BusinessPlaneFormMap.planId}">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮食品种<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectVariety" data-rel="chosen"
								data-placeholder="请选择粮食品种" name="BusinessPlaneFormMap.breed">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮库地点<span>*</span></div>
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
					<div class="col-md-2 div_label">仓号<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectCk" data-rel="chosen" multiple 
								data-placeholder="请选择仓号" onchange="changeValues()">
								<option value=""></option>
							</select>
							<input type="hidden" name="BusinessPlaneFormMap.wId" value="${BusinessPlaneFormMap.wId}" id="warehouse" >
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">新增(kg)<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox" missingMessage="请输入新增计划" data-options="required:true" id="newadd"
								name="BusinessPlaneFormMap.newPlanedAmount" onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)"
								placeholder="请输入 ：新增计划" maxlength="10" value="${BusinessPlaneFormMap.newPlanedAmount }">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">轮换(kg)<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox" missingMessage="请输入轮换计划" data-options="required:true" id="turn"
								name="BusinessPlaneFormMap.turnPlannedAmount" onkeyup="this.value=this.value.replace(/\D/g,'')"
							    onblur="validInt(this)"
								placeholder="请输入 ：轮换计划" maxlength="10" value="${BusinessPlaneFormMap.turnPlannedAmount}">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">业务类型<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<select data-rel="chosen" data-placeholder="请选择业务类型" name="BusinessPlaneFormMap.type">
								<option value=""></option>
								<c:if test="${BusinessPlaneFormMap.type == '1' }">
								<option value="1" selected="selected">出库</option>
								<option value="2">入库</option>
								</c:if>
								<c:if test="${BusinessPlaneFormMap.type == '2' }">
								<option value="1">出库</option>
								<option value="2" selected="selected">入库</option>
								</c:if>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">收获年度<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
						  <input id="year"  type="text" class="form-control easyui-validatebox" missingMessage="请输入收获年度" data-options="required:true" name="BusinessPlaneFormMap.achieveYear" value="${BusinessPlaneFormMap.achieveYear }" placeholder="请输入 ：收获年度" maxlength="4">
						</div>
					</div>
				</div>
				

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">开始时间<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="start" type="text" class="form-control easyui-validatebox" missingMessage="请输入计划开始" data-options="required:true"
								name="BusinessPlaneFormMap.planedTimeStart" value="${BusinessPlaneFormMap.planedTimeStart }"
								placeholder="请输入 ：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">结束时间<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="start1" type="text" class="form-control easyui-validatebox" missingMessage="请输入计划结束" data-options="required:true"
								name="BusinessPlaneFormMap.planedTimeEnd" value="${BusinessPlaneFormMap.planedTimeEnd }"
								placeholder="请输入 ：结束时间">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">价格(元/kg)<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox" missingMessage="请输入计划价格" data-options="required:true"
								name="BusinessPlaneFormMap.planedPrice" value="${BusinessPlaneFormMap.planedPrice }"
								placeholder="请输入 ：计划价格" maxlength="5">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">入库质量</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessPlaneFormMap.quailty" value="${BusinessPlaneFormMap.quailty }" placeholder="请输入 ：入库质量" maxlength="250"/>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">下达单位</div>
					<div class="col-md-11">
						<div class="has-warning">
							<textarea class="form-control" rows="4" cols="10"
								name="BusinessPlaneFormMap.department" placeholder="请输入 ：下达单位" maxlength="250">${BusinessPlaneFormMap.department }</textarea>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">备注</div>
					<div class="col-md-11">
						<div class="has-warning">
							<textarea class="form-control" rows="4" cols="10"
								name="BusinessPlaneFormMap.comment" placeholder="请输入 ：备注" maxlength="250">${BusinessPlaneFormMap.comment}</textarea>
						</div>
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
		elem : '#start',
		event : 'focus'
	});
	laydate({
		elem : '#start1',
		event : 'focus'
	});
	laydate({
		elem : '#year',
		event : 'focus',
		format:'YYYY'
	});

	new myselect({
		obj_id : "selectLocation",
		url : rootPath + "/warehouse/findMap.shtml",
		option_val : [ "id" ],
		option_val_prefix : ",",
		option_html : [ "wName" ],
		option_html_prefix : ",",
		selected_val:"${BusinessPlaneFormMap.wlId}"
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
		ck();

	});
	$("#selectLocation").chosen({
		no_results_text : "未找到此选项!",
		width : "100%"
	});
	function ck() {
		new myselect({
			obj_id : "selectCk",
			url : rootPath + "/warehouse/findWareHouseByLocationAndVariety.shtml",
			data : {
				"location_id" : $("#selectLocation").val(),
				"name":$("#selectVariety").val()
			},
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ",",
			selected_vals:"${BusinessPlaneFormMap.wId}",
		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});
	}
	new myselect({
		obj_id : "selectVariety",
		url : rootPath + "/variety/findEnableVariety.shtml",
		option_val : [ "id" ],
		option_val_prefix : ",",
		option_html : [ "text" ],
		option_html_prefix : ",",
		selected_val:"${BusinessPlaneFormMap.breed}"
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
		ck();
	});
	$("#selectVariety").chosen({
		no_results_text : "未找到此选项!",
		width : "100%"
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
		rules : {
			
		},
		messages : {
			
		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
			$("#errorDiv").css('display', 'block');
			$("#errorDiv").html(error.html());
			element.parent().attr("class", "has-error");
			//console.log(element);
		},
		success : function(label,a) {// 验证通过后
			console.log(a);
			console.log(label);
			$(a).parent().attr("class", "has-warning");
		}
	});
	function _submit() {
		if($("#form").form("validate")){
			$("#form").submit();     
	     }
	}
	
	function changeValues(){
    	var weights = '';
    	$('#selectCk option').each(function(){
    		if($(this).is(':selected')){
    			weights+=$(this).val()+",";
    		}
    	});
    	$("#warehouse").val(weights);
    }

	</script>
</body>
</html>
