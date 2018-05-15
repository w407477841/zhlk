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

.btn_1 {
	font-size: 10px
}

.form-control {
	padding: 0px 12px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/foodStorageManager/editSteamPlan.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="FoodStorageSteamPlanFormMap.id"
				value='${ FoodStorageSteamPlanFormMap.id}'> <input
				type="hidden" name="FoodStorageSteamPlanFormMap.version"
				value='${ FoodStorageSteamPlanFormMap.version}'> <input
				type="hidden" id="pMsg" name="FoodStorageSteamPlanFormMap.peopleMsg"
				value='${ FoodStorageSteamPlanFormMap.peopleMsg}'> <input
				type="hidden" id="tMsg" name="FoodStorageSteamPlanFormMap.targetMsg"
				value='${ FoodStorageSteamPlanFormMap.targetMsg}'>
			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">

				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">基础信息</h3>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">负责人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.charge"
								value="${ FoodStorageSteamPlanFormMap.charge}"
								placeholder="请输入：负责人">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">联系电话</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.cconcator"
								value="${ FoodStorageSteamPlanFormMap.cconcator}"
								placeholder="请输入：负责人联系电话">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">警戒距离-东</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.east"
								value="${ FoodStorageSteamPlanFormMap.east}"
								placeholder="请输入：警戒距离-东">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">警戒距离-西</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.west"
								value="${ FoodStorageSteamPlanFormMap.west}"
								placeholder="请输入：警戒距离-西">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">警戒距离-南</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.south"
								value="${ FoodStorageSteamPlanFormMap.south}"
								placeholder="请输入：警戒距离-南">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">警戒距离-北</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.north"
								value="${ FoodStorageSteamPlanFormMap.north}"
								placeholder="请输入：警戒距离-北">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">填表人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.filler"
								value="${ FoodStorageSteamPlanFormMap.filler}"
								placeholder="请输入：填表人">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">填表人联系电话</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.fconcator"
								value="${ FoodStorageSteamPlanFormMap.fconcator}"
								placeholder="请输入：填表人联系电话">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">填表人电子信箱</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.email"
								value="${ FoodStorageSteamPlanFormMap.email}"
								placeholder="请输入：填表人电子信箱">
						</div>
					</div>
				</div>


			</div>

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">药剂信息</h3>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">药剂名称</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectMedicine" data-rel="chosen"
								data-placeholder="请选择药剂名称"
								name="FoodStorageSteamPlanFormMap.mName">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">类型/型号</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="medicineType" readonly="readonly"
								class=" form-control " name="FoodStorageSteamPlanFormMap.mType"
								value="${ FoodStorageSteamPlanFormMap.mType}"
								placeholder="请输入：类型/型号">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">有效期至</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.mDate" id="dateTime"
								value="${ FoodStorageSteamPlanFormMap.mDate}"
								placeholder="请输入：有效期">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">暂存地点</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.mPlace"
								value="${ FoodStorageSteamPlanFormMap.mPlace}"
								placeholder="请输入：暂存地点">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">领取数量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.mAmount"
								value="${ FoodStorageSteamPlanFormMap.mAmount}"
								placeholder="请输入：领取数量">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">领取人</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.mPerson"
								value="${ FoodStorageSteamPlanFormMap.mPerson}"
								placeholder="请输入：领取人">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">领取时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.mTime" id="dateTime1"
								value="${ FoodStorageSteamPlanFormMap.mTime}"
								placeholder="请输入：领取时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">施药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.mUseAmount"
								value="${ FoodStorageSteamPlanFormMap.mUseAmount}"
								placeholder="请输入：施药量">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">药剂残渣</div>
					<div class="col-md-9">
						<div class="has-warning">
							<textarea type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.mComment"
								placeholder="请输入：药剂残渣处理说明">${ FoodStorageSteamPlanFormMap.mComment}</textarea>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">备注</div>
					<div class="col-md-9">
						<div class="has-warning">
							<textarea type="text" class=" form-control "
								name="FoodStorageSteamPlanFormMap.remark" placeholder="请输入：备注">${ FoodStorageSteamPlanFormMap.remark}</textarea>
						</div>
					</div>
				</div>

			</div>
			<div class="form-group col-md-12" id="peopleMsg"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">熏蒸人员信息</h3>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						姓名<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" data-pass=true
								placeholder="请输入：姓名">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						职务<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" data-pass=true
								placeholder="请输入：职务">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						职业资质<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" data-pass=true
								placeholder="请输入：职业资质">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">身体状况</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name=""
								placeholder="请输入：身体状况">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">熏蒸任务分工</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name=""
								placeholder="请输入：熏蒸任务分工">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">是否为外请</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name=""
								placeholder="请输入：是否为外请">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12" style="text-align: center;">
					<a class="btn btn-warning" href="javascript:void(0)" id="addPerson">
						<i class="glyphicon glyphicon-plus icon-white"></i>新增
					</a>
				</div>

				<div id="magazineGrid" style="width: 100%;height: 150px"></div>
			</div>

			<div id="targetMsg" class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">熏蒸对象信息</h3>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">
						粮库地点<span>*</span>
					</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
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
							<select id="selectCk" data-rel="chosen" data-placeholder="请选择仓号">
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
							<select id="selectVariety" data-rel="chosen"
								data-placeholder="请选择粮食品种">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食数量(kg)</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="currentWeight"
								class="form-control validate" data-pass=true
								placeholder="请输入：粮食数量(kg)">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">堆装方式</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control validate"
								placeholder="请输入：堆装方式">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">当前害虫及密度</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control validate" data-pass=true
								placeholder="请输入：当前害虫及密度">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">入库时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="start" class="validate form-control "
								placeholder="请输入：入库时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">上次熏蒸时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="start1" class=" validate  form-control "
								placeholder="请输入：上次熏蒸时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">计划熏蒸时间</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="start2" data-pass=true
								class=" validate form-control " placeholder="请输入：计划熏蒸时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">计划用药量</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control validate"
								placeholder="请输入：计划用药量(kg)">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12" style="text-align: center;">
					<a class="btn btn-warning" href="javascript:void(0)" id="addTarget">
						<i class="glyphicon glyphicon-plus icon-white"></i>新增
					</a>
				</div>
				<div id="magazineGrid1" style="width: 100%;height: 150px"></div>
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
		laydate({
			elem : '#start2',
			event : 'focus'
		});
		laydate({
			elem : '#dateTime',
			event : 'focus'
		});
		laydate({
			elem : '#dateTime1',
			event : 'focus'
		});
		new myselect({
			obj_id : "selectLocation",
			url : rootPath + "/warehouse/findMap.shtml",
			option_val : [ "id", "wName" ],
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
		$("#selectLocation").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
		function ck() {
			new myselect({
				obj_id : "selectCk",
				url : rootPath + "/warehouse/findWareHouseByLocation2.shtml",
				data : {
					"location_id" : $("#selectLocation").val().split(",")[0]
				},
				option_val : [ "id", "wName" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","
			}, function() {
				//给change事件添加方法
				$("#selectVariety").html("");
				$("#selectVariety").chosen("destroy");
				getStorage();
			}, function() {
				//初始化执行方法
			});
		}

		function variety(selectVal) {
			new myselect({
				obj_id : "selectVariety",
				url : "${ctx}/variety/findEnableVariety.shtml",
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "text" ],
				option_html_prefix : ",",
				selected_val : selectVal

			}, function() {
				//给change事件添加方法
			}, function() {
				//初始化执行方法
			});
			$("#selectVariety").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});

		}

		function getStorage() {
			var wId = $("#selectCk").val().split(",")[0];
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : rootPath + "/store/findById.shtml",
				data : {
					wId : wId
				},
				success : function(data) {
					if (data != null) {
						$("#currentWeight").val(parseFloat(data.cangKu));
						variety(data.name);
					}
				},
				error : function(data) {

				}
			});
		}
		new myselect({
			obj_id : "selectMedicine",
			url : rootPath + "/foodStorageManager/queryMedicines.shtml",
			option_val : [ "id", "mrName", "mrBrand" ],
			option_val_prefix : ",",
			option_html : [ "mrName" ],
			option_html_prefix : ",",
			selected_val : "${FoodStorageSteamPlanFormMap.mName}"

		}, function() {
			//给change事件添加方法
			$("#medicineType").val(
					$("#selectMedicine").find("option:selected").val().split(
							",")[2]);
		}, function() {
			//初始化执行方法
		});
		$("#selectMedicine").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});

		var grid = $('#magazineGrid')
				.datagrid(
						{
							fitColumns : true,
							rownumbers : true,
							data : $("#pMsg").val().parseToArr(),
							columns : [ [
									{
										field : 'name',
										title : '姓名',
										width : 140
									},
									{
										field : 'job',
										title : '职务',
										width : 140
									},
									{
										field : 'years',
										title : '职业资质',
										width : 200
									},
									{
										field : 'health',
										title : '身体状况',
										width : 100
									},
									{
										field : 'role',
										title : '熏蒸任务分工',
										width : 100
									},
									{
										field : 'native',
										title : '是否为外请',
										width : 100
									},
									{
										field : '_option',
										title : '操作',
										width : 150,
										align : 'left',
										formatter : function(value, row, index) {
											return "<a class='btn btn-primary btn_1' onclick='deleteMsg("
													+ index
													+ ",1)' ><i class='glyphicon glyphicon-remove glyphicon-white'></i>删除</a> "
										}
									} ] ]
						});
		$("#addPerson").on("click", function() {
			var i = 0;
			var arr = [];
			$("#peopleMsg input").each(function(index, elem) {
				elem.style.cssText = "";
				if (elem.dataset.pass && elem.value == '') {
					elem.style.cssText = "border: 1px solid #ff0000";
					i++;
				}
				arr.push(elem.value);
			})
			if (i == 0) {
				$('#magazineGrid').datagrid("appendRow", new Person(arr));
			}
			console.log("==================================")
			console.log($('#magazineGrid').datagrid("getRows"))
			$("#pMsg").val($('#magazineGrid').datagrid("getRows").seriArrs());
		})

		var grid1 = $('#magazineGrid1')
				.datagrid(
						{
							fitColumns : true,
							rownumbers : true,
							data : $("#tMsg").val().parseToArr(),
							columns : [ [
									{
										field : 'location',
										title : '所属粮库',
										width : 140,
										formatter : function(value) {
											return value.split(",")[1]
										}
									},
									{
										field : 'houseid',
										title : '仓号',
										width : 140,
										formatter : function(value) {
											return value.split(",")[1]
										}
									},
									{
										field : 'breed',
										title : '品种',
										width : 140
									},
									{
										field : 'amount',
										title : '粮食数量',
										width : 200
									},
									{
										field : 'type',
										title : '堆装方式',
										width : 100
									},
									{
										field : 'insects',
										title : '当前虫害',
										width : 100
									},
									{
										field : 'inDate',
										title : '入库时间',
										width : 100
									},
									{
										field : 'lastDate',
										title : '上次熏蒸时间',
										width : 200
									},
									{
										field : 'planedTime',
										title : '计划熏蒸时间',
										width : 200
									},
									{
										field : 'mAmount',
										title : '计划用药量',
										width : 100
									},
									{
										field : '_option',
										title : '操作',
										width : 150,
										align : 'left',
										formatter : function(value, row, index) {
											return "<a class='btn btn-primary btn_1' onclick='deleteMsg("
													+ index
													+ ",2)' ><i class='glyphicon glyphicon-remove glyphicon-white'></i>删除</a> "
										}
									} ] ]
						});

		$("#addTarget")
				.on(
						"click",
						function() {
							var i = 0;
							var arr = [];
							if (typeof vaildateSelects == "function"
									&& vaildateSelects.call(null)) {
								var rs = vaildateInputs($(".validate"));
								if (!rs.pass) {
									var returnVal = [
											$("#selectVariety").find(
													"option:selected").text(),
											$("#selectLocation").val(),
											$("#selectCk").val() ]
											.concat(rs.results);
									console.log(new Target(returnVal))
									$('#magazineGrid1').datagrid("appendRow",
											new Target(returnVal));
								}
							}
							console.log("==================================")
							console
									.log($('#magazineGrid1')
											.datagrid("getRows"))
							$("#tMsg").val(
									$('#magazineGrid1').datagrid("getRows")
											.seriArrs());
						})

		function Person(arr) {
			this.name = arr[0];
			this.job = arr[1];
			this.years = arr[2];
			this.health = arr[3];
			this.role = arr[4];
			this.native = arr[5];
		}
		function Target(arr) {
			this.houseid = arr[2];
			this.breed = arr[0];
			this.amount = arr[3];
			this.location = arr[1];
			this.type = arr[4];
			this.insects = arr[5];
			this.inDate = arr[6];
			this.lastDate = arr[7];
			this.planedTime = arr[8];
			this.mAmount = arr[9];

		}

		//验证select
		function vaildateSelects() {
			var eles = $("#targetMsg select");
			var ids = [];
			var j = 0
			for (var i = 0; i < eles.length; i++) {
				if (eles[i].type == "select-one" && eles[i].id) {
					ids.push(eles[i].id + "_chosen");
				}
			}
			ids
					.forEach(function(str, index) {
						var t = document.getElementById(str).children[0].children[0].textContent;
						var n = document.getElementById(str.replace("_chosen",
								"")).dataset.placeholder;
						document.getElementById(str).children[0].style
								.removeProperty("border");
						if (t == "" || t == n) {
							j++;
							document.getElementById(str).scrollIntoView();
							document.getElementById(str).children[0].style
									.setProperty("border", "1px solid #ff0000");
							return false
						}
					})
			return !!!j
		}
		//验证input
		function vaildateInputs(elems) {
			var j = 0, arr = [];
			for (var i = 0; i < elems.length; i++) {
				elems[i].style.cssText = "";
				if (elems[i].dataset.pass && elems[i].value == '') {
					elems[i].style.cssText = "border: 1px solid #ff0000";
					j++;
				}
				arr.push(elems[i].value)
			}
			return {
				pass : j,
				results : arr
			};
		}
		function deleteMsg(index, context) {
			console.log(index)
			if (context == "1") {
				grid.datagrid("deleteRow", index);
				grid.datagrid("acceptChanges");
				$("#pMsg").val(
						$('#magazineGrid').datagrid("getRows").seriArrs());
			}
			if (context == "2") {
				grid1.datagrid("deleteRow", index);
				grid1.datagrid("reload");
				$("#tMsg").val(
						$('#magazineGrid1').datagrid("getRows").seriArrs());
			}
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
			rules : {

			},
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
