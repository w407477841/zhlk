<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<!-- content starts -->
<div class="row">
	<div class="box col-md-12"
		style="padding-left: 0px; padding-right: 0px;">
		<div class="box-inner" style="height: 100%">
			<div class="box-header well" data-original-title="">
				<h2>
					<i class="glyphicon glyphicon-list"></i> <span id="pageTitle"></span>
				</h2>
				<form id="searchForm" action="#">
					<input type="hidden" name="source" value="${param.source}">
				</form>
			</div>
			<div class="box-content" id="page">
				<table id="magazineGrid" style="width:100%;height:310px">
				</table>
			</div>
			<div class="form-group col-md-6">
			<div style=";height: 300px;" id="l_bott" class="l_bott"></div>
			</div>
			<div class="form-group col-md-6">
			<div style=";height: 300px;" id="r_bott" class="r_bott"></div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<script type="text/javascript" src="js/liangku/storageInfo.js">
</script>
<script type="text/javascript">
	var lis = $('#daohang_ul', window.parent.document);
	$("#pageTitle").html($(lis).children("li:last-child").children("a").html());
</script>
<script type="text/javascript">
	var source = "${param.source}";
	$(function() {
		$.ajax({
			url : rootPath + "/kcxx/queryChart.shtml",
			type : "post",
			data : {
				"source" : source
			},
			success : function(rs) {
				if (rs.success) {
					if (typeof rs.map0 == "Array") {
						rs.map0.map(function(item) {
							return {
								name : item.name,
								y : item[y] * 1
							};
						});
					}
					if (typeof rs.map1 == "Array") {
						rs.map1.map(function(item) {
							return {
								name : item.quanZhong,
								y : item[y] * 1
							};
						});
					}
					piechart(rs.map0);
					piechart1(rs.map1);
					
				}
			}
		});

	});
	function piechart(data){
		var txt=[],obj=[];
		for(var i = 0;i<data.length;i++){
		    txt[i] = data[i].name;
		    var temp = {name:data[i].name,value:data[i].y};
		    obj[i] = temp;
		  } 
		var chart = document.getElementById('l_bott');
		chart.innerHTML='';
		var pieChart = echarts.init(chart);
		// 指定图表的配置项和数据
		pieOption = {
			title : {
				text : '粮食品种占比',
				 x:'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			series : [ {
				name : '占比',
				type : 'pie',
				radius : '70%',
				center : [ '50%', '60%' ],
				data : obj,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
		// 使用刚指定的配置项和数据显示图表。
		pieChart.setOption(pieOption);
		}
	function piechart1(data){
		var txt=[],obj=[];
		for(var i = 0;i<data.length;i++){
		    txt[i] = data[i].name;
		    var temp = {name:data[i].name,value:data[i].y};
		    obj[i] = temp;
		  } 
		var chart = document.getElementById('r_bott');
		chart.innerHTML='';
		var pieChart = echarts.init(chart);
		// 指定图表的配置项和数据
		pieOption = {
			title : {
				text : '粮食性质占比',
				 x:'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			series : [ {
				name : '占比',
				type : 'pie',
				radius : '70%',
				center : [ '50%', '60%' ],
				data : obj,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
		// 使用刚指定的配置项和数据显示图表。
		pieChart.setOption(pieOption);
		}
</script>
