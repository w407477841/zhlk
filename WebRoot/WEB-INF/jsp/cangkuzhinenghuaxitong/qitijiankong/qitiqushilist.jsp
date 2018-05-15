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
					<div class="row" id="cangku"
						style="position:relative;background:url(img/cangku/${param.name}.jpg)	;background-size:100% 100%;height:500px ">
					</div>
				</div>
			</div>
		</div>
		<!--/span-->

	</div>
	<!--/row-->
<script type="text/javascript"
	src="js/system/cangkuzhinenghuaxitong/qitijiankong/qitiqushilist.js"></script>
<script type="text/javascript">
var lis = $('#daohang_ul', window.parent.document);
$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	$
			.ajax({
				type : "POST",
				data : {
					"location_id" : "${param.name}"

				},
				url : rootPath + '/shipindianwei/findALlByCid.shtml',
				dataType : 'json',
				success : function(json) {
					if (json) {
						var cangku = $("#cangku");
						var dangqian = json;
						for (var i = 0; i < dangqian.length; i++) {
							var ip_Num = dangqian[i].ipNum;
							var ip = dangqian[i].ip;
							var port = dangqian[i].port;
							var userName = dangqian[i].userName;
							var password = dangqian[i].password;
							$("<div>")
									.css("width", "20px")
									.css("height", "20px")
									.css("background",
											"url(${pageContext.servletContext.contextPath}/img/cangku/jk.png)")
									.css("background-size", "100% 100%")
									.css("color", "white")
									.attr("data-id", "shipin" + i)
									.css("cursor", "pointer")
									.mouseover(
											function(event) {
												$("#" + $(this).attr("data-id"))
														.show();

											})
									.mouseout(
											function(event) {
												$("#" + $(this).attr("data-id"))
														.hide();
											})
									.click(
											function() {
												window
														.open(
																rootPath
																		+ '/liangku/viewjiankong.shtml?name=${param.name}&ipNum='
																		+ $(
																				this)
																				.attr(
																						"data-ipNum")
																		+ '&ip='
																		+ $(
																				this)
																				.attr(
																						"data-ip")
																		+ '&port='
																		+ $(
																				this)
																				.attr(
																						"data-port")
																		+ '&userName='
																		+ $(
																				this)
																				.attr(
																						"data-userName")
																		+ '&password='
																		+ $(
																				this)
																				.attr(
																						"data-password"),
																'',
																'height=600,width=1000,scrollbars=yes,status =yes')
												/*
													pageii = layer.open({
														title : "<h5><i class='glyphicon glyphicon-link'></i>监控点位<h5>",
														type : 2,
														maxmin :true,
														area : [ "850px", "600px" ],
														content : rootPath + '/liangku/viewjiankong.shtml?name=${param.name}&ipNum='+$(this).attr("data-ipNum")+'&ip='+$(this).attr("data-ip")+'&port='+$(this).attr("data-port")+'&userName='+$(this).attr("data-userName")+'&password='+$(this).attr("data-password")
													});*/
											}).attr("data-ipNum", ip_Num).attr(
											"data-ip", ip).attr("data-port",
											port).attr("data-userName",
											userName).attr("data-password",
											password).css("position",
											"absolute").css("left",
											dangqian[i].sLeft).css("top",
											dangqian[i].top).appendTo(cangku);
							$("<div>").attr("id", "shipin" + i).css("position",
									"absolute").css(
									"left",
									(dangqian[i].sLeft.split("%")[0] * 1 + 2)
											+ "%").css("top", dangqian[i].top)
									.css("display", "none").html(
											"<h3 class=\"animated rubberBand\">"
													+ dangqian[i].name
													+ "</h3>").appendTo(cangku);
						}

					}
				}
			});
</script>
