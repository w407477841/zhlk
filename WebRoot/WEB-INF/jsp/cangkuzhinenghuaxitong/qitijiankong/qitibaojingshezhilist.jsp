<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<style>
.no_padding {
	padding-left: 0px;
	padding-right: 0px;
}
.chosen-container-single .chosen-single {
	height: 38px;
}
</style>
<!-- content starts -->
<div class="row">
	<div class="box col-md-12"
		style="padding-left: 0px; padding-right: 0px;">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list"></i> <span id="pageTitle"></span>
				</h2>
			</div>
			<div class="box-content" id="page">
				<div class="alert alert-info">
					<div class="row">
						<div class=" col-md-12 no_padding">
							<form id="form" name="form"
								action="${pageContext.servletContext.contextPath}/sensorManager/updqiti.shtml">
								<div class="form-group col-md-3 no_padding">
									<div class="col-md-6 div_label">硫化氢(PPM)</div>
									<div class="col-md-6">
										<input name="lhq" class="form-control" value="${lhq}"
											id="lhq">
									</div>
								</div>
								<div class="form-group col-md-3 no_padding">
									<div class="col-md-6 div_label">氧气(%)</div>
									<div class="col-md-6">
										<input name="yq" class="form-control" value="${yq}"
											id="yq">
									</div>
								</div>
								<div class="form-group col-md-3 no_padding">
									<div class="col-md-6 div_label">二氧化碳(%)</div>
									<div class="col-md-6">
										<input name="eyht" class="form-control" value="${eyht}"
											id="eyht">
									</div>
								</div>
								<div class="form-group col-md-3 no_padding">
									<button type="button" class="btn btn-info bt-submit"
										onclick="_submit()">修改</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="box-content" id="page">
				<div class="alert alert-info">
					<div class="row">
						<div class=" col-md-12 no_padding">
							<form id="form1" name="form1"
								action="${pageContext.servletContext.contextPath}/sensorManager/updateExec.shtml">
								<div class="form-group col-md-6 no_padding">
									<div class="col-md-3 div_label">执行间隔</div>
									<div class="col-md-9">
									<input name="execSpace" class="form-control" value="${execSpace}" id="execSpace">
									</div>
								</div>
								<div class="form-group col-md-3 no_padding">
									<div class="col-md-6 div_label"></div>
									<div class="col-md-6">
										
									</div>
								</div>
								<div class="form-group col-md-3 no_padding">
									<button type="button" class="btn btn-info bt-submit"
										onclick="submit_()">修改</button>
								</div>
							</form>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->

<script type="text/javascript"
	src="js/system/cangkuzhinenghuaxitong/qitijiankong/qitibaojingshezhilist.js"></script>
<script type="text/javascript" src="js/additional-methods.js"></script>
<script type="text/javascript">
	$('[data-rel="chosen"],[rel="chosen"]').chosen();

	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	(function() {
		$("#form").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.alert('修改成功！', 3);
						} else {
							layer.alert('修改失败！', 3);
						}
					}
				});
			}
		});
	})();
	(function() {
		$("#form1").validate({
			submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
				ly.ajaxSubmit(form, {//验证新增是否成功
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.alert('修改成功！', 3);
						} else {
							layer.alert('修改失败！', 3);
						}
					}
				});
			}
		});
	})();

	function _submit() {
		$("#form").submit();
	}
	function submit_() {
		$("#form1").submit();
	}
</script>
