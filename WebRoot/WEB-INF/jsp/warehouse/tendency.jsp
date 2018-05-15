<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

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
						<form id="form" name="form" method="post"
							action="${pageContext.servletContext.contextPath}/warehouse/tendency.shtml">
							<div class="form-group col-md-3">
								<select id="selectLocation" data-rel="chosen"
									data-placeholder="粮库地点" name="warehouseInfoFormMap.wlID"
									style="width:100%">
									<option value=""></option>
								</select>
							</div>
							<div class="form-group col-md-3">
								<select id="selectCk" data-rel="chosen" data-placeholder="仓号"
									name="warehouseInfoFormMap.wID" style="width:100%">
									<option value=""></option>
								</select>
							</div>

							<div class="form-group col-md-3">
								<input type="text" class="form-control" id="dateformat"
									name="warehouseInfoFormMap.beginDate" placeholder="开始时间">
							</div>
							<div class="form-group col-md-3">
								<input type="text" class="form-control" id="dateformat1"
									name="warehouseInfoFormMap.endDate" placeholder="结束时间">
							</div>

							<div class="form-group col-md-12">
								<input type="submit" class="btn btn-info bt-search" value="查询">
							</div>
						</form>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
	<div class="col-md-12">
		<div
			style="height:400px;width: 100%; padding-left: 10px; padding-right: 10px;"
			id="lineChart"></div>
	</div>
</div>
<!--/row-->

<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/common/common_code.js">
	
</script>
<script type="text/javascript">
	laydate({
		elem : '#dateformat',
		event : 'focus'
	});
	laydate({
		elem : '#dateformat1',
		event : 'focus'
	});
	$('[data-rel="chosen"],[rel="chosen"]').chosen();
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
	(function() {
		var rootPath = "${pageContext.servletContext.contextPath}";
		//初始化库点下拉框

		(function location() {
			$("#selectLocation").html("");
			$("#selectLocation").chosen("destroy");
			new myselect({
				obj_id : "selectLocation",
				url : rootPath + "/warehouse/findMap.shtml",
				option_val : [ "wNo" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","

			}, function() {
				//给change事件添加方法
				ck();
			}, function() {
				//初始化执行方法

			});
			$("#selectLocation").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});
		})();

		function ck() {
			$("#selectCk").html("");
			$("#selectCk").chosen("destroy");
			new myselect({
				obj_id : "selectCk",
				url : rootPath + "/warehouse/findWareHouseByLocation2.shtml",
				data : {
					"location_id" : $("#selectLocation").val()
				},
				option_val : [ "id" ],
				option_val_prefix : ",",
				option_html : [ "wName" ],
				option_html_prefix : ","
			}, function() {
				//给change事件添加方法
			}, function() {
				//初始化执行方法
			});
			$("#selectCk").chosen({
				no_results_text : "未找到此选项!",
				width : "100%"
			});

		}
	})();
	$("#form").validate({
		submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
			ly.ajaxSubmit(form, {//验证新增是否成功
				type : "post",
				dataType : "json",
				success : function(data) {
					if (data == null) {
						layer.alert('暂无查询数据！', {icon:5});
					} else {
						linechart(data);
					}
				},
				error : function(data) {
					layer.alert('暂无查询数据！', {icon:5});
				}
			});
		},
		rules : {
		},
		messages : {
		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
		},
		success : function(label) {// 验证通过后
		}
	});
</script>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/js/echarts.js">
	
</script>
<script type="text/javascript">
	function linechart(data) {
		var chart = document.getElementById('lineChart');
		chart.innerHTML = '';
		var lineChart = echarts.init(chart);

		// 指定图表的配置项和数据
		option = {
			title : {
				text : '粮温趋势图',
				subtext : '多形式展示'
			},
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				data : [ '最高温度', '最低温度', '仓外温度', '仓内温度' ]
			},
			toolbox : {
				show : true,
				feature : {
					dataZoom : {
						yAxisIndex : 'none'
					},
					dataView : {
						readOnly : false
					},
					magicType : {
						type : [ 'line', 'bar' ]
					},
					restore : {},
					saveAsImage : {}
				}
			},
			xAxis : {
				type : 'category',
				boundaryGap : false,
				data : eval(data.cjsj)
			},
			yAxis : {
				type : 'value',
				axisLabel : {
					formatter : '{value} °C'
				}
			},
			series : [ {
				name : '最高温度',
				type : 'line',
				data : eval(data.maxTem),
				markPoint : {
					data : [ {
						type : 'max',
						name : '最大值'
					}, {
						type : 'min',
						name : '最小值'
					} ]
				},
				markLine : {
					data : [ {
						type : 'average',
						name : '平均值'
					} ]
				}
			}, {
				name : '最低温度',
				type : 'line',
				data : eval(data.minTem),
				markPoint : {
					data : [ {
						type : 'max',
						name : '最大值'
					}, {
						type : 'min',
						name : '最小值'
					} ]
				},
				markLine : {
					data : [ {
						type : 'average',
						name : '平均值'
					} ]
				}
			}, {
				name : '仓外温度',
				type : 'line',
				data : eval(data.outTem),
				markPoint : {
					data : [ {
						type : 'max',
						name : '最大值'
					}, {
						type : 'min',
						name : '最小值'
					} ]
				},
				markLine : {
					data : [ {
						type : 'average',
						name : '平均值'
					} ]
				}
			}, {
				name : '仓内温度',
				type : 'line',
				data : eval(data.inTem),
				markPoint : {
					data : [ {
						type : 'max',
						name : '最大值'
					}, {
						type : 'min',
						name : '最小值'
					} ]
				},
				markLine : {
					data : [ {
						type : 'average',
						name : '平均值'
					} ]
				}
			} ]
		};
		lineChart.setOption(option);
	}
</script>


