<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<style>
input[type=file] {
	position: absolute;
	right: 0px;
	top: 0px;
	opacity: 0;
	filter: alpha(opacity = 0);
	font-size: 100px;
	width: 40px;
	height: 68px
}

#btnupload {
	position: relative;
	height: 40px;
	width: 68px;
}
</style>
	<!-- content starts -->
	<div class="row">
		<div class="box col-md-6" style="padding-left: 0px;">
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
								<form role="form" id="searchCodeForm" name="searchForm">
									<input type="text" class="form-control" name="codeFormMap.name"
										value="" placeholder="名称">
								</form>
							</div>
							<div class=" col-md-12">
								<a class="btn btn-primary" href="javascript:void(0)"
									id="searchCode" style="text-shadow: black 5px 3px 3px;"> <i
									class="glyphicon glyphicon-search icon-white"></i> 查询
								</a> <a class="btn btn-info" href="javascript:void(0)"
									id="codeAddFun" style="text-shadow: black 5px 3px 3px;"> <i
									class="glyphicon glyphicon-plus icon-white"></i> 添加
								</a>
							</div>
						</div>
					</div>

					<table id="codeGrid" style="width:100%;height:600px">
					</table>
				</div>
			</div>
		</div>
		<!--/span-->

		<div class="box col-md-6" style="padding-right: 0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-list"></i> <span id="pageTitle1"></span>
					</h2>
				</div>
				<div class="box-content" id="page">
					<div class="alert alert-info">
						<form class="form-inline" role="form" id="searchCodeItemForm"
							name="searchForm">
							<input type="hidden" id="codeid" name="codeItemFormMap.codeid"
								value="">
						</form>
						<a class="btn btn-info" href="javascript:void(0)" id="addFun"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-plus icon-white"></i> 添加
						</a> <a class="btn btn-primary" href="javascript:void(0)"
							id="btnupload" style="text-shadow: black 5px 3px 3px;">
							<form id="uploadCodeForm"
								action="${pageContext.request.contextPath}/code/uploadCodeItem.shtml"
								method="post" enctype="multipart/form-data">
								<i class="glyphicon glyphicon-import icon-white"></i> 导入 <input
									type="file" id="file" name="file" />
							</form>
						</a>
						<div id="filename"></div>
					</div>


					<table id="itemGrid" style="width:100%;height:600px">
					</table>
				</div>
			</div>
		</div>
		<!--/span-->


	</div>
	<!--/row-->

<script type="text/javascript" src="js/system/code/list.js"></script>
<script type="text/javascript" src="js/system/code/itemlist.js"></script>
<script type="text/javascript">
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
$("#pageTitle1").html($(lis).children("li:last-child").children("a").html());
	CommnUtil.initUpload("file", "filename", "uploadCodeForm", "itemGrid");
</script>


