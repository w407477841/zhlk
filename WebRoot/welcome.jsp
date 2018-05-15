<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<style type="text/css">
#container {
	height: 450px;
	width: 100%;
}

.mapcontent {
	width: 400px;
	height: 300px;
}

.data_info {
	height: 250px;
	width: 100%;
}

.link_info {
	height: 50px;
	width: 100%;
	font-size: 20px;
}

.no_padding {
	padding-left: 0px;
	padding-right: 0px;
	padding-top: 0px;
	padding-bottom: 0px;
}
</style>
<div id="content" class="col-lg-6 col-sm-6" style="padding-left: 0px;">
	<!-- content starts -->
	<div class="row">
		<div class="box col-md-12" style="padding: 0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-tint"></i>&nbsp;仓内气体监测
					</h2>
					<div class="box-icon">
						<a href="javascript:void(0)"
							class="btn btn-setting btn-round btn-default"><i
							class="glyphicon glyphicon-cog"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-minimize btn-round btn-default"><i
							class="glyphicon glyphicon-chevron-up"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-close btn-round btn-default"><i
							class="glyphicon glyphicon-remove"></i> </a>
					</div>
				</div>
				<div class="box-content no_padding" id="page">
					<table id="magazineGridjc" style="width:100%;height:450px;">
					</table>

				</div>
			</div>
		</div>
		<!--/span-->

	</div>
	<!--/row-->

</div>

<div class="col-lg-6 col-sm-6" style="padding-right: 0px;">
	<div class="row">
		<div class="box col-md-12" style="padding: 0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-flash"></i> 气体报警
					</h2>

					<div class="box-icon">
						<a href="javascript:void(0)"
							class="btn btn-setting btn-round btn-default"><i
							class="glyphicon glyphicon-cog"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-minimize btn-round btn-default"><i
							class="glyphicon glyphicon-chevron-up"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-close btn-round btn-default"><i
							class="glyphicon glyphicon-remove"></i> </a>
					</div>
				</div>
				<div class="box-content no_padding" id="page">
					<table id="magazineGridbj" style="width:100%;height:450px;">
					</table>
				</div>
			</div>
		</div>
		<!--/span-->
	</div>
	<!--/row-->
</div>

<div class="col-lg-6 col-sm-6" style="padding-left: 0px;">
	<div class="row">
		<div class="box col-md-12" style="padding: 0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-inbox"></i> 库存管理
					</h2>

					<div class="box-icon">
						<a href="javascript:void(0)"
							class="btn btn-setting btn-round btn-default"><i
							class="glyphicon glyphicon-cog"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-minimize btn-round btn-default"><i
							class="glyphicon glyphicon-chevron-up"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-close btn-round btn-default"><i
							class="glyphicon glyphicon-remove"></i> </a>
					</div>
				</div>
				<div class="box-content no_padding" id="page">
					<table id="magazineGridkc" style="width:100%;height:450px;">
					</table>
				</div>
			</div>
		</div>
		<!--/span-->
	</div>
	<!--/row-->
</div>

<div class="col-lg-6 col-sm-6" style="padding-right: 0px;">
	<div class="row">
		<div class="box col-md-12" style="padding: 0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-th"></i> 库存统计
					</h2>

					<div class="box-icon">
						<a href="javascript:void(0)"
							class="btn btn-setting btn-round btn-default"><i
							class="glyphicon glyphicon-cog"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-minimize btn-round btn-default"><i
							class="glyphicon glyphicon-chevron-up"></i> </a> <a
							href="javascript:void(0)"
							class="btn btn-close btn-round btn-default"><i
							class="glyphicon glyphicon-remove"></i> </a>
					</div>
				</div>
				<div class="box-content no_padding" id="page">
					<div id="container">
					<div style="height:50px;width: 100%; line-height:50px; text-align: right; padding-right: 10px;padding-left: 10px;">
					 <div style="height:50px;width: 50%; line-height:50px; text-align: left; float: left;">
					 <span id="totalWeight"></span>
					 </div>
					 <div style="height:50px;width: 50%; line-height:50px; text-align: right; float: left;">
					  <button class="btn btn-info" id="pieId" onclick="show_Pie()">饼图</button>
					  <button class="btn btn-default" id="barId" onclick="show_Bar()">柱图</button>					 
					 </div>
					 
					  </div>
						<div style="height:400px;width: 100%; padding-left: 10px; padding-right: 10px;" id="Chart"></div>
					</div>
				</div>
			</div>
		</div>
		<!--/span-->
	</div>
	<!--/row-->
</div>
<script type="text/javascript" src="js/system/role/list.js"></script>
<script type="text/javascript" src="js/system/welcome.js"></script>
<script type="text/javascript">
	$('.btn-close').click(function(e) {
		e.preventDefault();
		$(this).parent().parent().parent().fadeOut();
	});
	$('.btn-minimize').click(
			function(e) {
				e.preventDefault();
				var $target = $(this).parent().parent().next('.box-content');
				if ($target.is(':visible'))
					$('i', $(this)).removeClass('glyphicon-chevron-up')
							.addClass('glyphicon-chevron-down');
				else
					$('i', $(this)).removeClass('glyphicon-chevron-down')
							.addClass('glyphicon-chevron-up');
				$target.slideToggle();
			});

	$(".panel-body-noheader").css("border-top-width", 0);
	$(".panel-body").css("border-style", "none");
	//$(".datagrid-view").css("height","419");
	//$(".datagrid-pager table tbody tr td").css("padding","0 0");
	
	//获取数据
	var txt=[],total=[],obj=[];
	$.ajax({
	  url:"${pageContext.servletContext.contextPath}/store/findCurrentStorageByCategory.shtml",
	  type:"POST",
	  async:true,
	  success:function(data){
	  data = eval(data);
	  var totalWeight = 0;
	  for(var i = 0;i<data.length;i++){
	    txt[i] = data[i].text;
	    total[i] = data[i].total;
	    totalWeight+=data[i].total;
	    var temp = {name:data[i].text,value:data[i].total};
	    obj[i] = temp;
	  } 
	  $("#totalWeight").html("总库存量："+totalWeight+"kg");
	  piechart();
	  }
	});
	// 基于准备好的dom，初始化echarts实例
	function piechart(){
	var chart = document.getElementById('Chart');
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
		legend : {
			orient : 'vertical',
			left : 'left',
			data : txt
		},
		series : [ {
			name : '占比',
			type : 'pie',
			radius : '55%',
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
	function barchart(){
	// 基于准备好的dom，初始化echarts实例
	var chart = document.getElementById('Chart');
	chart.innerHTML='';
		var barChart = echarts.init(chart);
		barChart.innerHTML='';
		// 指定图表的配置项和数据
		var barOption = {
			title : {  //设置图标标题
				text : '粮食品种占比',
				 x:'center'
			},
			tooltip : {},
			legend : {  //图例
			    orient : 'vertical',
			    left : 'left',
				data : [ '占比' ]
			},
		   grid: {
			        left: '1%',
			        right: '1%',
			        bottom: '1%',
			        containLabel: true
			    },
			xAxis : {  //x轴坐标名称
				data : txt
			},
			yAxis : {},
			series : [ {
				name : '占比',
				type : 'bar',
				data : total,
				itemStyle: {
		                        normal: {
		                            color: '#4F94CD'
		                        }
		                    }
			} ]
			
		};
		// 使用刚指定的配置项和数据显示图表。
		barChart.setOption(barOption);
	}
</script>
<script type="text/javascript">
 function show_Pie(){
  piechart();
  $("#pieId").attr("class","btn btn-info");
  $("#barId").attr("class","btn btn-default");
 }
 function show_Bar(){
  barchart();
  $("#pieId").attr("class","btn btn-default");
  $("#barId").attr("class","btn btn-info");
 }
</script>
