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

.laydate-icon {
	height: 38px;
	line-height: 38px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">合同修改</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/businessManager/editAgreement.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="BusinessAgreementFormMap.id"
				value="${BusinessAgreementFormMap.id}">
			<div class="form-group col-md-12">
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">合同编号<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox" missingMessage="请输入合同编号" data-options="required:true"
								name="BusinessAgreementFormMap.agreementID"
								value="${BusinessAgreementFormMap.agreementID }"
								placeholder="请输入：合同编号" maxlength="64">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">&nbsp;</div>
					<div class="col-md-10">
						<div class="has-warning">&nbsp;</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">出售人</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.soldOnes"
								value="${BusinessAgreementFormMap.soldOnes }"
								placeholder="请输入：出售人" maxlength="32">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">买售人</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.buyOnes"
								value="${BusinessAgreementFormMap.buyOnes }"
								placeholder="请输入：买售人" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">签订时间</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.signTime"
								value="${BusinessAgreementFormMap.signTime }" id="start"
								placeholder="请输入：签订时间">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">签订地点</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.signPlace"
								value="${BusinessAgreementFormMap.signPlace }"
								placeholder="请输入：签订地点" maxlength="255">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">履行时间</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.planedActiviteTime"
								value="${BusinessAgreementFormMap.planedActiviteTime }"
								id="start1" placeholder="请输入：履行时间">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">实际履行时间</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.realActiviteTime"
								value="${BusinessAgreementFormMap.realActiviteTime }"
								id="start2" placeholder="请输入：实际履行时间">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">履行结果</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectRs" data-rel="chosen"
								data-placeholder="请选择履行结果"
								name="BusinessAgreementFormMap.results">
								<option value=""></option>
								<c:if test="${BusinessAgreementFormMap.results == 0 }">
									<option value="0" selected="selected">未履行</option>
									<option value="1">履行中</option>
									<option value="2">履行完成</option>
								</c:if>
								<c:if test="${BusinessAgreementFormMap.results == 1 }">
									<option value="0">未履行</option>
									<option value="1" selected="selected">履行中</option>
									<option value="2">履行完成</option>
								</c:if>
								<c:if test="${BusinessAgreementFormMap.results == 2 }">
									<option value="0">未履行</option>
									<option value="1">履行中</option>
									<option value="2" selected="selected">履行完成</option>
								</c:if>

							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">&nbsp;</div>
					<div class="col-md-10">
						<div class="has-warning">&nbsp;</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮库地点</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
								name="BusinessAgreementFormMap.location"
								data-placeholder="请选择粮库地点">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓号</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectCk" data-rel="chosen"
								name="BusinessAgreementFormMap.houseID" data-placeholder="请选择仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮食品种</div>
					<div class="col-md-10">
						<div class="has-warning">
						<input id="varietyName" type="text" readonly="readonly" class="form-control">
						<input id="varietyId" type="hidden" name="BusinessAgreementFormMap.breed">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮食性质</div>
					<div class="col-md-10">
						<div class="has-warning">
						<input id="propertyName" type="text" readonly="readonly" class="form-control">
						<input id="propertyId" type="hidden" name="BusinessAgreementFormMap.property">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">数量(kg)</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" id="amount" class="form-control"
								name="BusinessAgreementFormMap.amounts"
								value="${BusinessAgreementFormMap.amounts}"
								onkeyup="this.value=this.value.replace(/\D/g,'')"
							    onblur="validInt(this)" placeholder="请输入：数量" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">质量等级</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.level"
								value="${BusinessAgreementFormMap.level }"
								placeholder="请输入：质量等级" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">价格(元/kg)</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessAgreementFormMap.price"
								value="${BusinessAgreementFormMap.price }"
								onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
								onblur="validFloat(this)" placeholder="请输入：价格" maxlength="8">
						</div>
					</div>
				</div>




				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">合同模板</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="templates" data-rel="chosen"
								data-placeholder="请选择合同模板"
								name="BusinessAgreementFormMap.templates">
								<option value=""></option>
							</select>
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
			elem : '#start2',
			event : 'focus'
		});
		new myselect({
			obj_id : "selectLocation",
			url : rootPath + "/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ",",
			selected_val : "${BusinessAgreementFormMap.location}"

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
				url : rootPath + "/warehouse/findWareHouseByLocation2.shtml",
				data : {
					"location_id" : $("#selectLocation").val()
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ",",
				selected_val : "${BusinessAgreementFormMap.houseID}"
			}, function() {
				//给change事件添加方法
				findVarietyAndProperty($("#selectCk").val());
			}, function() {
				//初始化执行方法
				initVarietyAndProperty($("#selectCk").val());
			});
		}
		function findVarietyAndProperty(warehouseId){
			$.ajax({
				url:rootPath + '/kcxx/findVAndPByWId.shtml',
				type:'post',
				dataType:'json',
				data:{id:warehouseId},
				success:function(data){
					if(data != null){
						$("#varietyName").val(data.variety);
						$("#varietyId").val(data.name);
						$("#propertyName").val(data.property);
						$("#propertyId").val(data.quanZhong);
						$("#amount").val(data.cangKu);
					}
				}
			});
		}
		function initVarietyAndProperty(warehouseId){
			$.ajax({
				url:rootPath + '/kcxx/findVAndPByWId.shtml',
				type:'post',
				dataType:'json',
				data:{id:warehouseId},
				success:function(data){
					if(data != null){
						$("#varietyName").val(data.variety);
						$("#varietyId").val(data.name);
						$("#propertyName").val(data.property);
						$("#propertyId").val(data.quanZhong);
					}
				}
			});
		}

		new myselect({
			obj_id : "templates",
			url : rootPath + "/businessManager/allAgreementForm.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "fName" ],
			option_html_prefix : ",",
			selected_val : "${BusinessAgreementFormMap.templates}"
		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});
		$("#templates").chosen({
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
							layer.alert('修改失败！', {
								icon : 5
							});
						}
					}
				});
			},
			rules : {},
			messages : {},
			errorPlacement : function(error, element) {

			},
			success : function(label) {// 验证通过后

			}
		});

		function _submit() {
			if($("#form").form("validate")){
				$("#form").submit();     
		     }
		}
	</script>
</body>
</html>
