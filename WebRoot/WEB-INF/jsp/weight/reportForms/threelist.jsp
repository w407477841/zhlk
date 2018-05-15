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
								<a class="btn btn-primary" href="javascript:void(0)" id="search"
									style="text-shadow: black 5px 3px 3px;"> <i
									class="glyphicon glyphicon-search icon-white"></i> 查询
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
	src="js/system/weight/reportForms/threelist.js"></script>
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
