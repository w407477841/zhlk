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
											<input type="text" class="form-control" id="bId"
												name="reportHarborFormMap.bId" placeholder="单据号">
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control" id="dateformat" id="beginDate"
												name="reportHarborFormMap.beginDate" placeholder="称重日期-开始">
									</div>
									<div class="form-group col-md-3">
											<input type="text" class="form-control" id="dateformat1" id="endDate"
												name="reportHarborFormMap.endDate" placeholder="称重日期-结束">
									</div>
									<div class="form-group col-md-3">
											<select data-rel="chosen" data-placeholder="出/入库" id="inOrOut"
												name="reportHarborFormMap.inOrOut" style="width:100%">
												<option></option>
												<option value="2">入库</option>
												<option value="1">出库</option>
											</select>
									</div>
								</form>
								</div>
								<div class="col-md-3">
								<a class="btn btn-primary" href="javascript:void(0)" id="search"
									style="text-shadow: black 5px 3px 3px;"> <i
									class="glyphicon glyphicon-search icon-white"></i> 查询
								</a> <a class="btn btn-info" href="javascript:void(0)" id="print"
									style="text-shadow: black 5px 3px 3px;"> <i
									class="fa fa-print"></i> 打印预览
								</a>
								</div>
								<div class="form-group col-md-3" style="line-height: 34px; font-weight: bold;">
								总毛重：<span id="gross"></span>
								</div>
								<div class="form-group col-md-3" style="line-height: 34px; font-weight: bold;">
								总皮重：<span id="tare"></span>
								</div>
								<div class="form-group col-md-3" style="line-height: 34px; font-weight: bold;">
								总重量：<span id="total"></span>
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
	src="js/system/weight/reportForms/sevenlist.js"></script>
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
</script>
