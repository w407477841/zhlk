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
			<h3 class="animated rubberBand">库点信息对接</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/warehouseLocationInterface/add.shtml">
			<input type="hidden" name="token" value="${token }">
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					粮库地点<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<select class="form-control" id="warehouseLocation"
							data-rel="chosen"
							name="warehouseLocationInterfaceFormMap.location_no"
							data-placeholder="请选择粮库地点">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					企业名称<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" id="locationname" class="form-control easyui-validatebox"
							missingMessage="请输入企业名称" data-options="required:true"
							name="warehouseLocationInterfaceFormMap.qiyemingcheng"
							placeholder="请输入 ：库点名称" maxlength="50">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					库区编码<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入库区编码" data-options="required:true"
							name="warehouseLocationInterfaceFormMap.kuqubianma"
							placeholder="请输入 ：库区编码" maxlength="3">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-3 div_label">
					统一信用代码<span>*</span>
				</div>
				<div class="col-md-9">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入统一信用代码" data-options="required:true"
							name="warehouseLocationInterfaceFormMap.tongyixinyongdaima"
							placeholder="请输入 ：统一信用代码" maxlength="10" onblur="findDaiMa(this)">

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
		
		function findDaiMa(obj){
			var daima = $(obj).val();
			$.ajax({
				type:'post',
				dataType:'json',
				data:{id:daima},
				url:'${ctx}/warehouseLocationInterface/xinyongdaima.shtml',
				success:function(data){
					if(data != null){
						$("#locationname").val(data.qiyemingcheng);
						$("#locationname").attr("readOnly","readOnly");
					}
				}
			});
		}
		
		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
