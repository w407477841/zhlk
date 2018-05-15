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
			<h3 class="animated rubberBand">预约缴粮</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/yuyuejiaoliang/edit.shtml">
			<input type="hidden" name="yuYueJiaoLiangFormMap.id"
				value="${yuYueJiaoLiangFormMap.id }"> <input type="hidden"
				name="yuYueJiaoLiangFormMap.version"
				value="${yuYueJiaoLiangFormMap.version }"> <input
				type="hidden" name="token" value="${token}">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					姓名<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yuYueJiaoLiangFormMap.agName"
							value="${yuYueJiaoLiangFormMap.agName }" placeholder="请输入 ：姓名"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">身份证号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							validType="idCard" invalidMessage="请输入正确的身份证号"
							name="yuYueJiaoLiangFormMap.agIDCard"
							value="${yuYueJiaoLiangFormMap.agIDCard }"
							placeholder="请输入 ：身份证号" maxlength="18">
					</div>
				</div>
			</div>
			
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					品种<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select class="form-control" id="selectcategory"
							name="yuYueJiaoLiangFormMap.agVariety" data-rel="chosen"
							data-placeholder="请选择品种">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					数量(kg)<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
								onblur="validInt(this)" name="yuYueJiaoLiangFormMap.agNumber"
							value="${yuYueJiaoLiangFormMap.agNumber }" placeholder="请输入 ：数量(kg)"
							maxlength="11">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">
					预约时间<span>*</span>
				</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control" id="dateformat"
							name="yuYueJiaoLiangFormMap.agAppointmentDate"
							value="${yuYueJiaoLiangFormMap.agAppointmentDate }"
							placeholder="请输入 ：预约时间">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">地址</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="yuYueJiaoLiangFormMap.agAddress"
							value="${yuYueJiaoLiangFormMap.agAddress }" placeholder="请输入 ：地址"
							maxlength="128">
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
			<div class="form-group col-md-12">
			<div class="col-md-2 div_label"></div>
			</div>
			<div class="form-group col-md-12">
			<div class="col-md-2 div_label"></div>
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
							if (data == "success") {
								layer.confirm('修改成功，是否关闭?', function(index) {
									layer.close(index);
									parent.layer.close(parent.pageii);
								});
							}
						} else {
							layer.alert('修改失败！', 3);
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

		//粮食品种
		var selec = new myselect({
			obj_id : "selectcategory",
			url : "${ctx}//variety/findEnableVariety.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "text" ],
			option_html_prefix : ",",
			selected_val : ${yuYueJiaoLiangFormMap.agVariety}
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
