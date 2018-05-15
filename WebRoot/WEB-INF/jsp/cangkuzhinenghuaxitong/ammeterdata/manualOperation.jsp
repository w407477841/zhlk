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
        <h2><i class="glyphicon glyphicon-facetime-video"></i>手动抄表</h2>

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
		
    </form>
<div class="alert alert-warning alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <strong>默认查询</strong> 每个表最近一次读数 
</div>

<div class="alert alert-warning alert-dismissible" style="display:none" role="alert" id="loadimg">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <strong>远程抄表中</strong> <img alt="" src="${pageContext.servletContext.contextPath}/img/ajax-loaders/ajax-loader-5.gif">
</div>

    		
            	<a class="btn btn-danger" href="javascript:void(0)" id="manual" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-plus icon-white" ></i>
               		手动抄表
            	</a>  
            	</div>
            <table id="datagrid1"  style="width:99%;height:430px">
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
    
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/system/cangkuzhinenghuaxitong/ammeterdata/manualOperation.js"></script>
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
	
	
	//var retList;
	//	search();
	
})	;
	
</script>

