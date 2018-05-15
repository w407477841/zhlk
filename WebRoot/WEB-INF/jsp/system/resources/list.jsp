<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
    <div id="content" class="col-lg-10 col-sm-10">
            <!-- content starts -->
                <div>
    </div>
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-user"></i>菜单数据列</h2>

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
			<input type="text" name="resFormMap.name" value="" placeholder="名称">
    </form>
    <a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white"></i>
               		查询
            	</a>  <a class="btn btn-primary" href="javascript:void(0)" id="addFun" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-plus icon-white"></i>
               		添加
            	</a></div>
            	
            <table id="magazineGrid"  style="width:99%;height:600px">
			</table>

    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->
	</div>
<div  class="col-lg-2 col-sm-10">
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
<script type="text/javascript" src="js/system/resources/list.js"></script>
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
	        title: "添加菜单", /* title of the popover */
	        content: "你可以点击此按钮，进入添加页面" /* content of the popover */
	    });
	    tour.addStep({
	        element: "#deleteFun",
	        placement: "top",
	        title: "删除菜单",
	        content: "选中需要删除的菜单，点击此按钮，你可以删除菜单，及其子菜单"
	    });
	    tour.addStep({
	        element: "#editFun",
	        placement: "top",
	        title: "修改菜单",
	        content: "选中需要修改的菜单，点击进入修改页面"
	    });
	    tour.restart();
	}
	
}


</script>


