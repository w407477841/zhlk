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
			<h3 class="animated rubberBand">粮库基础信息</h3>
		</div>
	</div>
	<div class=" col-md-6"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/liangkujichu/edit.shtml">
			<input type="hidden" name="liangKuJiChuFormMap.id"
				value="${liangKuJiChuFormMap.id }"> <input type="hidden"
				name="liangKuJiChuFormMap.version"
				value="${liangKuJiChuFormMap.version }"> <input
				type="hidden" name="token" value="${token }">
				<input
				type="hidden" name="liangKuJiChuFormMap.wlaNo" value="${liangKuJiChuFormMap.wlaNo }">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">库点地点<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							value="${liangKuJiChuFormMap.wName }"
							readonly="readonly">
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">负责人<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入负责人" data-options="required:true"
							name="liangKuJiChuFormMap.wlaGovernor"
							value="${liangKuJiChuFormMap.wlaGovernor }"
							placeholder="请输入 ：负责人" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">电话</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							validType="telephone" invalidMessage="请输入正确的办公电话"
							name="liangKuJiChuFormMap.wlaPhoneNumber"
							value="${liangKuJiChuFormMap.wlaPhoneNumber }"
							placeholder="请输入 ：电话" maxlength="16">

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">传真</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="liangKuJiChuFormMap.wlaFaxNumber"
							value="${liangKuJiChuFormMap.wlaFaxNumber }"
							placeholder="请输入 ：传真" maxlength="16">

					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">库点容量(吨)<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入库点容量"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" data-options="required:true"
							name="liangKuJiChuFormMap.wlaCapacity"
							value="${liangKuJiChuFormMap.wlaCapacity }"
							placeholder="请输入 ：库点容量(吨)" maxlength="10">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">占地面积<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入占地面积" data-options="required:true"
							name="liangKuJiChuFormMap.wlaFloorSpace"
							value="${liangKuJiChuFormMap.wlaFloorSpace }"
							placeholder="请输入 ：占地面积" maxlength="16">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">雇佣人数<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入雇佣人数"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)" data-options="required:true"
							onkeyup="this.value=this.value.replace(/\D/g,'')"
							onblur="validInt(this)"
							name="liangKuJiChuFormMap.wlaPersonNumber"
							value="${liangKuJiChuFormMap.wlaPersonNumber }"
							placeholder="请输入 ：雇佣人数" maxlength="9">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">省份<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入省份" data-options="required:true"
							name="liangKuJiChuFormMap.wlaPrivince"
							value="${liangKuJiChuFormMap.wlaPrivince }" placeholder="请输入 ：省份"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">城市<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入城市" data-options="required:true"
							name="liangKuJiChuFormMap.wlaCity"
							value="${liangKuJiChuFormMap.wlaCity }" placeholder="请输入 ：城市"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">县区<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入县区" data-options="required:true"
							name="liangKuJiChuFormMap.wlaCounty"
							value="${liangKuJiChuFormMap.wlaCounty }" placeholder="请输入 ：县区"
							maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库地点<span>*</span></div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control easyui-validatebox"
							missingMessage="请输入粮库地点" data-options="required:true"
							name="liangKuJiChuFormMap.wlaAddress"
							value="${liangKuJiChuFormMap.wlaAddress }"
							placeholder="请输入 ：粮库地点" maxlength="256">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">组织机构号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="liangKuJiChuFormMap.wlaOrganization"
							value="${liangKuJiChuFormMap.wlaOrganization }"
							placeholder="请输入 ：组织机构号" maxlength="32">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">行政区号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<input type="text" class="form-control"
							name="liangKuJiChuFormMap.wlaAdministrativeCode"
							value="${liangKuJiChuFormMap.wlaAdministrativeCode }"
							placeholder="请输入 ：行政区号" maxlength="16">
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
	</script>
</body>
</html>
