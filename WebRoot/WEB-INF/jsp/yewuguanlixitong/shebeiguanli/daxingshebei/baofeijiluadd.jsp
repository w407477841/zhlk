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
			<h3 class="animated rubberBand">设备报废</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/daxingshebeibaofei/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">设备名称<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="equipmentName" data-rel="chosen"
							data-placeholder="请选择设备名称">
						</select>

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">设备编号<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="equipmentNo"
							name="daXingSheBeiBaoFeiFormMap.leId" data-rel="chosen"
							data-placeholder="请选择设备编号">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">报废日期<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入报废日期" data-options="required:true" id="dateformat"
							data-placeholder="请输入 ：报废日期"
							name="daXingSheBeiBaoFeiFormMap.lewDate">
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">报废原由<span>*</span></div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control easyui-validatebox"
							missingMessage="请输入报废原由" data-options="required:true"
							name="daXingSheBeiBaoFeiFormMap.lewCause" placeholder="请输入 ：报废原由"
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

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}

		var sel = new myselect({
			obj_id : "equipmentName",
			url : "${ctx}/daxingshebeikucun/findAllName.shtml",
			option_val : [ "leName" ],
			option_val_prefix : ",",
			option_html : [ "leName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
			$("#equipmentNo").html("");
			$("#equipmentNo").chosen("destroy");
			findNoByName($("#equipmentName").val());
			$("#equipmentNo").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法
		});

		function findNoByName(lename) {
			new myselect({
				obj_id : "equipmentNo",
				url : "${ctx}/daxingshebeikucun/findIdByName.shtml",
				data : {
					"leName" : lename
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "leNo" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
			}, function() {
				//初始化执行方法
			});
		}
	</script>
</body>
</html>
