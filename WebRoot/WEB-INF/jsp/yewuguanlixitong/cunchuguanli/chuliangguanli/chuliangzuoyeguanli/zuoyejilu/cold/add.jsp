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

.div_lable1 {
	text-align: center;
	height: 56px;
	line-height: 56px
}

.form-control {
	padding: 0px 12px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/foodStorageManager/addCold.shtml">
			<input type="hidden" name="token" value="${token}">
			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<input type="hidden" id="totalTime"
					name="FoodStorageColdFormMap.timeLasts">
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
								name="FoodStorageColdFormMap.location"
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
								name="FoodStorageColdFormMap.houseid" data-placeholder="请选择仓号">
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
						<input id="varietyId" type="hidden" name="FoodStorageColdFormMap.breed">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">数量(kg)</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="currentWeight" class="form-control"
								readonly="readonly" name="FoodStorageColdFormMap.amount"
								placeholder="请输入：数量">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食等级</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLevel" data-rel="chosen"
								data-placeholder="请选择粮食等级" name="FoodStorageColdFormMap.level">
								<option value=""></option>
								<option value="1">1级</option>
								<option value="2">2级</option>
								<option value="3">3级</option>
								<option value="4">4级</option>
								<option value="5">5级</option>
								<option value="0">等级外</option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">水分</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.water" placeholder="请输入：水分(%)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">杂质</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.zazhi" placeholder="请输入：杂质(%)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">仓型</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.houseType" placeholder="请输入：仓型">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">跨度(直径)</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.length" placeholder="请输入：跨度(m)">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮层厚度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.thick" placeholder="请输入：粮层厚度(m)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮堆体积</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.volume" placeholder="请输入：粮堆体积(m3)">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">风网类型</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control "
								name="FoodStorageColdFormMap.type" placeholder="请输入：风网类型">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">风网总阻力</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.strength"
								placeholder="请输入：风网总阻力（Pa）">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总风量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.windAmount"
								placeholder="请输入：总风量(m2/h)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">冷却机型号</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageColdFormMap.mType" placeholder="请输入：冷却机型号">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">台数</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.mAmount" placeholder="请输入：台数">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总功率</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.power" placeholder="请输入：总功率(KW)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单位通风量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.windPerVolume"
								placeholder="请输入：单位通风量（m3/h.t）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">冷却通风目的</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.purpose" placeholder="请输入：冷却通风目的">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">通风开始时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class="form-control"
								name="FoodStorageColdFormMap.times" value=""
								placeholder="请输入：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">通风结束时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text" class="form-control"
								name="FoodStorageColdFormMap.timee" value=""
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
						<div class="col-md-4 div_label div_lable1">第一阶段:</div>
						<div class="col-md-4 div_label div_lable1">第二阶段:</div>
						<div class="col-md-4 div_label div_lable1">第三阶段:</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">大气温度（℃）:</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.temperature_1"
										placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.temperature_2"
										placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.temperature_3"
										placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">大气湿度（RH%）:</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.wet_1" placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.wet_2" placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.wet_3" placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">冷通前粮食温度（℃）:</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.ftemperature_b_1"
										placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.ftemperature_b_2"
										placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.ftemperature_b_3"
										placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">冷通后粮食温度（℃）:</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.ftemperature_a_1"
										placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.ftemperature_a_2"
										placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.ftemperature_a_3"
										placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">冷通前粮食水分（%）:</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_b_1" placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_b_2" placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_b_3" placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">冷通后粮食水分（%）:</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_a_1" placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_a_2" placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_a_3" placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">粮层温度梯度值(℃/m):</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.thickness_1"
										placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.thickness_2"
										placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.thickness_3"
										placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-2 div_label">粮层水分梯度值(℃/m):</div>
					<div class="col-md-10">

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_1" placeholder="请输入：第一阶段">
								</div>
							</div>
						</div>

						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_2" placeholder="请输入：第二阶段">
								</div>
							</div>
						</div>
						<div class="form-group col-md-4">
							<div class="col-md-12">
								<div class="has-warning">
									<input type="text" class="form-control"
										name="FoodStorageColdFormMap.water_3" placeholder="请输入：第三阶段">
								</div>
							</div>
						</div>

					</div>
				</div>

			</div>
			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">冷却送风温度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.windTemperature"
								placeholder="请输入：设定值/检测值">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">冷却送风湿度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.wetTemperature"
								placeholder="请输入：设定值/检测值">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">实际冷却处理能力</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.capacity" placeholder="请输入：(t/24h)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总耗电</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.elecAmount"
								placeholder="请输入：总耗电（Kw.h）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单位能耗</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.elecAmountPerHour"
								placeholder="请输入：（Kw.h/℃.吨或Kw.h/1%水分.t）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">负责人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.chargeOne" placeholder="请输入：负责人">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">记录人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageColdFormMap.recordOne" placeholder="请输入：记录人">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">备注</div>
					<div class="col-md-9">
						<div class="has-warning">
							<textarea type="text" class="form-control"
								name="FoodStorageColdFormMap.comment" placeholder="请输入：备注"></textarea>
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
			clear_content();
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
				clear_content();
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
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
