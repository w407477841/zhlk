<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
    <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-facetime-video"></i>能耗趋势</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    
    <div class="box-content" id="page">
    <div class="alert alert-info"> 
    <form class="form-inline" role="form" id="searchForm"
			name="searchForm">
			<lable> 起始时间：
			<input type="text" id="time1" value="" placeholder="起始时间">
			</lable>
			<lable> 起始时间：
			<input type="text" id="time2" value="" placeholder="结束时间">
			</lable>
    </form>
<div class="alert alert-warning alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <strong>默认查询</strong> 最近30天按日期统计能耗数据。 <br>
  	按月份/按季度:默认查询 今年1月1号至今数据
</div>
    		<a class="btn btn-primary" href="javascript:searchDay()" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		按日期
            	</a>  
            	<a class="btn btn-primary" href="javascript:searchMon()" id="search1" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		按月份
            	</a>
            	
            		<a class="btn btn-primary" href="javascript:searchQua()" id="search2" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		按季度
            	</a> 
            	  
            	</div>
            <table id="lineChart"  style="width:99%;height:430px">
			</table>

    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->
	</div>

<div  class="col-lg-12 col-sm-12">
 <div class="row">
        <div class="box col-md-12 tour">
            <div class="box-inner">
                <div class="box-header well" data-original-title="">
                    <h2><i class="glyphicon glyphicon-globe"></i> 提示：</h2>
                    <div class="box-icon">
                        <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i
                                class="glyphicon glyphicon-cog"></i></a>
                        <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                                class="glyphicon glyphicon-chevron-up"></i></a>
                        <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i
                                class="glyphicon glyphicon-remove"></i></a>
                    </div>
                </div>
                <div class="box-content">
                    <a href="javascript:void(0)" onclick="startTour()">点击进入提示</a><br>
                </div>
            </div>
        </div>
        <!--/span-->
    </div><!--/row-->
    </div>
<script type="text/javascript" src="js/system/cangkuzhinenghuaxitong/ammeterconfig/list.js"></script>
<script type="text/javascript">
$('.btn-close').click(function (e) {
    e.preventDefault();
    $(this).parent().parent().parent().fadeOut();
});
$('.btn-minimize').click(function (e) {
    e.preventDefault();
    var $target = $(this).parent().parent().next('.box-content');
    if ($target.is(':visible')) $('i', $(this)).removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
    else                       $('i', $(this)).removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
    $target.slideToggle();
});

function startTour(){
	if ($('.tour').length && typeof(tour) == 'undefined') {
	    var tour = new Tour();
	    tour.addStep({
	        element: "#addFun", /* html element next to which the step popover should be shown */
	        placement: "top",
	        title: "添加智能窗户配置", /* title of the popover */
	        content: "你可以点击此按钮，进入添加页面" /* content of the popover */
	    });

	    tour.addStep({
	        element: ".glyphicon-edit:first",
	        placement: "top",
	        title: "修改智能窗户配置",
	        content: "修改该行内容。"
	    });
	    
	    tour.restart();
	}
	
}


</script>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/js/echarts.js">
	
</script>
<script type="text/javascript">

$(function(){
	laydate({
		elem : '#time1',
		event : 'focus'
	});
	laydate({
		elem : '#time2',
		event : 'focus'
	});
	
	//var retList;
		searchDay();
	
})	;

	function searchDay(){
		$.ajax({
			url : rootPath + "/cangkuzhinenghuaxitong/ammeterData/findEnergy.shtml",
			type : "post",
			//async:false,
			cache : false,
			dataType : "json",
			data : {
				"time1" : $("#time1").val(),
				"time2" : $("#time2").val()
			},
			success : function(rs) {
				linechart(rs);
			}
		});
	}
	
	function searchMon(){
		$.ajax({
			url : rootPath + "/cangkuzhinenghuaxitong/ammeterData/findEnergyMon.shtml",
			type : "post",
			//async:false,
			cache : false,
			dataType : "json",
			data : {
				"time1" : $("#time1").val(),
				"time2" : $("#time2").val()
			},
			success : function(rs) {
				linechart(rs);
			}
		});
		
	}
	function searchQua(){
		$.ajax({
			url : rootPath + "/cangkuzhinenghuaxitong/ammeterData/findEnergyQua.shtml",
			type : "post",
			//async:false,
			cache : false,
			dataType : "json",
			data : {
				"time1" : $("#time1").val(),
				"time2" : $("#time2").val()
			},
			success : function(rs) {
				linechart(rs);
			}
		});
		
	}
	
	function linechart(data) {
		var chart = document.getElementById('lineChart');
		chart.innerHTML = '';
		var lineChart = echarts.init(chart);

		// 指定图表的配置项和数据
		option = {
			title : {
				text : '能耗趋势图',
				subtext : ''
			},
			tooltip : {
				trigger : 'axis'
			},
			legend : {
				//data : [ '1号仓','2号仓','3号仓','4号仓' ]
			data: data.name
			},
			toolbox : {
				show : true,
				feature : {
					dataZoom : {
						yAxisIndex : 'none'
					},
					dataView : {
						readOnly : false,
						optionToContent: function(opt) {
							
							
						    var axisData = opt.xAxis[0].data;
						    var series = opt.series;
						    var table = '<table style="width:100%;text-align:center"><tbody><tr>'
						                 + '<td>'+opt.xAxis[0].name+'</td>'
						    
						    for(var i=0,l=series.length;i<l;i++){
								table += '<td>' + series[i].name +'('+opt.yAxis[0].name+ ')</td>';
						    }
						    
						                
						          table+= '</tr>';
						    for (var i = 0, l = axisData.length; i < l; i++) {
						        table += '<tr>'
						                 + '<td>' + axisData[i] + '</td>'
						        for(var j=0;j<series.length;j++){
						        	
						            table     += '<td>' + series[j].data[i] + '</td>'
						        }
						               
						                 + '</tr>';
						    }
						    table += '</tbody></table>';
						    return table;
						}
					},
					magicType : {
						type : [ 'line', 'bar', 'stack', 'tiled']
					},
					restore : {},
					saveAsImage : {}
				}
			},
			xAxis : {
				type : 'category',
				boundaryGap : false,
				name:'时间',
				//data : ['2017-06-01','2017-06-02','2017-06-03','2017-06-04','2017-06-05']
				data:data.xAxis
			},
			yAxis : {
				name:'能耗/kwh',
				type : 'value',
				axisLabel : {
					formatter : '{value} kwh'
				}
			},
			/*
			series : [ {
				name : '一号仓',
				type : 'line',
				data : ['1026','80','0','0','90']
			}, {
				name : '二号仓',
				type : 'line',
				data : ['0','180','20','0','290']
			},{
				name : '三号仓',
				type : 'line',
				data : ['26','280','10','30','30']
				
			},{
				name : '四号仓',
				type : 'line',
				data : ['0','90','20','10','0']
			} ]*/
		series : data.series
		}
		;
		lineChart.setOption(option);
	}
	
	linechart();
</script>

