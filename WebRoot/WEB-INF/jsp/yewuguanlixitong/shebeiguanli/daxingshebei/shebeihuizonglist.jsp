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
						<form id="searchForm" action=""
							name="searchForm" method="post">
							<div class="form-group col-md-3">
							<input type="text" class="form-control"
								name="daXingSheBeiFormMap.leName" value="" placeholder="设备名称">
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
						</a> <a class="btn btn-info" href="javascript:void(0)"
							id="createExcel" style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-export icon-white"></i> Excel
						</a> <a class="btn btn-info" href="javascript:void(0)" id="createWord"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-export icon-white"></i> Word
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
	src="js/system/yewuguanlixiytong/shebeiguanli/daxingshebei/shebeihuizonglist.js"></script>
<script type="text/javascript">
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>
