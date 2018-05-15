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
			<h3 class="animated rubberBand">供应商档案</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/businessManager/editCompany.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="BusinessGuestCompanyFormMap.id"
				value="${BusinessGuestCompanyFormMap.id}">
			<div class="form-group col-md-12">
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">单位名称<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入单位名称" data-options="required:true"
								name="BusinessGuestCompanyFormMap.name"
								value="${BusinessGuestCompanyFormMap.name }"
								placeholder="请输入：单位名称" maxlength="128">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">通讯地址<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入通讯地址" data-options="required:true"
								name="BusinessGuestCompanyFormMap.address"
								value="${BusinessGuestCompanyFormMap.address }"
								placeholder="请输入：通讯地址" maxlength="128">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">联系人<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入联系人" data-options="required:true"
								name="BusinessGuestCompanyFormMap.concator"
								value="${BusinessGuestCompanyFormMap.concator }"
								placeholder="请输入：联系人" maxlength="32">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">联系电话<span>*</span></div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入联系方式" data-options="required:true"
								validType="telephone" invalidMessage="请输入正确的联系方式"
								value="${BusinessGuestCompanyFormMap.phone }"
								name="BusinessGuestCompanyFormMap.phone" placeholder="请输入：联系电话"
								maxlength="32">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">资讯情况</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessGuestCompanyFormMap.message"
								value="${BusinessGuestCompanyFormMap.message }"
								placeholder="请输入：资讯情况" maxlength="128">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">收购许可证</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessGuestCompanyFormMap.shougoubianhao"
								value="${BusinessGuestCompanyFormMap.shougoubianhao }"
								placeholder="请输入：收购许可证" maxlength="128">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">生产许可证</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessGuestCompanyFormMap.shengchanbianhao"
								value="${BusinessGuestCompanyFormMap.shengchanbianhao }"
								placeholder="请输入：生产许可证" maxlength="128">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">卫生许可证</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessGuestCompanyFormMap.weishengbianhao"
								value="${BusinessGuestCompanyFormMap.weishengbianhao}"
								placeholder="请输入：卫生许可证" maxlength="128">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">营业执照号</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessGuestCompanyFormMap.yingyezhizhao"
								value="${BusinessGuestCompanyFormMap.yingyezhizhao }"
								placeholder="请输入：企业法人营业执照注册号" maxlength="128">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">注册商标</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${BusinessGuestCompanyFormMap.icon }"
								name="BusinessGuestCompanyFormMap.icon" placeholder="请输入：注册商标"
								maxlength="128">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">主要标准</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="BusinessGuestCompanyFormMap.standard"
								value="${BusinessGuestCompanyFormMap.standard }"
								placeholder="请输入：企业(商)品采用的主要标准" maxlength="128">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">&nbsp;</div>
					<div class="col-md-10">
						<div class="has-warning">&nbsp;</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">备注</div>
					<div class="col-md-11">
						<div class="has-warning">
							<textarea class="form-control" rows="4" cols="10"
								name="BusinessGuestCompanyFormMap.comment" placeholder="请输入：备注"
								maxlength="255">${BusinessGuestCompanyFormMap.comment }</textarea>
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
			rules : {

			},
			messages : {},
			errorPlacement : function(error, element) {
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
