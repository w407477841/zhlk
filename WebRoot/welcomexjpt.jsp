<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<head>
<style type="text/css">
#container {
	height: 500px;
	width: 100%;
}

.mapcontent {
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
}

</style>
</head>
<body>
	<!-- content starts -->
	<div class="row">
		<div class="box col-md-12"  style="padding-left:0px;padding-right:0px;">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-globe"></i>&nbsp;地图
					</h2>
				</div>
				<div class="box-content" id="page">
					<div id="container"></div>
				</div>
			</div>
		</div>
		<!--/span-->
	</div>
	<!--/row-->
</body>
<script type="text/javascript">
window.onload = function(){};
var map = new BMap.Map("container"); // 创建地图实例  
var point = new BMap.Point(120.36569,32.438948); // 创建点坐标  (经度,纬度)
map.centerAndZoom(point, 14); // 初始化地图，设置中心点坐标和地图级别
map.enableScrollWheelZoom(true);  //设置鼠标滚动缩放图片

map.addControl(new BMap.MapTypeControl());// 地图/卫星/三维
map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT}));// 左上角，添加比例尺
map.addControl(new BMap.NavigationControl());// 左上角，添加比例尺
addMarkersForJson();

	var lat = 0;
	var log = 0;
	function addMarkersForJson(){
	var _url=rootPath+'/warehouse/findAllMap.shtml';
	 $.ajax({type: "POST",url: _url,async:true,
		success:function(data){
		  var cdata = data;
		  for(var i=0;i<cdata.length;i++){
		   var warehouse = cdata[i];
		   lat+=parseFloat(warehouse.wLat);
		   log+=parseFloat(warehouse.wLog);
		   var point = new BMap.Point(warehouse.wLog,warehouse.wLat); 
	       addMarker(point,warehouse.wNo,warehouse.wName,warehouse.wImage,warehouse.wSummary);
		  }
		 map.centerAndZoom(new BMap.Point(log/cdata.length,lat/cdata.length), 12);
		}
		});
	}

	function addMarker(point,ckbh,data_name,data_img,data_info){  // 创建图标对象   
    var myIcon = new BMap.Icon(rootPath+"/img/cangku/marker.png", new BMap.Size(70, 43), {    
   // 指定定位位置。   
   // 当标注显示在地图上时，其所指向的地理位置距离图标左上    
   // 角各偏移10像素和25像素。您可以看到在本例中该位置即是   
   // 图标中央下端的尖角位置。    
      offset: new BMap.Size(10, 25),    
   // 设置图片偏移。   
   // 当您需要从一幅较大的图片中截取某部分作为标注图标时，您   
   // 需要指定大图的偏移位置，此做法与css sprites技术类似。    
   //imageOffset: new BMap.Size(0, 0 - index * 25)   // 设置图片偏移    
   });

   // 创建标注对象并添加到地图   
   var marker = new BMap.Marker(point, {icon: myIcon});    
   
   // 百度地图API功能
	var sContent ="<div class='mapcontent'>"+
	"<div class='data_info'>"+
	"<h4 style='margin:0 0 5px 0;padding:0.2em 0'>"+data_name+"</h4>" + 
	"<img style='float:right;margin:4px' id='imgDemo' src='"+data_img+"' width='200' height='150' title='"+data_name+"'/>" + 
	"<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>"+data_info+"</p>" + 
	"</div>"+
	"<div class='link_info'>"+
	"<a href='javascript:void(0)' onclick=onloadUrl('','${pageContext.servletContext.contextPath}/shipindianwei/list.shtml?source="+ckbh+"')><i  class='glyphicon glyphicon-facetime-video'>视频监控</i></a>&nbsp;&nbsp;"+
	"<a href='javascript:void(0)' onclick=onloadUrl('','${pageContext.servletContext.contextPath}/kcxx/kcxx.shtml?source="+ckbh+"')><i  class='glyphicon glyphicon-inbox'>库存信息</i></a>&nbsp;&nbsp;"+
	"<a  href='javascript:void(0)' onclick=onloadUrl('','${pageContext.servletContext.contextPath}/warehouse/view.shtml?kd="+ckbh+"&time="+new Date().getMilliseconds()+"')><i  class='glyphicon glyphicon-tint'>粮情信息</i></a>&nbsp;&nbsp;"+
	"</div>"+
	"</div>";
	var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象
	marker.addEventListener("click", function(){          
	   this.openInfoWindow(infoWindow);
	   //图片加载完毕重绘infowindow
	   document.getElementById('imgDemo').onload = function (){
		   infoWindow.redraw();   //防止在网速较慢，图片未加载时，生成的信息框高度比图片的总高度小，导致图片部分被隐藏
	   };
	});
	
   map.addOverlay(marker);
   var opts = {
	  position : point,    // 指定文本标注所在的地理位置
	  offset   : new BMap.Size(-20, 20)    //设置文本偏移量
	};
   var label = new BMap.Label(data_name, opts);  // 创建文本标注对象
		label.setStyle({
			 color : "red",
			 fontSize : "14px",
			 border : "0",
			 height : "25px",
			 backgroundColor : "0.05",
			 lineHeight : "25px",
			 fontWeight : "bold",
			 fontFamily:"微软雅黑"
		 });
   map.addOverlay(label); 
}
	</script>