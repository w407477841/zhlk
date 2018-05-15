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
							<form role="form" id="searchForm" name="searchForm" action=""
								method="post">
								<div class="col-md-12">
									<div class="form-group col-md-3">
										<input type="text" class="form-control"
											name="ziJinBaoBiaoFormMap.bbName" value="" placeholder="货主姓名">
									</div>
									<div class="form-group col-md-3">
										<select class="form-control" id="selectcategory"
											name="ziJinBaoBiaoFormMap.bbAssortment" data-rel="chosen"
											data-placeholder="粮食品种">
										</select>
									</div>
									<div class="form-group col-md-3">
										<select class="form-control" id="selectvariety"
											name="ziJinBaoBiaoFormMap.bbQuality" data-rel="chosen"
											data-placeholder="粮食性质">
										</select>
									</div>
									<div class="form-group col-md-3">
										<div class="col-md-2 div_label"></div>
										<div class="col-md-10"></div>
									</div>
									<div class="form-group col-md-3">
										<input type="text" id="start" class="form-control"
											name="ziJinBaoBiaoFormMap.beginTime" value=""
											placeholder="开始时间">
									</div>
									<div class="form-group col-md-3">
										<input type="text" id="start1" class="form-control"
											name="ziJinBaoBiaoFormMap.endTime" value=""
											placeholder="截至时间">
									</div>
								</div>
							</form>
						</div>
						<div class="col-md-12">
							<a class="btn btn-primary" href="javascript:void(0)" id="search"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-search icon-white"></i> 查询
							</a> <a class="btn btn-info" href="javascript:void(0)" id="createPDF"
								style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-export icon-white"></i> PDF
							</a> <a class="btn btn-info" href="javascript:void(0)"
								id="createExcel" style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-export icon-white"></i> Excel
							</a> <a class="btn btn-info" href="javascript:void(0)"
								id="createWord" style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-export icon-white"></i> Word
							</a>

						</div>
					</div>
					<div id="htmlfile">
						<iframe id="pageIndex" src="" width="100%" height="500px;"
							style="border: none;"></iframe>
					</div>
				</div>
			</div>
		</div>
		<!--/span-->

	</div>
	<!--/row-->
</div>
<script type="text/javascript"
	src="js/system/yewuguanlixiytong/zijinguankong/zijinbaobiaolist.js"></script>
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
		$("#selectcategory").html("");
		$("#selectcategory").chosen("destroy");
		new myselect({
			obj_id : "selectcategory",
			url : rootPath + "/variety/findEnableVariety.shtml",
			option_val : [ "id" ],
			option_val_prefix : ",",
			option_html : [ "text" ],
			option_html_prefix : ","

		}, function() {
			//给change事件添加方法
		}, function() {
			//初始化执行方法
		});
		$("#selectcategory").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});

		$("#selectvariety").html("");
		$("#selectvariety").chosen("destroy");
		new myselect({
			obj_id : "selectvariety",
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
		$("#selectvariety").chosen({
			no_results_text : "未找到此选项!",
			width : "100%"
		});
	})();
</script>
