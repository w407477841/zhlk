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
	<div id="errorDiv" class="col-md-12"></div>
	<div class=" col-md-6">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">入库方案</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/rukufangan/add.shtml">
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
							name="ruKuFangAnFormMap.pspWId" data-rel="chosen"
							data-placeholder="请选择仓号">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮食性质<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" id="selectcategoryText"
							class="form-control easyui-validatebox" missingMessage="请选择仓号"
							data-options="required:true" readonly="readonly"> <input
							type="hidden" id="selectcategory"
							name="ruKuFangAnFormMap.pspCategory">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮食品种<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" id="selectvarietyText"
							class="form-control easyui-validatebox" missingMessage="请选择仓号"
							data-options="required:true" readonly="readonly"> <input
							type="hidden" id="selectvariety"
							name="ruKuFangAnFormMap.pspVariety">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">文件名称</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="ruKuFangAnFormMap.pspFileName" placeholder="请输入 ：文件名称"
							maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					重量(kg)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" id="currentWeight" class="form-control easyui-validatebox"
							missingMessage="请输入重量" data-options="required:true"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							   onblur="validInt(this)" name="ruKuFangAnFormMap.pspWeight"
							placeholder="请输入 ：重量(kg)" maxlength="11">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					开始日期<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请选择开始日期" data-options="required:true"
							id="dateformat" placeholder="请输入 ：开始日期"
							name="ruKuFangAnFormMap.pspBeginDate">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					结束期日<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请选择结束日期" data-options="required:true"
							id="dateformat1" placeholder="请输入 ：结束期日"
							name="ruKuFangAnFormMap.pspEndDate">
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">内容</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="10" class="form-control"
							name="ruKuFangAnFormMap.pspContent" placeholder="请输入 ：内容"
							maxlength="512"></textarea>
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
		laydate({
			elem : '#dateformat1',
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
			clear_content();
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
				clear_content();
				findVarietyAndProperty();
			}, function() {
				//初始化执行方法
			});
		}
		function findVarietyAndProperty(){
			var wId = $("#warehouseName").val();
			$.ajax({
				type:'post',
				dataType:'json',
				data:{id:wId},
				url:'${ctx}/kcxx/findVAndPByWId.shtml',
				success:function(data){
					$("#currentWeight").val(data.cangKu);
					$("#selectvariety").val(data.name);
					$("#selectvarietyText").val(data.variety);
					$("#selectcategory").val(data.quanZhong);
					$("#selectcategoryText").val(data.property);
				},
				error:function(data){
					
				}
			});
		}
		function clear_content(){
			$("#currentWeight").val("");
			$("#selectvariety").val("");
			$("#selectvarietyText").val("");
			$("#selectcategory").val("");
			$("#selectcategoryText").val("");
		}
		
		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
