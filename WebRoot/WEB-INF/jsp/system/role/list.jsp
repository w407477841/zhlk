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
							<input type="text" name="roleFormMap.name" class="form-control" value=""
								placeholder="角色名称">
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
						</a> <a class="btn btn-primary" href="javascript:void(0)" id="editRes"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-user icon-white"></i> 修改权限
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

<script type="text/javascript" src="js/system/role/list.js"></script>
<script type="text/javascript">
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>
