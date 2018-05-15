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
											<select id="selectProperty" data-rel="chosen" data-placeholder="粮食性质"
												name="reportHarborFormMap.grainProperty" style="width:100%">
												<option value=""></option>
											</select>
									</div>
									<div class="form-group col-md-3">
											<select id="selectVariety" data-rel="chosen" data-placeholder="粮食品种"
												name="reportHarborFormMap.grainVariety" style="width:100%">
												<option value=""></option>
											</select>
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control" id="dateformat"
												name="reportHarborFormMap.addDate" placeholder="收购日期-开始">
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control" id="dateformat1"
												name="reportHarborFormMap.addDateEnd" placeholder="收购日期-结束">
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
								<div class="form-group col-md-3" style="line-height: 34px; font-weight: bold;">
								合计：<span id="totalValue"></span>
								</div>
								<div class="form-group col-md-3" style="line-height: 34px; font-weight: bold;">
								完成金额：<span id="totalpay"></span>
								</div>
								<div class="form-group col-md-3" style="line-height: 34px; font-weight: bold;">
								未完成金额：<span id="notpay"></span>
								</div>
								
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
	src="js/system/weight/reportForms/fivelist.js"></script>
<script type="text/javascript">
laydate({
	elem : '#dateformat',
	event : 'focus'
});
laydate({
	elem : '#dateformat1',
	event : 'focus'
});
$('[data-rel="chosen"],[rel="chosen"]').chosen();
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	
	(function() {
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
			$("#selectProperty").html("");
			$("#selectProperty").chosen("destroy");
			new myselect({
				obj_id:"selectProperty",
				url:rootPath+"/property/findEnable.shtml",
				option_val:["text"],
				option_val_prefix:",",
				option_html:["text"],
				option_html_prefix:","
				
			},function(){
				//给change事件添加方法
			},function(){
				//初始化执行方法
			});
			$("#selectProperty").chosen({
				no_results_text : "未找到此选项!",
				width:"100%"
			});
			$("#selectVariety").html("");
			$("#selectVariety").chosen("destroy");
			new myselect({
				obj_id:"selectVariety",
				url:rootPath+"/variety/findEnableVariety.shtml",
				option_val:["text"],
				option_val_prefix:",",
				option_html:["text"],
				option_html_prefix:","
				
			},function(){
				//给change事件添加方法
			},function(){
				//初始化执行方法
			});
			$("#selectVariety").chosen({
				no_results_text : "未找到此选项!",
				width:"100%"
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
