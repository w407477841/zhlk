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
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">药剂库存</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/yaojikucunguanli/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							name="yaoJiKuCunFormMap.mrWLNo" data-rel="chosen"
							data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					药剂类型<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="drug"
							name="yaoJiKuCunFormMap.mrDrug" data-rel="chosen"
							data-placeholder="请选择药剂类型">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					药剂名称<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入药剂名称" data-options="required:true"
							name="yaoJiKuCunFormMap.mrName" placeholder="请输入 ：药剂名称"
							maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂品牌</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrBrand" placeholder="请输入 ：药剂品牌"
							maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">单位<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="page"
							name="yaoJiKuCunFormMap.mrPage" data-rel="chosen"
							data-placeholder="请选择单位">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂规格</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrStandard"
							placeholder="请输入 ：药剂规格(例:30ml/瓶)" maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂单价(元)</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" data-options="required:true"
							onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
							onblur="validFloat(this)" name="yaoJiKuCunFormMap.mrPrice"
							placeholder="请输入 ：药剂单价(元)" maxlength="9">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					药剂数量<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入药剂数量" data-options="required:true"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" name="yaoJiKuCunFormMap.mrNumber"
							placeholder="请输入 ：药剂数量" maxlength="6">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">药剂包装</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrUnit" placeholder="请输入 ：药剂包装"
							maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">生产日期<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入生产日期" data-options="required:true" id="dateformat"
							placeholder="请输入 ：生产日期"
							name="yaoJiKuCunFormMap.mrManufactureDate">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">生产厂家</div>
				<div class="col-md-11">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrProductCompany" placeholder="请输入 ：生产厂家"
							maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">经办人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrOperator" placeholder="请输入 ：经办人"
							maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">批核人</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yaoJiKuCunFormMap.mrAuditor" placeholder="请输入 ：批核人"
							maxlength="64">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">备注</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							name="yaoJiKuCunFormMap.mrRemark" placeholder="请输入 ：备注"
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
		}, function() {
			//初始化执行方法
		});
		$("#warehouseName").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});

		//药剂编码
		var sele = new myselect({
			obj_id : "drug",
			url : "${ctx}/code/findCodeItemTreeGrid.shtml",
			data : {
				"codeItemFormMap.codeid" : 16
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
		//药剂包装
		var sele = new myselect({
			obj_id : "page",
			url : "${ctx}/code/findCodeItemTreeGrid.shtml",
			data : {
				"codeItemFormMap.codeid" : 22
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
		$("#selectvariety").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
