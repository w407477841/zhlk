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
			<h3 class="animated rubberBand">修改传感器</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/sensorManager/edit.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" id="id" name="ChuanGanQiFormMap.id"
				value="${ChuanGanQiFormMap.id}">
			<div class="form-group col-md-6">
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						传感器名称<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入传感器名称" data-options="required:true" id="name"
								name="ChuanGanQiFormMap.name" value="${ChuanGanQiFormMap.sensorName}"
								placeholder="请输入 ：传感器名称">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						粮库地点<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
								data-placeholder="请选择粮库地点">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						仓号<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectHouse" data-rel="chosen"
								data-placeholder="请选择仓号" name="ChuanGanQiFormMap.houseID">
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						IP地址<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入ip" data-options="required:true" id="ipNum"
								name="ChuanGanQiFormMap.ip" value="${ChuanGanQiFormMap.cIp }"
								placeholder="请输入 ：ip">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						端口号<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入端口号" data-options="required:true" id="sLeft"
								name="ChuanGanQiFormMap.port" value="${ChuanGanQiFormMap.cPort }"
								placeholder="请输入 ：端口号">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						类型<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectLX" data-rel="chosen" data-placeholder="类型"
								name="ChuanGanQiFormMap.lx">
								<option value=""></option>
								<option value="o2"
									<c:if test="${ChuanGanQiFormMap.lx=='o2'}">selected="selected"</c:if>>氧气</option>
								<option value="co2"
									<c:if test="${ChuanGanQiFormMap.lx=='co2'}"> selected="selected" </c:if>>二氧化碳</option>
								<option value="h3p"
									<c:if test="${ChuanGanQiFormMap.lx=='h3p'}"> selected="selected" </c:if>>硫化氢</option>
								<option value="h3pW"
									<c:if test="${ChuanGanQiFormMap.lx=='h3pW'}"> selected="selected" </c:if>>仓外硫化氢</option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						指令<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入指令" data-options="required:true" id="zl"
								name="ChuanGanQiFormMap.zl" value="${ChuanGanQiFormMap.zl }"
								placeholder="请输入 ：指令">
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
		toSelLocation();
		function toSelLocation() {
			var url = "${ctx}/warehouse/findMap.shtml";
			var warehousecondition = CommnUtil.ajax(url, null, 'json');
			if (warehousecondition != null) {
				var sel = $("#selectLocation");
				sel.css("width", sel.parent().parent().css("width"));
				sel.empty().change(function() {
					$("#selectHouse").html("");
					$("#selectHouse").chosen("destroy");

					toSel($(this).val());
					$("#selectHouse").chosen({
						no_results_text : "未找到此选项!",
						width : "100%"
					});
				});
				var opt = $("<option>").val('').html("").appendTo(sel);
				for (var i = 0; i < warehousecondition.length; i++) {
					var opt = $("<option>").val(warehousecondition[i].wNo)
							.html(warehousecondition[i].wName);
					if ('${param.locationID}' == warehousecondition[i].wNo) {
						opt.attr("selected", "true");

					}
					opt.appendTo(sel);
				}

			}

		}

		$.ajax({
			url : rootPath + "/sensorManager/queryHouse.shtml",
			type : "post",
			async : false,
			cache : false,
			dataType : "json",
			data : {
				"location" : '${param.locationID}'
			},
			success : function(rs) {
				var sel = document.forms[0]["ChuanGanQiFormMap.houseID"];
				sel.style.width = document.getElementById("name").style.width;
				if (rs.success) {
					sel.add(new Option("", ""));
					for (var i = 0; i < rs.rs.length; i++) {
						var option = new Option(rs.rs[i].name, rs.rs[i].id);
						if (rs.rs[i].id == ${ChuanGanQiFormMap.houseID}) {
							option.selected = true;
						}
						sel.add(option)
					}
				}

			}
		})

		function toSel(houseid) {
			$
					.ajax({
						url : rootPath + "/sensorManager/queryHouse.shtml",
						type : "post",
						async : false,
						cache : false,
						dataType : "json",
						data : {
							"location" : houseid
						},
						success : function(rs) {
							var sel = document.forms[0]["ChuanGanQiFormMap.houseID"];
							sel.length = 0;
							sel.style.width = document.getElementById("name").style.width;
							if (rs.success) {
								sel.add(new Option("", ""));
								for (var i = 0; i < rs.rs.length; i++) {
									sel.add(new Option(rs.rs[i].name,
											rs.rs[i].id))
								}
							}

						}
					})
		}

		$("#selectLocation").css("width",
				$("#selectLocation").parent().parent().css("width"));

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
