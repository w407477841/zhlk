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
			<h3 class="animated rubberBand">作业方案</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/foodStorageManager/addProject.shtml">
			<input type="hidden" name="token" value="${token}"> <input
				type="hidden" name="FoodStorageProjectFormMap.ctime"
				value="javascript:return new Date()">
			<div class="form-group col-md-12">
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">方案类型</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectRs" data-rel="chosen"
								data-placeholder="请选择方案类型" name="FoodStorageProjectFormMap.type"
								onchange="changeShow(this)">
								<option value=""></option>
								<option value="0">通风</option>
								<option value="1">熏蒸</option>
								<option value="2">冷却</option>
							</select>
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮库地点</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"
								name="FoodStorageProjectFormMap.location"
								data-placeholder="请选择粮库地点">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓号</div>
					<div class="col-md-10">
						<div class="has-warning">
							<select id="selectHouseid" data-rel="chosen"
								name="FoodStorageProjectFormMap.houseid"
								data-placeholder="请选择仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">粮食品种</div>
					<div class="col-md-10">
						<div class="has-warning">
						<input id="varietyName" type="text" readonly="readonly" class="form-control">
						<input id="varietyId" type="hidden" name="FoodStorageProjectFormMap.breed">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">目前数量</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" id="currentWeight" class="form-control"
								name="FoodStorageProjectFormMap.amount"
								placeholder="请输入：目前数量(公斤)" readonly="readonly">
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">目前粮温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.temperature"
								placeholder="请输入：目前粮温(℃)" maxlength="10">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.houseTemperature"
								placeholder="请输入：仓温(℃)" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">主要虫害</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class=" form-control "
								name="FoodStorageProjectFormMap.chonghai" placeholder="请输入：主要虫害"
								maxlength="64">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">每公斤</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.perWeight"
								placeholder="请输入：每公斤(头)" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓廒长</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control " id="waInnerLong"
								name="FoodStorageProjectFormMap.length" placeholder="请输入：仓廒长(米)"
								maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓廒宽</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" id="waInnerWidth"
								name="FoodStorageProjectFormMap.width" placeholder="请输入：仓廒宽(米)"
								maxlength="10">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓廒高</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" id="waDesignHeight"
								name="FoodStorageProjectFormMap.height" placeholder="请输入：仓廒高(米)"
								maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">堆粮限高</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" 
								name="FoodStorageProjectFormMap.lineHeight"
								placeholder="请输入：堆粮限高(米)" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">水分</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" id="sf"
								name="FoodStorageProjectFormMap.waterPer" placeholder="请输入：水分"
								maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">实际存粮高度</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.acturalHeight"
								placeholder="请输入：实际存粮高度(米)" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">上层粮温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.upperTemperature"
								placeholder="请输入：上层粮温(℃)" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">下层粮温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.footTemperature"
								placeholder="请输入：下层粮温(℃)" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">大气湿度</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.wet" placeholder="请输入：大气湿度(%)"
								maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">仓内湿度</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.innerWet"
								placeholder="请输入：仓内湿度(%)" maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">气温</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.qiwen" placeholder="请输入：气温(℃)"
								maxlength="10">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6" id="tongfeng">
					<div class="col-md-2 div_label">通风形式</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" id="waAeration"
								name="FoodStorageProjectFormMap.windForm" placeholder="请输入：通风形式"
								maxlength="64">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6" id="xunzheng">
					<div class="col-md-2 div_label">熏蒸形式</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" id="waFumigate"
								name="FoodStorageProjectFormMap.steamForm"
								placeholder="请输入：熏蒸形式" maxlength="64">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6" id="xunzheng1">
					<div class="col-md-2 div_label">熏蒸备案编号</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control" id="waFumigate"
								name="FoodStorageProjectFormMap.bId"
								placeholder="请输入：熏蒸备案编号" maxlength="32">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6" id="lengque">
					<div class="col-md-2 div_label">冷却形式</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.coldForm" placeholder="请输入：冷却形式"
								maxlength="64">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6" id="tongfengmudi">
					<div class="col-md-2 div_label">通风目的</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input type="text" class="form-control"
								name="FoodStorageProjectFormMap.purpose" placeholder="请输入：通风目的"
								maxlength="64">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">开始时间</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="start" type="text" class="form-control "
								name="FoodStorageProjectFormMap.times" placeholder="请输入：开始时间">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-2 div_label">结束时间</div>
					<div class="col-md-10">
						<div class="has-warning">
							<input id="start1" type="text" class="form-control "
								name="FoodStorageProjectFormMap.timee" placeholder="请输入：结束时间">
						</div>
					</div>
				</div>
				<div class="form-group col-md-12">
					<div class="col-md-1 div_label">方案内容</div>
					<div class="col-md-11">
						<div class="has-warning">
							<textarea class="form-control" rows="4" cols="10"
								name="FoodStorageProjectFormMap.content" placeholder="请输入：方案内容"
								maxlength="128"></textarea>
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
			$("#selectHouseid").html("");
			$("#selectHouseid").chosen("destroy");
			ck();
			$("#selectHouseid").chosen({
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
				obj_id : "selectHouseid",
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
				getDetail();
			}, function() {
				//初始化执行方法
			});
		}

		function getStorage() {
			var wId = $("#selectHouseid").val();
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
		function getDetail() {
			var wId = $("#selectHouseid").val();
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : rootPath + "/foodStorageManager/getDetail.shtml",
				data : {
					wId : wId
				},
				success : function(data) {
					if (data != null) {
						$("#waInnerWidth").val(data.waInnerWidth);
						$("#waInnerLong").val(data.waInnerLong);
						$("#waDesignHeight").val(data.waDesignHeight);
						$("#waAeration").val(data.waAeration);
						$("#waFumigate").val(data.waFumigate);
						$("#sf").val(data.sf);
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
			$("#waInnerWidth").val("");
			$("#waInnerLong").val("");
			$("#waDesignHeight").val("");
			$("#waAeration").val("");
			$("#waFumigate").val("");
			$("#sf").val("");
		}
		
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
			errorPlacement : function(error, element) {

			},
			success : function(label) {// 验证通过后

			}
		});

		$("#tongfeng").hide();
		$("#xunzheng").hide();
		$("#xunzheng1").hide();
		$("#lengque").hide();
		$("#tongfengmudi").hide();
		function changeShow(obj) {
			var val = $(obj).val();
			if (val == null || val == '') {
				$("#tongfeng").hide();
				$("#xunzheng").hide();
				$("#xunzheng1").hide();
				$("#lengque").hide();
				$("#tongfengmudi").hide();
			} else if (val == '0') {
				$("#tongfeng").show();
				$("#xunzheng").hide();
				$("#xunzheng1").hide();
				$("#lengque").hide();
				$("#tongfengmudi").show();
			} else if (val == '1') {
				$("#tongfeng").hide();
				$("#xunzheng").show();
				$("#xunzheng1").show();
				$("#lengque").hide();
				$("#tongfengmudi").hide();
			} else if (val == '2') {
				$("#tongfeng").hide();
				$("#xunzheng").hide();
				$("#xunzheng1").hide();
				$("#lengque").show();
				$("#tongfengmudi").hide();
			}
		}

		function _submit() {
			if ($("#form").form("validate")) {
				$("#form").submit();
			}
		}
	</script>
</body>
</html>
