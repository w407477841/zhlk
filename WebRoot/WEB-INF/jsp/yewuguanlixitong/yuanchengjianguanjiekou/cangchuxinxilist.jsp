<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
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
				<div class="row">
					<div id="errorDiv" class="col-md-12"></div>
					<div class=" col-md-12">
						<font size=4> 接口地址
							http://${prop.WS_IP}:${prop.WS_PORT}/WS/GrainPlatform <br>
							调用方法: saveOrUpdateDate(byte[] jsonData, String checkData, int
							dataType, String orgCode) <br>
							jsonData="[{name:'1122002',code:'',quanZhong:'121',cangKu:'67890',storageID:'3',source:'1000001'},{name:'1122002',code:'',quanZhong:'121',cangKu:'67891',storageID:'3',source:'1000001'}]".getBytes();
							<br> checkData=byte[]长度 <br> dataType=2; <br>
							orgCode=库区编码
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
