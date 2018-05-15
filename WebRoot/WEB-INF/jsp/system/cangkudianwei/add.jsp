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
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">仓库点位添加</h3>
		</div>
	</div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/cangkudianwei/add.shtml">
			<input type="hidden" name="token" value="${token}">
			<div class="form-group col-md-6">
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						点位名称<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入点位名称" data-options="required:true" id="name"
								name="cangKuDianWeiFormMap.name" value=""
								placeholder="请输入 ：点位名称">
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
								data-placeholder="请选择粮库地点"
								name="cangKuDianWeiFormMap.location_id">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						点位类型<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectLx" data-rel="chosen" data-placeholder="点位类型"
								name="cangKuDianWeiFormMap.lx">
								<option value=""></option>
								<option value="1">仓库点位</option>
								<option value="2">仓外传感器点位</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-12" id="ckdiv" style="display: none">
					<div class="col-md-2 div_label">
						仓号<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectCk" data-rel="chosen" data-placeholder="请选择仓号"
								name="cangKuDianWeiFormMap.warehouse_id">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">视频1</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectshipin1" data-rel="chosen"
								data-placeholder="视频1" name="cangKuDianWeiFormMap.shipin1">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">视频2</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectshipin2" data-rel="chosen"
								data-placeholder="视频2" name="cangKuDianWeiFormMap.shipin2">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						横轴位置<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入横轴坐标" data-options="required:true" id="cLeft"
								name="cangKuDianWeiFormMap.cLeft" value=""
								placeholder="请输入 ：横轴位置">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">
						纵轴位置<span>*</span>
					</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control easyui-validatebox"
								missingMessage="请输入纵轴坐标" data-options="required:true" id="cTop"
								name="cangKuDianWeiFormMap.cTop" value=""
								placeholder="请输入 ：纵轴位置">
						</div>
					</div>
				</div>
			</div>

			<div class="form-group col-md-6">
				<div id="img_cangku"></div>
			</div>


			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		(function() {
			var sel = new myselect({
				obj_id : "selectLocation",
				url : "${ctx}/warehouse/findMap.shtml",
				option_val : [ "wNo" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
                getImagePath();
				selChange();

			}, function() {
				//初始化执行方法
			});
			
			
			function getImagePath(){
				$.ajax({
					type:'post',
					dataType:'json',
					data:{id:$("#selectLocation").val()},
					url:'${ctx}/warehouseLocation/imagePath.shtml',
					success:function(data){
						$("#img_cangku").css("background",
								"url(${ctx}/" + data + ")")
								.css("background-size", "100% 100%").css("height",
										"300px");
					}
					
				});
			}
			
			
			
			$("#selectLx").change(function() {

				selChange();
			});

			function selChange() {
				if (validate()) {
					$("#selectCk,#selectshipin1,#selectshipin2").html("");
					$("#selectCk,#selectshipin1,#selectshipin2").chosen(
							"destroy");

					new myselect(
							{
								obj_id : "selectCk",
								url : "${ctx}/warehouse/findWareHouseByLocation2.shtml",
								data : {
									"location_id" : $("#selectLocation").val()
								},
								option_val : [ "id" ],
								option_val_prefix : ",",
								option_html : [ "wName" ],
								option_html_prefix : ","
							}, function() {
								//给change事件添加方法
							}, function() {
								//初始化执行方法
							});

					new myselect({
						obj_id : "selectshipin1",
						url : "${ctx}/shipindianwei/findALlByCid.shtml",
						data : {
							"location_id" : $("#selectLocation").val()
						},
						option_val : [ "id" ],
						option_val_prefix : ",",
						option_html : [ "name" ],
						option_html_prefix : ","

					}, function() {

					}, function() {

					});

					new myselect({
						obj_id : "selectshipin2",
						url : "${ctx}/shipindianwei/findALlByCid.shtml",
						data : {
							"location_id" : $("#selectLocation").val()
						},
						option_val : [ "id" ],
						option_val_prefix : ",",
						option_html : [ "name" ],
						option_html_prefix : ","

					}, function() {

					}, function() {

					});

					$("#selectCk,#selectshipin1,#selectshipin2").chosen({
						no_results_text : "未找到此选项!",
						width : "100%"
					});

				}
			}

			function validate() {
				var lx = $("#selectLx").val() || "-1";
				if (lx == "2" || lx == "-1") {
					$("#ckdiv").hide();
					return false;
				} else {
					$("#ckdiv").show();
				}
				var location = $("#selectLocation").val() || "-1";
				if (lx == "-1" || location == "-1")
					return false;
				return true;
			}

			//$("#selectLocation").css("width",$("#selectLocation").parent().parent().css("width"));
			var shexiangtouImg = null;
			$("#img_cangku")
					.click(
							function(event) {

								imgL = $("#img_cangku").css("width");
								imgL = imgL.substr(0, imgL.length - 2);
								imgH = $("#img_cangku").css("height");
								imgH = imgH.substr(0, imgH.length - 2);
								cL = event.offsetX;
								cH = event.offsetY;
								$("#cLeft").val(
										CommnUtil.roundFun(cL / imgL * 100, 1)
												+ "%");
								$("#cTop").val(
										CommnUtil.roundFun(cH / imgH * 100, 1)
												+ "%");
								if (shexiangtouImg == null) {
									shexiangtouImg = $("<div>")
											.css("width", "20px")
											.css("height", "20px")
											.attr("id", "shexiangtouImg")
											.css("position", "absolute")
											.css(
													"left",
													CommnUtil.roundFun(cL
															/ imgL * 100, 1)
															+ "%")
											.css(
													"top",
													CommnUtil.roundFun(cH
															/ imgH * 100, 1)
															+ "%")
											.css("background",
													"url(${pageContext.servletContext.contextPath}/img/cangku/jk.png)")
											.css("background-size", "100% 100%")
											.css("color", "white").attr(
													"data-id", "shipin" + i)
											.css("cursor", "pointer").appendTo(
													$("#img_cangku"));
								} else {
									shexiangtouImg.css(
											"left",
											CommnUtil.roundFun(cL / imgL * 100,
													1)
													+ "%").css(
											"top",
											CommnUtil.roundFun(cH / imgH * 100,
													1)
													+ "%")
								}
							});

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
				rules : {},
				messages : {},
				errorPlacement : function(error, element) {// 自定义提示错误位置
				},
				success : function(label) {// 验证通过后
				}
			});

		})();

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
