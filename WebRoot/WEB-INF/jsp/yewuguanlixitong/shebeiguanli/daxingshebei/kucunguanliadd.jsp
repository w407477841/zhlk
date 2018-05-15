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
			<h3 class="animated rubberBand">设备库存</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h4 class="animated rubberBand">设备信息</h4>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/daxingshebeikucun/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class=" col-md-12">
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						粮库地点<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select class="form-control" id="warehouseLocation"
								name="daXingSheBeiFormMap.leWLNo" data-rel="chosen"
								data-placeholder="请选择粮库地点">
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						设备类型<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select class="form-control" id="shebeitype"
								name="daXingSheBeiFormMap.leType" data-rel="chosen"
								data-placeholder="请选择设备类型">
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						单位类型<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select class="form-control" id="shebeiunit"
								name="daXingSheBeiFormMap.leUnit" data-rel="chosen"
								data-placeholder="请选择单位类型">
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						设备编号<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入设备编号" data-options="required:true" id="userName"
								name="daXingSheBeiFormMap.leNo" value="" placeholder="请输入 ：设备编号"
								maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">
						设备名称<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入设备名称" data-options="required:true" id="accountName"
								name="daXingSheBeiFormMap.leName" value=""
								placeholder="请输入 ：设备名称" maxlength="64">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">设备规格</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" id="description"
								name="daXingSheBeiFormMap.leStandard" value=""
								placeholder="请输入 ：设备规格" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">资产价值(元)</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
								onblur="validFloat(this)" name="daXingSheBeiFormMap.leWorth"
								placeholder="请输入 ：资产价值(元)" maxlength="9">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">电机数量(台)</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								onkeyup="this.value=this.value.replace(/\D/g,'')"
								onblur="validInt(this)"
								name="daXingSheBeiFormMap.leMotorsNumber" value=""
								placeholder="请输入 ：电机数量(台)" maxlength="6">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">电机总容量</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
								onblur="validFloat(this)" id="number"
								name="daXingSheBeiFormMap.lePower" value=""
								placeholder="请输入 ：电机总容量(kw)" maxlength="9">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">电话号码</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								validType="telephone" invalidMessage="请输入正确的手机号码"
								name="daXingSheBeiFormMap.leTelephone" value=""
								placeholder="请输入 ：电话号码" maxlength="16">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">邮编</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								onkeyup="this.value=this.value.replace(/\D/g,'')"
								onblur="validInt(this)" name="daXingSheBeiFormMap.leZipCode"
								value="" placeholder="请输入 ：邮编" maxlength="6">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">始用日期<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入始用日期" data-options="required:true" id="dateformat"
								placeholder="请输入 ：始用日期" name="daXingSheBeiFormMap.leUsedDate">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">使用地点</div>
					<div class="col-md-11">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="daXingSheBeiFormMap.leLocation" value=""
								placeholder="请输入 ：使用地点" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">制造单位</div>
					<div class="col-md-11">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="daXingSheBeiFormMap.leManufacturingUnit" value=""
								placeholder="请输入 ：制造单位" maxlength="128">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">制造地址</div>
					<div class="col-md-11">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="daXingSheBeiFormMap.leManufacturingAddress" value=""
								placeholder="请输入 ：制造地址" maxlength="128">
						</div>
					</div>
				</div>

				<input type="hidden" id="fjid" name="daXingSheBeiFormMap.leSon">

			</div>
			<div class=" col-md-12">
				<div class=" col-md-6">
					<h4 class="animated rubberBand">随机附件</h4>
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
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript"
		src="${ctx}/js/system/yewuguanlixiytong/shebeiguanli/daxingshebei/daxingshebeifujianlist.js"></script>
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
		$("#warehouseLocation").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});

		//设备类型
		var sele = new myselect({
			obj_id : "shebeitype",
			url : "${ctx}/code/findCodeItemTreeGrid.shtml",
			data : {
				"codeItemFormMap.codeid" : 24
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
		$("#shebeitype").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
		//单位类型
		var selec = new myselect({
			obj_id : "shebeiunit",
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
		$("#shebeiunit").chosen({
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
	</script>
</body>
</html>
