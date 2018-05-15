<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
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
						<form id="searchForm"
							name="searchForm">
							<div class="form-group col-md-3">
							<input type="text" class="form-control"
								name="chuKuShenQingFormMap.gsaApplyBill" value=""
								placeholder="申请单编号">
								</div>
						</form>
						</div>
						<div class=" col-md-12">
						<a class="btn btn-primary" href="javascript:void(0)" id="search"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-search icon-white"></i> 查询
						</a> <a class="btn btn-info" href="javascript:void(0)" id="addFun"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-plus icon-white"></i> 新增
						</a> <a class="btn btn-warning" href="javascript:void(0)" id="editFun"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-edit icon-white"></i> 修改
						</a> <a class="btn btn-danger" href="javascript:void(0)" id="deleFun"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-remove icon-white"></i> 删除
						</a> <a class="btn btn-primary" href="javascript:void(0)"
							id="approveFun" style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-ok icon-white"></i> 提交审批
						</a> <a class="btn btn-warning" href="javascript:void(0)"
							id="throughFun" style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-eye-open icon-white"></i> 查看审批意见
						</a> <a class="btn btn-primary" href="javascript:void(0)" id="lookFun"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-eye-open icon-white"></i> 查看信息
						</a> 
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
	src="js/system/yewuguanlixiytong/cunchuguanli/churukuguanli/chukushenqingyushenpi/chukushenqing.js"></script>
<script type="text/javascript">
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>
