<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
	<!-- content starts -->
	<div class="row">
		<div class="box col-md-12" style="padding-left: 0px; padding-right: 0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-list"></i> <span id="pageTitle"></span>
					</h2>
					
				</div>
				<div class="box-content" id="page">
					<div class="alert alert-info">
					<div class="row">
						<div class=" col-md-12">
						<form class="form-inline" id="form" name="upd"
							action="${pageContext.servletContext.contextPath}/sensorManager/updLiuhuaqing.shtml">
							硫化氢(PPM)： <input name="lhq" class="form-control" value="${prop.cwlhq}" id="lhq">
							<button type="button" class="btn btn-info bt-submit"
								onclick="_submit()">修改</button>
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
	src="js/system/zhinenganfangxitong/xunzhengqiti/linhuaqingbaojingshezhilist.js"></script>
<script type="text/javascript" src="js/additional-methods.js"></script>
<script type="text/javascript">
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
			},
			rules : {
				"lhq" : "decimal"
			},
			messages : {},
			errorPlacement : function(error, element) {// 自定义提示错误位置
				$("#errorDiv").css('display', 'block');
				// element.css('border','3px solid #FFCCCC');
				$("#errorDiv").html(error.html());
			},
			success : function(label) {// 验证通过后
				label.parent().attr("class", "has-success");
			}
		});
	})();

	function _submit() {
		$("#form").submit();
	}
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>
