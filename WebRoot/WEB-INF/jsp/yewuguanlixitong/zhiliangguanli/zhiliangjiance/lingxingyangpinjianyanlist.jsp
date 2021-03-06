<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
<style>
.clear-float:after{
content:'';
clear:both;
display: block;
}
</style>
    <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-list"></i> 零星样品检验记录</h2>
        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content" id="page">
    <div class="alert alert-info"> 
     <form class="form-inline clear-float" role="form" id="searchForm"
			name="searchForm">
						<div style="float: left;">
				<input id="start" type="text" class=" inline laydate-icon  form-control " name="InstanceMsgFormMap.stime" value="" placeholder="开始日期">
			</div>
			
			<div style="float: left;">
			<input id="start1" type="text" class=" inline laydate-icon  form-control " name="InstanceMsgFormMap.etime" value="" placeholder="结束日期">
			</div>
    </form>
    <a class="btn btn-primary" href="javascript:void(0)" id="add" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-plus icon-white" ></i>
               		登记
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="edit" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-edit icon-white" ></i>
               		编辑
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="remove" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-remove icon-white" ></i>
               		删除
            	</a> 
    		<a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		查询
            	</a>  
            	  	          	 <a class="btn btn-primary" href="#" id="export"  style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-export icon-white"></i>
               		数据导出
            	</a>
            	</div>
            <table id="magazineGrid"  style="width:99%;height:600px">
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
<script type="text/javascript" src="js/system/yewuguanlixiytong/zhiliangguanli/zhiliangjiance/lingxingyangpinjianyanlist.js"></script>
<script type="text/javascript">

laydate({
			elem : '#start',
			event : 'focus',
			format:'YYYY-MM-DD hh:mm:ss'
		});			
		laydate({
			elem : '#start1',
			event : 'focus',
			format:'YYYY-MM-DD hh:mm:ss'
		});	
initLocation()
function initLocation() {
	$.ajax({
		url : rootPath + "/kcxx/locations.shtml",
		type : "post",
		async : false,
		data : {
			"source" : 1
		},
		success : function(rs) {
			var sel = document.getElementById("location");
			if (rs.success) {
				for ( var i = 0; i < rs.list.length; i++) {
					let ops=new Option(rs.list[i].wName, rs.list[i].wNo);
					sel.add(ops);
				}
			}

		}
	})
}


$("#location").on("change",function(event) {
			var value = this.value;
			$.ajax({
				url : rootPath + "/businessManager/findHouses.shtml",
				type : "post",
				async : false,
				data : {
					"wno" : value
				},
				success : function(rs) {
					var sel = document.getElementById("storageID");
					sel.innerHTML = "<option value=''></option>"
					$("#storageID").chosen("destroy");
					rs = JSON.parse(rs);
					if (rs.success) {
						for ( var i = 0; i < rs.result.length; i++) {
							sel.add(new Option(rs.result[i].wName,rs.result[i].id+","+rs.result[i].wName))
						}
						$("#storageID").chosen({
							no_results_text : "未找到此选项!",
							width : "100px"
						});
						
						$(".chosen-single").css("height", "32px").css("borderRadius", "4px");
					}
				}
			})
		});
$("#location").trigger("change")

$("#location").chosen({no_results_text : "未找到此选项!"});
$(".chosen-container").css("verticalAlign","top")
$(".chosen-single").css("height","30px").css("width","100px").css("borderRadius","4px")
$(".chosen-drop").css("width","100px");


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
	        title: "添加用户", /* title of the popover */
	        content: "你可以点击此按钮，进入添加页面" /* content of the popover */
	    });

	    tour.addStep({
	        element: ".glyphicon-edit:first",
	        placement: "top",
	        title: "修改用户",
	        content: "修改该行内容。"
	    });
	    
	    tour.restart();
	}
	
}


</script>
