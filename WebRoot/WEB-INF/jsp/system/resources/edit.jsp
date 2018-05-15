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
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">菜单修改</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/resources/editOne.shtml">
			<!-- 修改，别忘了带上主键 -->
			<input type="hidden" name="resFormMap.id" value="${resFormMap.id}">
			<input type="hidden" name="token" value="${token}">
			
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">菜单名称<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入菜单名称 " data-options="required:true" id="name"
							name="resFormMap.name" value="${resFormMap.name }" placeholder="请输入 ：菜单名称 ">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">菜单url<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入菜单url" data-options="required:true" id="resUrl"
							name="resFormMap.resUrl" value="${resFormMap.resUrl }" placeholder="请输入 ：菜单url 必填">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">菜单key<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox" missingMessage="请输入菜单Key" data-options="required:true" id="level"
							name="resFormMap.resKey" value="${resFormMap.resKey }" placeholder="请输入 ：菜单Key 必填 ">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">菜单排序</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="level"
							name="resFormMap.level" value="${resFormMap.level }" placeholder="请输入 ：排序顺序 ">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">菜单描述</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="level"
							name="resFormMap.description" value="${resFormMap.description }" placeholder="请输入 ：菜单描述 ">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">父级菜单</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="selectError" data-rel="chosen"
							name="resFormMap.parentId">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">菜单图标</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="resFormMap.icon" value="${resFormMap.icon }" placeholder="请输入 ：菜单图标 ">
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">修改</button>
			</div>
		</form>
	</div>


	<script type="text/javascript">
		var pid = "${resFormMap.parentId}";
		var url = "${ctx}/resources/findAllParent.shtml";
		var resList = CommnUtil.ajax(url, null, 'json');
		if (resList != null) {
			var sel = $("#selectError");
			sel.css("width", sel.parent().parent().css("width"));
			sel.empty();
			var opt = $("<option>").val(0).html("顶级菜单");
			if (pid == 0) {
				opt.attr('selected', true);
			}
			opt.appendTo(sel);
			for (var i = 0; i < resList.length; i++) {
				opt = $("<option>").val(resList[i].id).html(resList[i].name);
				if (pid == resList[i].id) {
					opt.attr('selected', true);
				}
				opt.appendTo(sel);
			}

		}

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
