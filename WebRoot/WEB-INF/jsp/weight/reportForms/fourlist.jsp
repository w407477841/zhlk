<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 38px;
}
</style>
	<!-- content starts -->
	<div class="row">
		<div class="box col-md-12" style="padding-left: 0px; padding-right: 0px;">
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
								<form id="searchForm" name="searchForm" method="post">
									<div class="form-group col-md-3">
											<select id="selectLocation" data-rel="chosen"
												data-placeholder="粮库地点" name="reportHarborFormMap.wlId"
												style="width:100%">
												<option value=""></option>
											</select>
									</div>
									<div class="form-group col-md-3">
											<select id="selectCk" data-rel="chosen" data-placeholder="仓号"
												name="reportHarborFormMap.wId" style="width:100%">
												<option value=""></option>
											</select>
									</div>
									
									<div class="form-group col-md-3">
											<input type="text" class="form-control"
												name="reportHarborFormMap.bId" placeholder="单据号">
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control"
												name="reportHarborFormMap.IDCard" placeholder="身份证号">
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control"
												name="reportHarborFormMap.userName" placeholder="单位">
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control"
												name="reportHarborFormMap.phoneNumber" placeholder="手机号码">
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control"
												name="reportHarborFormMap.shipId" placeholder="车船号">
									</div>
									<div class="form-group col-md-3">
											<select data-rel="chosen" data-placeholder="款型"
												name="reportHarborFormMap.inOrOut" style="width:100%">
												<option value="2">付款</option>
												<option value="1">收款</option>
											</select>
									</div>
								</form>
								</div>
								<div class="col-md-12">
								<div class="form-group col-md-3">
								<a class="btn btn-primary" href="javascript:void(0)" id="search"
									style="text-shadow: black 5px 3px 3px;"> <i
									class="glyphicon glyphicon-search icon-white"></i> 查询
								</a>
								</div>
								
							</div>
						</div>
					</div>
					<table id="magazineGrid" style="width:100%;height:580px">
					</table>
				</div>
			</div>
		</div>
		<!--/span-->
	</div>
	<!--/row-->
<script type="text/javascript"
	src="js/system/weight/reportForms/fourlist.js"></script>
<script type="text/javascript">

$('[data-rel="chosen"],[rel="chosen"]').chosen();
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	
	(function() {
		var rootPath = "${pageContext.servletContext.contextPath}";
		//初始化库点下拉框

		(function location() {
			$("#selectLocation").html("");
			$("#selectLocation").chosen("destroy");
			new myselect({
				obj_id : "selectLocation",
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
			$("#selectLocation").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		})();

		function ck() {
			$("#selectCk").html("");
			$("#selectCk").chosen("destroy");
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
			}, function() {
				//初始化执行方法
			});
			$("#selectCk").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});

		}
	})();
</script>
