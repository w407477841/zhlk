<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<style>
.form-control {
	padding: 0px 12px
}
.chosen-container-single .chosen-single {
	height: 38px;
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
							<div class="form-group col-md-3">
									<select id="selectLocation" data-rel="chosen"
											data-placeholder="粮库地点"
											name="FoodStorageColdFormMap.wlNo" style="width:100%">
											<option value=""></option>
										</select>
								</div>
								<div class="form-group col-md-3">
										<select class="form-control" id="warehouse"
											name="FoodStorageColdFormMap.wNo" data-rel="chosen"
											data-placeholder="仓号">
										</select>
								</div>
								<div class="form-group col-md-3">
									<input id="start" type="text" class="form-control "
										name="FoodStorageColdFormMap.times" placeholder="开始时间">
								</div>
								<div class="form-group col-md-3">
									<input id="start1" type="text" class="form-control "
										name="FoodStorageColdFormMap.timee" placeholder="截止时间">
								</div>
							</form>
						</div>
						<div class=" col-md-12">
							<a class="btn btn-primary" href="javascript:void(0)" id="search"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-search icon-white"></i> 查询
							</a> <a class="btn btn-info" href="javascript:void(0)" id="add"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-plus icon-white"></i> 新增
							</a> <a class="btn btn-warning" href="javascript:void(0)" id="edit"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-edit icon-white"></i> 修改
							</a> <a class="btn btn-danger" href="javascript:void(0)" id="del"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-removesearch icon-white"></i> 删除
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
	src="js/system/yewuguanlixiytong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/zuoyejilu/cold.js"></script>
<script type="text/javascript">
	laydate({
		elem : '#start',
		event : 'focus'
	});
	laydate({
		elem : '#start1',
		event : 'focus'
	});
	
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	$('[data-rel="chosen"],[rel="chosen"]').chosen();
	(function() {
		$("#selectLocation").html("");
		$("#selectLocation").chosen("destroy");
		new myselect({
			obj_id : "selectLocation",
			url : rootPath + "/warehouse/findMap.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "wName" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
			$("#warehouse").html("");
			$("#warehouse").chosen("destroy");
			ck();
			$("#warehouse").chosen({
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

	})();
	function ck() {
		new myselect({
			obj_id : "warehouse",
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
		}, function() {
			//初始化执行方法
		});
	}
</script>
