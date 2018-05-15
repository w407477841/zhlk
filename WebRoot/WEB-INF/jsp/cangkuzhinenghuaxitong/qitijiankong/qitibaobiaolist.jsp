<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<style type="text/css">
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
									<select class="form-control" name="chuanGanQiDataFormMap.location" id="location" data-rel="chosen"
										data-placeholder="粮库地点">
									</select>
								</div>
								<div class="form-group col-md-3">
									<select class="form-control" name="chuanGanQiDataFormMap.warehouse" id="ck" data-rel="chosen"
										data-placeholder="仓号">
									</select>
								</div>
								<div class="form-group col-md-3">
									<input type="text" id="cjsj" name="chuanGanQiDataFormMap.cjsj"
										class="form-control" placeholder="采集时间">
								</div>
							</form>
						</div>
						<div class=" col-md-12">
							<a class="btn btn-primary" href="javascript:void(0)" id="search"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-search icon-white"></i> 查询
							</a> <a class="btn btn-info" href="javascript:void(0)" id="createPDF"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-export icon-white"></i> PDF
							</a>
						</div>
					</div>
				</div>
				<table id="magazineGrid" style="width:100%;height:560px">
				</table>
			</div>
		</div>
	</div>
</div>
<!--/span-->

<script type="text/javascript" src="js/system/cangkuzhinenghuaxitong/qitijiankong/qitibaobiaolist.js"></script>
<script type="text/javascript">
	$('[data-rel="chosen"],[rel="chosen"]').chosen();
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	laydate({
		elem : '#cjsj',
		event : 'focus',
		format :'YYYY-MM-DD hh:mm:ss'
	});
	(function() {
		var rootPath = "${pageContext.servletContext.contextPath}";
		(function location() {
			$("#location").html("");
			$("#location").chosen("destroy");
			new myselect({
				obj_id : "location",
				url : rootPath + "/warehouse/findMap.shtml",
				option_val : [ "wNo" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
				ck();
			}, function() {
				//初始化执行方法

			});
			$("#location").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
			$("#ck").html("");
			$("#ck").chosen("destroy");
			$("#ck").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		})();

		function ck() {
			$("#ck").html("");
			$("#ck").chosen("destroy");
			new myselect({
				obj_id : "ck",
				url : rootPath + "/warehouse/findWareHouseByLocation2.shtml",
				data : {
					"location_id" : $("#location").val()
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
			$("#ck").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});

		}
	})();
</script>
