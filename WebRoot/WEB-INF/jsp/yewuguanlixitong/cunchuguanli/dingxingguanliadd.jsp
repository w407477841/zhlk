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
			<h3 class="animated rubberBand">粮库转性</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/dingxingguanli/add.shtml">
			<input type="hidden" name="token" value="${token}">
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">粮库地点</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="selectLocation" data-rel="chosen"
							data-placeholder="请选择粮库地点" style="width:100%">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">仓号</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="selectCk" data-rel="chosen" data-placeholder="请选择仓号"
							name="qualitativeFormMap.warehouse_id" style="width:100%">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">原性质</div>
				<div class="col-md-10">
					<div class="has-warning">

						<input type="text" class="form-control" id="qOldQualitative"
							readonly="readonly"> <input type="hidden"
							class="form-control" id="qOldQualitativeHidden"
							name="qualitativeFormMap.qOldQualitative">
					</div>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-md-2 div_label">转换后性质</div>
				<div class="col-md-10">
					<div class="has-warning">
						<select id="selectNew" data-rel="chosen" data-placeholder="请选择粮食性质"
							name="qualitativeFormMap.qNewQualitative" style="width:100%">
						</select>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<div class="col-md-1 div_label">备注</div>
				<div class="col-md-11">
					<div class="has-warning">
						<textarea rows="4" cols="20" class="form-control"
							name="qualitativeFormMap.qComment" placeholder="请输入 ：备注"></textarea>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="${ctx}/common/common_code.js"></script>
	<script type="text/javascript">
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
			rules : {

			},
			messages : {

			},
			errorPlacement : function(error, element) {// 自定义提示错误位置
			},
			success : function(label) {// 验证通过后
			}
		});
		new myselect({
			obj_id : "selectLocation",
			url : rootPath + "/warehouse/findMap.shtml",
			option_val : [ "wNo" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
			$("#selectCk").html("");
			$("#selectCk").chosen("destroy");
			ck();
			$("#selectCk").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法

		});
		var xingzhiList = CommnUtil.ajax("${ctx}/dingxingguanli/findCk.shtml",
				{}, "json");
		function ck() {
			new myselect({
				obj_id : "selectCk",
				url : rootPath + "/warehouse/findWareHouseByLocation2.shtml",
				data : {
					"location_id" : $("#selectLocation").val()
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","
			}, function() {
				//给change事件添加方法
				var ck = $("#selectCk").val();
				var length = xingzhiList.length;
				for (var i = 0; i < length; i++) {
					console.debug(xingzhiList[i].id);
					if (ck == xingzhiList[i].id) {
						$("#qOldQualitative").val(xingzhiList[i].xingzhi);
						$("#qOldQualitativeHidden").val(
								xingzhiList[i].quanZhong);
						i = length;
					}
				}
			}, function() {
				//初始化执行方法
			});

		}

		(function() {
			new myselect({
				obj_id : "selectNew",
				url : rootPath + "/property/findEnable.shtml",
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "text" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
			}, function() {
				//初始化执行方法

			});

		})();
		function _submit() {
			$("#form").submit();
		}
	</script>
</body>
</html>
