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
						<form>
						 <div class="form-group col-md-3">
							<input type="text" class="form-control" id="maxTemp"
								value="${alarm }" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
								onblur="validFloat(this)" placeholder="请输入：报警最高温度">
								</div>
						</form>
						</div>
						<div class=" col-md-12">
						<a class="btn btn-info" href="javascript:void(0)" id="setFun"
							style="text-shadow: black 5px 3px 3px;"> <i
							class="glyphicon glyphicon-ok icon-white"></i> 设置
						</a>
						</div>
						</div>
					</div>
					<div class="alert alert-info">
					<div class="row">
						<div class=" col-md-12">
						<form id="searchForm">
						<div class="form-group col-md-3">
							<input type="text" class="form-control"
								name="temperatureAlarmFormMap.wlName" placeholder="请输入：粮库地点">
								</div>
								<div class="form-group col-md-3">
							<input type="text" class="form-control"
								name="temperatureAlarmFormMap.wName" placeholder="请输入：仓号">
								</div>
						</form>
						</div>
						<div class=" col-md-12">
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
	src="js/system/cangkuzhinenghuaxitong/liangqingjiankong/wendubaojingshezhilist.js"></script>
<script type="text/javascript">
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>