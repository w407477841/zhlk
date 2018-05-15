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

.form-control {
	padding: 0px 12px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/foodStorageManager/editSteam.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="FoodStorageSteamFormMap.type" value="1">
			<input type="hidden" name="FoodStorageSteamFormMap.id"
				value="${FoodStorageSteamFormMap.id}">

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">初始参数</h3>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮库地点</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
								name="FoodStorageSteamFormMap.location"
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
								name="FoodStorageSteamFormMap.houseid" data-placeholder="请选择仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input id="varietyName" type="text" readonly="readonly" class="form-control" value="${FoodStorageSteamFormMap.text }">
						<input id="varietyId" type="hidden" name="FoodStorageSteamFormMap.breed" value="${FoodStorageSteamFormMap.breed }">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">数量(kg)</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="currentWeight" class="form-control"
								name="FoodStorageSteamFormMap.amount" readonly="readonly"
								value="${FoodStorageSteamFormMap.amount }"
								placeholder="请输入：数量(kg)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">药剂名称</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.names"
								value="${FoodStorageSteamFormMap.names }" placeholder="请输入：药剂名称">
						</div>
					</div>
				</div>



				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">剂型与纯度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.medicineType"
								value="${FoodStorageSteamFormMap.medicineType}"
								placeholder="请输入：剂型与纯度">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食水分</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.water"
								value="${FoodStorageSteamFormMap.water }"
								placeholder="请输入：粮食水分(%)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">施药方法</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamFormMap.methods"
								value="${FoodStorageSteamFormMap.methods }"
								placeholder="请输入：施药方法">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食杂质</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.zazhi"
								value="${FoodStorageSteamFormMap.zazhi }"
								placeholder="请输入：粮食杂质(%)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">施药人数</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control "
								name="FoodStorageSteamFormMap.persons"
								value="${FoodStorageSteamFormMap.persons }"
								placeholder="请输入：施药人数(人)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">天气</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.weather"
								value="${FoodStorageSteamFormMap.weather }" placeholder="请输入：天气">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">气温</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.temperature"
								value="${FoodStorageSteamFormMap.temperature }"
								placeholder="请输入：气温（℃）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">开始时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text"
								class=" inline laydate-icon  form-control "
								name="FoodStorageSteamFormMap.times"
								value="${FoodStorageSteamFormMap.times }" placeholder="请输入：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">结束时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text"
								class=" inline laydate-icon  form-control "
								name="FoodStorageSteamFormMap.timee"
								value="${FoodStorageSteamFormMap.timee }" placeholder="请输入：结束时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">密闭方式</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.way"
								value="${ FoodStorageSteamFormMap.way}" placeholder="请输入：密闭方式">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">仓温</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.houseTemperature"
								value="${FoodStorageSteamFormMap.days }" placeholder="请输入：仓温（℃）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">密闭时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.days"
								value="${FoodStorageSteamFormMap.days }"
								placeholder="请输入：密闭时间(天)">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">上次熏蒸日期</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="start2"
								class="  inline laydate-icon form-control"
								name="FoodStorageSteamFormMap.lastDate"
								value="${FoodStorageSteamFormMap.lastDate }"
								placeholder="请输入：上次熏蒸日期">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">设定施药浓度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.thickness"
								value="${FoodStorageSteamFormMap.thickness }"
								placeholder="请输入：设定施药浓度（ml/m3）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">理论施药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.tamount"
								value="${FoodStorageSteamFormMap.tamount }"
								placeholder="请输入：理论施药量（g/m3）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">第一次用药总量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.firstAmount"
								value="${FoodStorageSteamFormMap.firstAmount }"
								placeholder="请输入：第一次用药总量(Kg)">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">环流时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.hours"
								value="${FoodStorageSteamFormMap.hours }"
								placeholder="请输入：环流时间（h）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">第一次补药日期</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="start3"
								class="  inline laydate-icon form-control"
								name="FoodStorageSteamFormMap.firstfillTime"
								value="${FoodStorageSteamFormMap.firstfillTime }"
								placeholder="请输入：第一次补药日期">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">第一次补药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.firstfillAmount"
								value="${FoodStorageSteamFormMap.firstfillAmount }"
								placeholder="请输入：第一次补药量（Kg）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">最后一次补药日期</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="start4"
								class=" inline laydate-icon form-control"
								name="FoodStorageSteamFormMap.lastfillDate"
								value="${ FoodStorageSteamFormMap.lastfillDate}"
								placeholder="请输入：最后一次补药日期">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">最后一次补药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.lastfillAmount"
								value="${FoodStorageSteamFormMap.lastfillAmount }"
								placeholder="请输入：最后一次补药量">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总补药次数</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.fillTimes"
								value="${FoodStorageSteamFormMap.fillTimes }"
								placeholder="请输入：总补药次数（次）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">总补药次量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.fillAmounts"
								value="${ FoodStorageSteamFormMap.fillAmounts}"
								placeholder="请输入：总补药量（Kg）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">实际总用药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.acturalAmounts"
								value="${ FoodStorageSteamFormMap.acturalAmounts}"
								placeholder="请输入：实际总用药量（Kg）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">散气日期</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="start5"
								class=" inline laydate-icon form-control"
								name="FoodStorageSteamFormMap.openDate"
								value="${FoodStorageSteamFormMap.openDate }"
								placeholder="请输入：散气日期">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">散气方式</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.openWay"
								value="${FoodStorageSteamFormMap.openWay }"
								placeholder="请输入：散气方式">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">散气时间（天）</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.openDays"
								value="${FoodStorageSteamFormMap.openDays }"
								placeholder="请输入：散气时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">最高粮温</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.ftemperature_max"
								value="${FoodStorageSteamFormMap.ftemperature_max }"
								placeholder="请输入：最高粮温">
						</div>
					</div>
				</div>

				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">最低粮温</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.ftemperature_min"
								value="${FoodStorageSteamFormMap.ftemperature_min }"
								placeholder="请输入：最低粮温">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">平均粮温</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.ftemperature_avg"
								value="${FoodStorageSteamFormMap.ftemperature_avg }"
								placeholder="请输入：平均粮温">
						</div>
					</div>
				</div>

			</div>

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-2">
						<h3 class="animated rubberBand">体积</h3>
					</div>
				</div>

				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">堆粮</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.foodTotle"
								value="${FoodStorageSteamFormMap.foodTotle }"
								placeholder="请输入：堆粮（m3）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">空间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.spaceTotle"
								value="${FoodStorageSteamFormMap.spaceTotle }"
								placeholder="请输入：空间（m3）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">合计</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.sumTotal"
								value="${FoodStorageSteamFormMap.sumTotal }"
								placeholder="请输入：合计（m3）">
						</div>
					</div>
				</div>

				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">堆粮用药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.foodMedicine"
								value="${FoodStorageSteamFormMap.foodMedicine }"
								placeholder="请输入：堆粮用药量（Kg）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">空间用药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.spaceMedicine"
								value="${FoodStorageSteamFormMap.spaceMedicine }"
								placeholder="请输入：空间用药量（Kg）">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">合计用药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.sumMedicine"
								value="${FoodStorageSteamFormMap.sumMedicine }"
								placeholder="请输入：合计用药量（Kg）">
						</div>
					</div>
				</div>
			</div>
			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-2">
						<h3 class="animated rubberBand">熏蒸效果</h3>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">熏蒸前害虫密度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.insects_amount_before"
								value="${FoodStorageSteamFormMap.insects_amount_before }"
								placeholder="请输入：熏蒸前害虫密度">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">熏蒸前主要虫害</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.insects_before"
								value="${FoodStorageSteamFormMap.insects_before }"
								placeholder="请输入：熏蒸前主要虫害">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">熏蒸后害虫密度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.insects_amount_after"
								value="${FoodStorageSteamFormMap.insects_amount_after }"
								placeholder="请输入：熏蒸后害虫密度">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">&nbsp;</div>
					<div class="col-md-9">
						<div class="has-warning" style="height: 58px">&nbsp;</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">杀虫率</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.killingPercent"
								value="${FoodStorageSteamFormMap.killingPercent }"
								placeholder="请输入：杀虫率">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">培养天数</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.buildDays"
								value="${FoodStorageSteamFormMap.buildDays }"
								placeholder="请输入：培养天数(天)">
						</div>
					</div>
				</div>
			</div>

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-2">
						<h3 class="animated rubberBand">操作记录</h3>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">熏蒸负责人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.steamOne"
								value="${FoodStorageSteamFormMap.steamOne }"
								placeholder="请输入：熏蒸负责人">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">安全员</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.safetyOne"
								value="${FoodStorageSteamFormMap.safetyOne }"
								placeholder="请输入：安全员">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">记录人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageSteamFormMap.recordOne"
								value="${ FoodStorageSteamFormMap.recordOne}"
								placeholder="请输入：记录人">
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
			selected_val : "${FoodStorageSteamFormMap.location}"
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
				selected_val : "${FoodStorageSteamFormMap.houseid}"
			}, function() {
				//给change事件添加方法
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
