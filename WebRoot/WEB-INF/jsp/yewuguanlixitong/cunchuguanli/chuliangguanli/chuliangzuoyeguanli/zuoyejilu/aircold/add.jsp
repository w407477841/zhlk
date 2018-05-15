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
		<form id="form" name="form" method="post"
			action="${ctx}/foodStorageManager/addAirCold.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" id="totalTime"
				name="FoodStorageAirColdFormMap.timeTotal">
			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">

				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">基础信息</h3>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮库地点</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
								name="FoodStorageAirColdFormMap.location"
								data-placeholder="请选择粮库地点">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">仓号</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectCk" data-rel="chosen"
								name="FoodStorageAirColdFormMap.houseid"
								data-placeholder="请选择仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input id="varietyName" type="text" readonly="readonly" class="form-control">
						<input id="varietyId" type="hidden" name="FoodStorageAirColdFormMap.breed">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">数量(kg)</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="currentWeight" class="form-control" readonly="readonly"
								name="FoodStorageAirColdFormMap.amount" placeholder="请输入：数量(公斤)">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">空调型号</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageAirColdFormMap.devicetype"
								placeholder="请输入：空调型号">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">空调数量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageAirColdFormMap.deviceAmount"
								placeholder="请输入：空调数量">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">空间高度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.height"
								placeholder="请输入：空间高度(M)">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮层厚度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.thick" placeholder="请输入：粮层厚度(M)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单空调功率</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.devicePower"
								placeholder="请输入：单台风机功率（Kw）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">空调总功率</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.totlePower"
								placeholder="请输入：空调总功率（Kw）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">开机时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class="form-control"
								name="FoodStorageAirColdFormMap.times" value=""
								placeholder="请输入：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">结束时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text" class="form-control"
								name="FoodStorageAirColdFormMap.timee" value=""
								placeholder="请输入：结束时间">
						</div>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-2">
						<h3 class="animated rubberBand">通风参数</h3>
					</div>
					<div class=" col-md-10">
						<div class="col-md-3 div_label div_lable1">最大值</div>
						<div class="col-md-3 div_label div_lable1">最小值</div>
						<div class="col-md-3 div_label div_lable1">平均值</div>
						<div class="col-md-3 div_label div_lable1">梯度值</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">大气温度（℃）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.temperatureMax"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.temperatureMin"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.temperatureAvg"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>

					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">大气湿度（RH%）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.wetMax" placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.wetMin" placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.wetAvg" placeholder="请输入：平均值">
								</div>
							</div>
						</div>

					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">开机前粮食温度（℃）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperatureMax_b"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperatureMin_b"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperatureAvg_b"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperature_ladderMax_b"
										placeholder="请输入：℃/米粮层厚度或水分%/米粮层厚度">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">开机后粮食温度（℃）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperatureMax_a"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperatureMin_a"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperatureAvg_a"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageAirColdFormMap.ftemperature_ladderMax_a"
										placeholder="请输入：℃/米粮层厚度或水分%/米粮层厚度">
								</div>
							</div>
						</div>

					</div>
				</div>



			</div>
			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总耗电</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.elecAmount"
								placeholder="请输入：总耗电（Kw.h）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单位能耗</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.elecAmountPerHour"
								placeholder="请输入：（Kw.h/℃.吨或Kw.h/1%水分.t）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">负责人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.charge" placeholder="请输入：负责人">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">操作人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageAirColdFormMap.operator" placeholder="请输入：操作人">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">备注</div>
					<div class="col-md-9">
						<div class="has-warning">
							<textarea type="text" class="form-control"
								name="FoodStorageAirColdFormMap.comment" placeholder="请输入：备注"></textarea>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">&nbsp;</div>
					<div class="col-md-9">
						<div class="has-warning" style="height: 58px">&nbsp;</div>
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
		laydate({
			elem : '#start',
			event : 'focus'
		});
		laydate({
			elem : '#start1',
			event : 'focus'
		});

		new myselect({
			obj_id : "selectLocation",
			url : rootPath + "/warehouse/findMap.shtml",
			option_val : [ "id" ],
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
			clear_content;
		}, function() {
			//初始化执行方法

		});
		$("#selectLocation").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
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
				$("#selectVariety").html("");
				$("#selectVariety").chosen("destroy");
				clear_content;
				getStorage();
			}, function() {
				//初始化执行方法
			});
		}

		function getStorage() {
			var wId = $("#selectCk").val();
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : rootPath + "/kcxx/findVAndPByWId.shtml",
				data : {
					id : wId
				},
				success : function(data) {
					if (data != null) {
						$("#currentWeight").val(data.cangKu);
						$("#varietyName").val(data.variety);
						$("#varietyId").val(data.name);
					}
				},
				error : function(data) {

				}
			});
		}
		function clear_content(){
			$("#currentWeight").val("");
			$("#varietyName").val("");
			$("#varietyId").val("");
		}
		$("#form").validate({
			submitHandler : function(form) {
				ly.ajaxSubmit(form, {
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
			errorPlacement : function(error, element) {

			},
			success : function(label) {// 验证通过后
				var d1 = new Date($("#start").val());
				var d2 = new Date($("#start1").val());
				$("#totalTime").val((d2 - d1) / 1000 / 60 / 60 / 24);
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
