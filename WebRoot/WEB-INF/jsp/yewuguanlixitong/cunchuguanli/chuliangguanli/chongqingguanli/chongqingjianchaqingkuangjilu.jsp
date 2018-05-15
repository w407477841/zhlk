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
        <h2><i class="glyphicon glyphicon-list"></i> 虫情检查情况记录</h2>

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
			<input type="text" name="userLoginLogFormMap.accountName" value="" placeholder="检测日期">
    </form>
 
            	<a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		查询
            	</a> 
        
            	</div>
  
    </div>
                   
  <div class="row" id="cangku" style="position:relative;background:url(img/cangku/1000001.jpg)	;background-size:100% 100%;height:700px ">

 </div>
			

    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->      
          
          

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
	        title: "添加角色", /* title of the popover */
	        content: "你可以点击此按钮，进入添加页面" /* content of the popover */
	    });

	    tour.addStep({
	        element: ".glyphicon-edit:first",
	        placement: "top",
	        title: "修改角色",
	        content: "修改该行内容。"
	    });
	    
	    tour.restart();
	}
	
}
/*
$.ajax({
	type : "POST",
	data : {
		"location_id" : "${param.name}"
		
	},
	url : rootPath + '/shipindianwei/findALlByCid.shtml',
	dataType : 'json',
	success : function(json) {
		if(json){
		var cangku=$("#cangku");
		var dangqian=json;
		for(var i=0;i<dangqian.length;i++){
			var ip_Num=dangqian[i].ipNum;
			var ip=dangqian[i].ip;
			var port=dangqian[i].port;
			var userName=dangqian[i].userName;
			var password=dangqian[i].password;
			$("<div>").css("width","20px").css("height","20px")
		    .css("background","url(${pageContext.servletContext.contextPath}/img/cangku/jk.png)")
			.css("background-size","100% 100%")	.css("color","white")
			.css("cursor","pointer")
			.mousemove(function(event){
			})
			.mouseout(function(event){
			})
			.click(function(){
				
				pageii = layer.open({
					title : "<h5><i class='glyphicon glyphicon-link'></i>监控点位<h5>",
					type : 2,
					maxmin :true,
					area : [ "850px", "600px" ],
					content : rootPath + '/liangku/viewjiankong.shtml?name=${param.name}&ipNum='+$(this).attr("data-ipNum")+'&ip='+$(this).attr("data-ip")+'&port='+$(this).attr("data-port")+'&userName='+$(this).attr("data-userName")+'&password='+$(this).attr("data-password")
				});
			})
			.attr("data-ipNum",ip_Num).attr("data-ip",ip).attr("data-port",port).attr("data-userName",userName).attr("data-password",password)
			.css("position","absolute").css("left",dangqian[i].sLeft).css("top",dangqian[i].top)
			.appendTo(cangku);
			
		}

		
	}
		}
});
*/


/*
var dws={"lq":
	[{"id":1,"left":"85.1%","top":"58.9%"},
	 {"id":2,"left":"77.3%","top":"55.4%"},
	 {"id":3,"left":"86.8%","top":"51.7%"},
	 {"id":4,"left":"79.4%","top":"48.5%"},
	 {"id":5,"left":"59.7%","top":"56.9%"},
	 {"id":6,"left":"53.3%","top":"53.8%"},
	 {"id":7,"left":"66.2%","top":"50.1%"},
	 {"id":8,"left":"60%","top":"47.2%"},
	 {"id":9,"left":"69.3%","top":"44%"},
	 {"id":10,"left":"63.2%","top":"41.3%"},
	 {"id":11,"left":"42.8%","top":"49.1%"},
	 {"id":12,"left":"39.5%","top":"46.4%"},
	 {"id":13,"left":"36.2%","top":"43.6%"},{"id":14,"left":"32.7%","top":"40.5%"},{"id":15,"left":"50.6%","top":"42.3%"},
	 {"id":16,"left":"47.8%","top":"40.1%"},{"id":17,"left":"44.6%","top":"37.8%"},{"id":18,"left":"41.1%","top":"34.8%"},
	 {"id":19,"left":"57.5%","top":"37%"},{"id":20,"left":"54.5%","top":"35%"},{"id":21,"left":"50.5%","top":"33%"},
	 {"id":22,"left":"47.3%","top":"30.7%"},{"id":23,"left":"22%","top":"31.1%"},{"id":24,"left":"27.6%","top":"34.6%"},
	 {"id":25,"left":"27.4%","top":"25.6%"},{"id":26,"left":"32.2%","top":"28.2%"},{"id":27,"left":"31.7%","top":"19.8%"},{"id":28,"left":"36.7%","top":"22.7%"}]};
*/

function view(){
	
}

</script>