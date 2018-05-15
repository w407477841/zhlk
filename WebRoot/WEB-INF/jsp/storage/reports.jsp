<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>

<style>
#back{
position: absolute;
right: 10vh;
top:5vh;
opacity:0;
transition:opacity 1s
}
#page{
position: relative;
}
</style>

   <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-list"></i> 实时库存</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content" id="page">
        <div id="magazineGrid1"  style="width:99%;height:250px"></div>
        <button id="back" class="btn btn-default radius" type="button">返回上一级</button>
        
        <div id="spline"  style="width:99%;height:250px"></div>
        <div id="magazineGrid"  style="width:99%;height:250px"></div>
    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->
	</div>

  <script type="text/javascript" src="js/storage/reports.js"></script> 
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

loadChartData(undefined,callback);
loadSpline();
queryWeight('');

	$("#back").on("click",function(){
	document.getElementById("back").style.opacity=0;
	loadChartData(undefined,callback);
	});
	
function callback(location){
	loadChartData("storage/instanceHouseAmount.shtml?location="+location);
	document.getElementById("back").style.opacity=1;
}
function loadChartData(url,callback){
	 url=url||"storage/instanceAmount.shtml";
		$.ajax({
				url : url,
				success : function(rs) {
				var categories=[];
				var data=[];
				for(var i=0;i<rs.rs.length;i++){
				categories.push(rs.rs[i].wName);
				data.push({y:~~rs.rs[i].weight,No:rs.rs[i].wNo});
				}
				draw(categories,data,callback);
				}
			})
}
function draw(x,y,callback){
				 $('#magazineGrid1').highcharts({
				     	credits:{
			    		enable:false,
			    		text:'',
			    		href:''
			    	},
			    	xAxis:{
			    	categories:x
			    	},
			    	 yAxis: {
			            
			            title: {
			                text: ''
			            }
			        },
			        chart: {
			            plotBackgroundColor: null,
			            plotBorderWidth: null,
			            plotShadow: false
			        },
			        title: {
			            text: '实时库存',
			            float:true,
			            margin:-5
			        },
			        tooltip: {
			            pointFormat: '{series.name}: <b>{point.y:.1f}（KG）</b>'
			        },
					plotOptions : {
								series : {
									cursor : 'pointer',
									borderWidth : 0,
									dataLabels : false,
									events : {
										click : function(event){
										if(typeof callback=="function"){
										callback.call(window,event.point.No)
										}
										}
									}
								}
							},
			        series: [{
			            type: 'column',
			            name: '库存量',
			            data: y
			        }]
			    });
}
function loadSpline(location,houseid){
	 url="storage/splineData.shtml";
		$.ajax({
				url : url,
				data:{location:location,houseid:houseid},
				success : function(rs) {
				if(rs.success){
				var result=Array.prototype.map.call(rs.rs1,function(obj,index){
					return {
					x:Date.parse(obj.time),
					y:~~obj.weight,
					inorout:obj.inorout=='0'?'出库':'入库',
					id:obj.id
					}
				})
					drawSpline(result)
				}
			}
			})
}
function drawSpline(data){
    Highcharts.chart('spline', {
    
		credits:{
			enable:false,
			text:'',
			href:''
			    },    	
        chart: {
            type: 'spline',
            animation: Highcharts.svg, 
            marginRight: 10,
            events: {
                load: function () {
                    var series = this.series[0];
                }
            }
        },
        title: {
            text: '出入库实时统计'
        },
        xAxis: {
            type: 'datetime',
            tickPixelInterval: 150,
            dateTimeLabelFormats:
                {
                    second: '%H:%M:%S',
                    minute: '%m月%e日   %H:%M',
                    hour: '%m月%e日  %H:%M',
                    day: '%m月%e日',
                    week: '%m月%e日',
                    month: '%y年%m月',
                    year: '%y年'
                }
        },
        yAxis: {
            title: false,
            min:0,
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            formatter: function () {
                return Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                    this.point.inorout+'<span style="color:red">'+this.y+'</span>'+'<b>	KG</b>';
            }
        },
        legend: {
            enabled: false
        },
		plotOptions : {
								series : {
									cursor : 'pointer',
									borderWidth : 0,
									dataLabels : true,
									events : {
										click : function(event){
										//alert(event.point.id)
										queryWeight(event.point.id)
										}
									}
								}
							},
        series: [{
            name: '',
            data: data
        }]
    });


}
</script>
