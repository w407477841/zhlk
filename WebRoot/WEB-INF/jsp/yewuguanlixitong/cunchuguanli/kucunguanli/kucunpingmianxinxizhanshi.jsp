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
				<div class="row" id="cangku"
					style="position:relative;background:url(img/cangku/1000001.jpg)	;background-size:100% 100%;height:700px ">
				</div>
			</div>
		</div>
	</div>
	<!--/span-->




<script type="text/javascript">
	
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>