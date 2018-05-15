<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
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
					<div class="row">
						<div id="errorDiv" class="col-md-12"></div>
						<div class=" col-md-12">
							<font size=4> 接口地址
								http://${prop.WS_IP}:${prop.WS_PORT}/WS/GrainPlatform <br>
								调用方法: saveOrUpdateDate(byte[] jsonData, String checkData, int
								dataType, String orgCode) <br> jsonData=
								"[{wDate:'20161214',wTime:'095726',wTemperature:'11.2',gTemperature:'10.6',
								wHumidity:'72',gHumidity:'62',wCoordinate:'8.1
								8.1 8.5 7.9 8.2 8.2 8.5 8.7 11.2 411.2 8.5 9.3 8.3 10.2 8.2 8.8
								8.4 9.6 11.3 8.1 8.8 8.8 8.7 8.8 8.1 8.2 411.2 411.2 411.2 9.3
								8.8 8.3 8.7 8.2 8.2 8.9 9.5 8.4 9.3 411.2 9.3 8.0 10.1 9.2 9.2
								8.9 8.8 8.3 11.5 8.3 8.3 8.2 8.3 11.2 8.3 8.2 411.2 411.2 411.2
								8.2 9.0 9.5 8.4 8.3 9.5 8.7 9.2 8.4 8.3 411.2 8.5 8.4 8.3 8.5
								10.2 8.5 9.1 8.3 11.5 10.9 8.4 9.3 8.6 11.5 10.0 8.0 411.2 411.2
								411.2 8.2 8.1 9.4 8.5 10.0 8.3 8.2 8.4 11.4 8.5 411.2 8.1 9.3
								8.2 8.3 10.3 8.3 8.8 8.4 11.2 11.0 8.2 8.2 8.4 11.3 9.8 8.1
								411.2 411.2 411.2
								10.9',wDisable:'1',wWarehouse:'33',cjsj:'2016-12-14
								09:57:26'}]".getBytes(); <br> checkData=byte[]长度 <br>
								dataType=4; <br> orgCode=库区编码
							</font>
						</div>
					</div>

				</div>




			</div>
		</div>
		<!--/span-->

	</div>
	<!--/row-->

<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/common/common_code.js">
	
</script>
<script type="text/javascript">
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>
