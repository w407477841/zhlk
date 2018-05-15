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

.laydate-icon {
	height: 38px;
	line-height: 38px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div id="errorDiv" class="col-md-12"></div>
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">作业审批</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="editform" name="editform" method="post"
			action="${ctx}/foodStorageManager/editProject.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="FoodStorageProjectFormMap.id"
				value="${FoodStorageProjectFormMap.id}"> <input
				type="hidden" id="status" name="FoodStorageProjectFormMap.status"
				value="${FoodStorageProjectFormMap.status}"> <input
				type="hidden" id="reasons" name="FoodStorageProjectFormMap.reason"
				value=""> <input type="hidden" id="reasons"
				name="FoodStorageProjectFormMap.version"
				value="${FoodStorageProjectFormMap.version}">
			<div class="form-group col-md-12">
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">方案类型</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="selectRs" class="form-control"
								value="${FoodStorageProjectFormMap.type}" readonly="readonly" />
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮食品种</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input class="form-control"
								value="${FoodStorageProjectFormMap.text}" readonly="readonly" />
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮库地点</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input class="form-control"
								value="${FoodStorageProjectFormMap.wlName}" readonly="readonly" />
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓号</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input class="form-control"
								value="${FoodStorageProjectFormMap.wName}" readonly="readonly" />
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">目前数量</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.amount }" readonly="readonly">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">目前粮温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.temperature }"
								readonly="readonly">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.houseTemperature }"
								readonly="readonly">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓廒长</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control "
								value="${FoodStorageProjectFormMap.length }" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓廒宽</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.width }" readonly="readonly">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓廒高</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.height }" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">堆粮线高</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.lineHeight}"
								readonly="readonly">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">气温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.qiwen }" readonly="readonly">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">通风目的</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								value="${FoodStorageProjectFormMap.purpose}" readonly="readonly">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label"></div>
					<div class="col-md-10">
						<div class="has-warning"></div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">方案内容</div>
					<div class="col-md-11">
						<div class="has-warning">
							<textarea class="form-control" rows="4" cols="10"
								readonly="readonly">${FoodStorageProjectFormMap.content}</textarea>
						</div>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit" data-t="1"
					onclick="">审核通过</button>
				<button type="button" class="btn btn-warning bt-submit" data-t="2"
					onclick="">退回</button>
			</div>
		</form>
	</div>
	<div id="back" style="display: none">
		<textarea class="" id="intext"
			style="margin: 5%;width: 90%;height: 70%"></textarea>
	</div>
	<script type="text/javascript">
		/**
		 * 获取类型和性质
		 */
		var CONFIGURE = {
			TYPE : {
				"0" : "通风",
				"1" : "熏蒸",
				"2" : "冷却",
			}
		};
		$("#selectRs").val(
				'${FoodStorageProjectFormMap.wName}'
						+ CONFIGURE.TYPE['${FoodStorageProjectFormMap.type}']
						+ '方案');

		$(".form-control").on("keydown", function() {
			return false;
		});

		$("#form").validate({
			submitHandler : function(form) {
				ly.ajaxSubmit(form, {
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							layer.confirm('审核成功，是否关闭?', function(index) {
								layer.close(index);
								parent.layer.close(parent.pageii);
							});
						} else {
							layer.alert('审核失败！', {
								icon : 5
							});
						}
					}
				});
			},
			rules : {},
			messages : {},
			errorPlacement : function(error, element) {
			},
			success : function(label) {// 验证通过后
				label.parent().attr("class", "has-success");
			}
		});

		$(".bt-submit")
				.on(
						"click",
						function(event) {
							var form = document.forms["editform"];
							switch (~~this.dataset.t) {
							//审核通过
							case 1:
								$("#status").val("1");
								submitForm({
									"FoodStorageProjectFormMap.status" : 1,
									"FoodStorageProjectFormMap.id" : "${FoodStorageProjectFormMap.id}",
									"FoodStorageProjectFormMap.version" : "${FoodStorageProjectFormMap.version}"
								});
								break;

							//退回
							case 2:
								var index = layer
										.open({
											title : "<h5><i class='glyphicon glyphicon-link'></i>退回原因<h5>",
											type : 1,
											maxmin : true,
											offset : '40px',
											area : [ "600px", "300px" ],
											content : $("#back"),
											btn : [ '确认', '取消' ],
											yes : function() {
												$("#status").val("2");
												if ($("#intext").val() == "") {
													layer.msg("退回原因未填写");
													return false;
												}
												submitForm(
														{
															"FoodStorageProjectFormMap.status" : 2,
															"FoodStorageProjectFormMap.version" : "${FoodStorageProjectFormMap.version}",
															"FoodStorageProjectFormMap.id" : "${FoodStorageProjectFormMap.id}",
															"FoodStorageProjectFormMap.reason" : $(
																	"#intext")
																	.val()
														}, index);
											}
										});
								break;
							}
						});

		function submitForm(obj, index) {
			$.ajax({
				url : rootPath + '/foodStorageManager/updateProject.shtml',
				type : "post",
				async : false,
				data : obj,
				dataType : "json",
				success : function(rs) {
					if (rs == "success") {
						layer.msg('提交成功');
						layer.close(index);
						parent.layer.close(parent.pageii);
					} else if (rs == "error") {
						layer.alert('提交失败！', {
							icon : 5
						});
					}
				}
			});
		}
	</script>
</body>
</html>
