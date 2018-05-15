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
							<form id="searchForm" name="searchForm">
								<div class="form-group col-md-3">
									<select name="foodStorageProjectFormMap.type" id="type" data-rel="chosen"
										data-placeholder="方案类型" style="width:100%">
										<option value=""></option>
										<option value="0">通风</option>
										<option value="1">熏蒸</option>
										<option value="2">冷却</option>
									</select>
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
								class="glyphicon glyphicon-remove icon-white"></i> 删除
							</a> <a class="btn btn-info" href="javascript:void(0)"
								id="confirm" style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-ok icon-white"></i> 提交审批
							</a> <a class="btn btn-primary" href="javascript:void(0)"
								id="overview" style="text-shadow: black 5px 3px 3px;"> <i
								class="glyphicon glyphicon-eye-open icon-white"></i> 查看未通过原因
							</a> <a class="btn btn-info" href="javascript:void(0)"
							id="print" style="text-shadow: black 5px 3px 3px;"> <i
							class="fa fa-print"></i> 打印
						</a>
						</div>
					</div>
				</div>
				<table id="magazineGrid" style="width:100%;height:600px">
				</table>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!--/row-->
<div id="back" style="display: none">
	<textarea class="" id="intext"
		style="margin: 5%;width: 90%;height: 70%" disabled="disabled"></textarea>
</div>

<script type="text/javascript" src="js/LodopFuncs.js">
</script>
<script type="text/javascript"
	src="js/system/weight/print/steamApplyPrint.js"></script>
<script type="text/javascript"
	src="js/system/yewuguanlixiytong/cunchuguanli/chuliangguanli/chuliangzuoyeguanli/project.js"></script>
<script type="text/javascript">
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	$('[data-rel="chosen"],[rel="chosen"]').chosen();
</script>
