<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}
</style>
<!-- content starts -->
<div class="row">
	<div class="box col-md-12"
		style="padding-left: 0px; padding-right: 0px;">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list"></i> <span id="pageTitle"></span>
				</h2>
			</div>
			<div class="box-content" id="page">
				<div class="alert alert-info">
					<div class="row">
						<div class=" col-md-12">
							<form id="searchForm" name="searchForm">
								<div class="form-group col-md-6">
									<select id="selectmingcheng"
										name="storageInfoFormMap.selectmingcheng" data-rel="chosen"
										data-placeholder="企业名称" style="width:100%">
										<option value=""></option>
									</select>
								</div>

								<div class="form-group col-md-6">
									<select id="selectLocation" data-rel="chosen"
										onchange="changeValues()" data-placeholder="粮库地点"
										multiple="multiple" style="width:100%">
										<option value=""></option>
									</select> <input type="hidden" name="storageInfoFormMap.locationList"
										id="locationId">
								</div>
								<div class="form-group col-md-6">
									<select id="selectProperty" data-rel="chosen"
										onchange="changePropertyValues()" data-placeholder="粮食性质"
										multiple="multiple" style="width:100%">
										<option value=""></option>
									</select> <input type="hidden" name="storageInfoFormMap.propertyList"
										id="propertyList">
								</div>
								<div class="form-group col-md-6">
									<select id="selectVariety" data-rel="chosen"
										onchange="changeVarietyValues()" data-placeholder="粮食品种"
										multiple="multiple" style="width:100%">
										<option value=""></option>
									</select> <input type="hidden" name="storageInfoFormMap.varietyList"
										id="varietyList">
								</div>
							</form>
						</div>
						<div class=" col-md-12">
							<a class="btn btn-primary" href="javascript:void(0)" id="search"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-search icon-white"></i> 查询
							</a> <a class="btn btn-info" href="javascript:void(0)" id="export"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="fa fa-clipboard"></i> 生成报表
							</a>
						</div>
					</div>
				</div>
				<table id="magazineGrid" style="width:100%;height:560px">
				</table>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!--/row-->
<script type="text/javascript"
	src="js/system/yewuguanlixiytong/baobiaochaxun/cangkubaobiao/fendianbaobiaolist.js"></script>
<script type="text/javascript">
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());

	$('[data-rel="chosen"],[rel="chosen"]').chosen();
	(function() {
		$("#selectmingcheng").html("");
		$("#selectmingcheng").chosen("destroy");
		new myselect({
			obj_id : "selectmingcheng",
			url : rootPath
					+ "/warehouseLocationInterface/findAllMingCheng.shtml",
			option_val : [ "tongyixinyongdaima" ],
			option_val_prefix : ",",
			option_html : [ "qiyemingcheng" ],
			option_html_prefix : ","
		}, function() {
			//给change事件添加方法
			$("#selectLocation").html("");
			$("#selectLocation").chosen("destroy");
			findWarehouse();
			$("#selectLocation").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		}, function() {
			//初始化执行方法
		});
		$("#selectmingcheng").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});

		$("#selectProperty").html("");
		$("#selectProperty").chosen("destroy");
		new myselect({
			obj_id : "selectProperty",
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
		$("#selectProperty").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});

		$("#selectVariety").html("");
		$("#selectVariety").chosen("destroy");
		new myselect({
			obj_id : "selectVariety",
			url : rootPath + "/variety/findTopMenuVariety.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "text" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});
		$("#selectVariety").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
	})();

	function findWarehouse() {
		var id = $("#selectmingcheng").val();
		new myselect(
				{
					obj_id : "selectLocation",
					url : rootPath
							+ "/warehouseLocationInterface/findAllByXinYongDaiMa.shtml",
					option_val : [ "location_no" ],
					option_val_prefix : ",",
					data : {
						id : id
					},
					option_html : [ "wName" ],
					option_html_prefix : ","

				}, function() {
					//给change事件添加方法
				}, function() {
					//初始化执行方法
				});

	}
	function changeValues() {
		var weights = '';
		$('#selectLocation option').each(function() {
			if ($(this).is(':selected')) {
				weights += $(this).val() + ",";
			}
		});
		$("#locationId").val(weights);
	}
	function changePropertyValues() {
		var weights = '';
		$('#selectProperty option').each(function() {
			if ($(this).is(':selected')) {
				weights += $(this).val() + ",";
			}
		});
		var arr = weights.split(",");
		if (arr.length > 3) {
			layer.alert("报表最多显示两个粮食性质！", {
				icon : 7
			});
		}
		$("#propertyList").val(weights);
	}

	function changeVarietyValues() {
		var weights = '';
		$('#selectVariety option').each(function() {
			if ($(this).is(':selected')) {
				weights += $(this).val() + ",";
			}
		});
		var arr = weights.split(",");
		if (arr.length > 3) {
			layer.alert("报表最多显示两个粮食性质！", {
				icon : 7
			});
		}
		$("#varietyList").val(weights);
	}
</script>
