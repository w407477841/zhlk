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
			<h3 class="animated rubberBand">政策查询</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/zhengcechaxun/add.shtml">
			<input type="hidden" name="token" value="${token}">
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">
					文章类型<span>*</span>
				</div>
				<div class="col-md-11">
					<div class="has-warning">
						<select class="form-control" id="xinxiType"
							name="zhengCeChaXunFormMap.pqType" data-rel="chosen"
							data-placeholder="请选择文章类型">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">
					文章标题<span>*</span>
				</div>
				<div class="col-md-11">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入文章标题" data-options="required:true"
							name="zhengCeChaXunFormMap.pqTitle" placeholder="请输入 ：文章标题"
							maxlength="128">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">文章内容</div>
				<div class="col-md-11">
					<div class="has-warning">
						<script id="container" name="zhengCeChaXunFormMap.pqContent"
							type="text/plain">
    </script>
					</div>
				</div>
			</div>


			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="${ctx}/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${ctx}/ueditor/ueditor.all.js"></script>
	<!-- 实例化编辑器 -->
	<script type="text/javascript">
		var ue = UE.getEditor('container', {
			initialFrameHeight : 400
		});
	</script>
	<script type="text/javascript">
		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							if (data == "success") {
								layer.confirm('添加成功，是否关闭?', function(index) {
									layer.close(index);
									parent.layer.close(parent.pageii);
								});
							}
						} else {
							layer.alert('添加失败！', 3);
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
			obj_id : "xinxiType",
			url : "${ctx}/zhengcechaxun/findZhengCeType.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "itName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
