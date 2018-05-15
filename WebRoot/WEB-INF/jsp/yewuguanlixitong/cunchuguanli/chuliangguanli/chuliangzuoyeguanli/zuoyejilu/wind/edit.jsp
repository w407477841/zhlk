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
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/foodStorageManager/editWind.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="FoodStorageWindFormMap.id"
				value="${FoodStorageWindFormMap.id}">

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">

				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">基础信息</h3>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						粮库地点<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
								name="FoodStorageWindFormMap.location"
								data-placeholder="请选择粮库地点">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						仓号<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectCk" data-rel="chosen"
								name="FoodStorageWindFormMap.houseid" data-placeholder="请选择仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						粮食品种<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input id="varietyName" type="text" readonly="readonly" class="form-control" value="${FoodStorageWindFormMap.text }">
						<input id="varietyId" type="hidden" name="FoodStorageWindFormMap.breed" value="${FoodStorageWindFormMap.breed }">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						数量(kg)<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="currentWeight"  class="form-control"
								name="FoodStorageWindFormMap.amount"
								value="${FoodStorageWindFormMap.amount }"
								placeholder="请输入：数量(kg)" readonly="readonly">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						通风目的<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control  easyui-validatebox"
								missingMessage="请输入通风目的" data-options="required:true"
								name="FoodStorageWindFormMap.purpose"
								value="${FoodStorageWindFormMap.purpose }"
								placeholder="请输入：通风目的" maxlength="64">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						粮层厚度<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control  easyui-validatebox"
								missingMessage="请输入粮层厚度" data-options="required:true"
								name="FoodStorageWindFormMap.thick"
								value="${FoodStorageWindFormMap.thick }" placeholder="请输入：粮层厚度"  maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">风机型号</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageWindFormMap.devicetype"
								value="${FoodStorageWindFormMap.devicetype }" maxlength="64"
								placeholder="请输入：风机型号">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单风机功率</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.deviceP"
								value="${FoodStorageWindFormMap.deviceP }" maxlength="64"
								placeholder="请输入：单台风机功率（Kw）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">风网类型</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control "
								name="FoodStorageWindFormMap.nettype" maxlength="64"
								value="${FoodStorageWindFormMap.nettype }"
								placeholder="请输入：风网类型">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">风网总阻力</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.netPa" maxlength="64"
								value="${FoodStorageWindFormMap.netPa }"
								placeholder="请输入：风网总阻力（Pa）">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总风量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.windamount" maxlength="64"
								value="${FoodStorageWindFormMap.windamount }"
								placeholder="请输入：总风量(m2/h)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">风机数量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.deviceamount" maxlength="10"
								value="${FoodStorageWindFormMap.deviceamount }"
								placeholder="请输入：风机数量（台）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">送风方式</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.windtype" maxlength="64"
								value="${FoodStorageWindFormMap.windtype }"
								placeholder="请输入：送风方式（吸/压）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单位通风量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.windperH" maxlength="64"
								value="${FoodStorageWindFormMap.windperH }"
								placeholder="请输入：单位通风量（m3/h.t）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">通风开始时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class="form-control"
								name="FoodStorageWindFormMap.times"
								value="${FoodStorageWindFormMap.times }" placeholder="请输入：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">通风结束时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text" class="form-control"
								name="FoodStorageWindFormMap.timee"
								value="${FoodStorageWindFormMap.timee }" placeholder="请输入：结束时间">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">累计通风时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.timeTotal" maxlength="10"
								value="${FoodStorageWindFormMap.timeTotal }"
								placeholder="请输入：累计通风时间（小时）">
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
										name="FoodStorageWindFormMap.temperatureMax"
										value="${FoodStorageWindFormMap.temperatureMax }" maxlength="10"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageWindFormMap.temperatureMin" maxlength="10"
										value="${FoodStorageWindFormMap.temperatureMin }"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageWindFormMap.temperatureAvg" maxlength="10"
										value="${FoodStorageWindFormMap.temperatureAvg }"
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
										name="FoodStorageWindFormMap.wetMax" maxlength="10"
										value="${FoodStorageWindFormMap.wetMax }"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageWindFormMap.wetMin" maxlength="10"
										value="${FoodStorageWindFormMap.wetMin }"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageWindFormMap.wetAvg" maxlength="10"
										value="${FoodStorageWindFormMap.wetAvg }"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>

					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">通风前粮食温度（℃）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperatureMax_b"
										value="${FoodStorageWindFormMap.ftemperatureMax_b }"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperatureMin_b"
										value="${FoodStorageWindFormMap.ftemperatureMin_b }"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperatureAvg_b"
										value="${FoodStorageWindFormMap.ftemperatureAvg_b }"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperature_ladderMax_b"
										value="${FoodStorageWindFormMap.ftemperature_ladderMax_b }"
										placeholder="℃/米粮层厚度或水分%/米粮层厚度">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">通风后粮食温度（℃）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperatureMax_a"
										value="${FoodStorageWindFormMap.ftemperatureMax_a }"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperatureMin_a"
										value="${FoodStorageWindFormMap.ftemperatureMin_a }"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperatureAvg_a"
										value="${FoodStorageWindFormMap.ftemperatureAvg_a }"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.ftemperature_ladderMax_a"
										value="${FoodStorageWindFormMap.ftemperature_ladderMax_a }"
										placeholder="℃/米粮层厚度或水分%/米粮层厚度">
								</div>
							</div>
						</div>

					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">通风前粮食水分（%）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.waterMax_b"
										value="${FoodStorageWindFormMap.waterMax_b }"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.waterMin_b"
										value="${FoodStorageWindFormMap.waterMin_b }"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.waterAvg_b"
										value="${FoodStorageWindFormMap.waterAvg_b }"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.water_ladderMax_b"
										value="${FoodStorageWindFormMap.water_ladderMax_b }"
										placeholder="℃/米粮层厚度或水分%/米粮层厚度">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">通风后粮食水分（%）</div>
					<div class="col-md-10">

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.waterMax_a"
										value="${FoodStorageWindFormMap.waterMax_a }"
										placeholder="请输入：最大值">
								</div>
							</div>
						</div>

						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.waterMin_a"
										value="${FoodStorageWindFormMap.waterMin_a }"
										placeholder="请输入：最小值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.waterAvg_a"
										value="${FoodStorageWindFormMap.waterAvg_a }"
										placeholder="请输入：平均值">
								</div>
							</div>
						</div>
						<div class="form-group col-md-3">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control" maxlength="10"
										name="FoodStorageWindFormMap.water_ladderMax_a"
										value="${FoodStorageWindFormMap.water_ladderMax_a }"
										placeholder="℃/米粮层厚度或水分%/米粮层厚度">
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						总耗电
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.elecAmount" maxlength="10"
								value="${FoodStorageWindFormMap.elecAmount }"
								placeholder="请输入：总耗电（Kw.h）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						单位能耗
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.elecAmountPerHour" maxlength="10"
								value="${FoodStorageWindFormMap.elecAmountPerHour }"
								placeholder="请输入：单位能耗（Kw.h/℃.吨或Kw.h/1%水分.t）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">负责人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageWindFormMap.charge" maxlength="32"
								value="${FoodStorageWindFormMap.charge }" placeholder="请输入：负责人">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">操作人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" maxlength="32"
								name="FoodStorageWindFormMap.operator"
								value="${FoodStorageWindFormMap.operator }"
								placeholder="请输入：操作人">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">备注</div>
					<div class="col-md-9">
						<div class="has-warning">
							<textarea class="form-control" maxlength="128"
								name="FoodStorageWindFormMap.comment" placeholder="请输入：备注"> ${FoodStorageWindFormMap.comment }</textarea>
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
			option_html_prefix : ",",
			selected_val:"${FoodStorageWindFormMap.location}"

		}, function() {
			//给change事件添加方法
			$("#selectCk").html("");
			$("#selectCk").chosen("destroy");
			ck();
			$("#selectCk").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
			clear_content();
		}, function() {
			//初始化执行方法
			ck();

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
				option_html_prefix : ",",
				selected_val:"${FoodStorageWindFormMap.houseid}"
			}, function() {
				//给change事件添加方法
				clear_content();
				getStorage();
			}, function() {
				//初始化执行方法
			});
		}
		
		function getStorage(){
			var wId = $("#selectCk").val();
			$.ajax({
				type:'post',
				dataType:'json',
				url:rootPath+"/kcxx/findVAndPByWId.shtml",
				data:{id:wId},
				success:function(data){
					if(data != null){
						$("#currentWeight").val(data.cangKu);
						$("#varietyName").val(data.variety);
						$("#varietyId").val(data.name);
					}
				},
				error:function(data){
					
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
			rules : {

			},
			messages : {},
			errorPlacement : function(error, element) {
				

			},
			success : function(label) {// 验证通过后
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
