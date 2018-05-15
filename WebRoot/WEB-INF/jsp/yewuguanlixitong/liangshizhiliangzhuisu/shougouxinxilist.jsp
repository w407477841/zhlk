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
        <h2><i class="glyphicon glyphicon-list"></i> 收购信息</h2>
        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content" id="page">
    <div class="alert alert-info"> 
     <form class="form-inline" role="form" id="searchForm" name="searchForm">
     
               	<div style="width: 120px;float: left;">
			<select id="location" data-rel="chosen" name="breed"  data-placeholder="粮食 品种" >
				<option value="" selected="selected"> </option>
								<option value="1114">混合小麦</option>
								<option value="1132002">晚粳稻谷</option>
			</select>
			</div>
			<input type="text" name="company" class="form-control" style="height: 30px" value="" placeholder="收购单位">
    </form>
    <a class="btn btn-primary" href="javascript:void(0)" id="add" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-plus icon-white" ></i>
               		登记
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="edit" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-edit icon-white" ></i>
               		编辑
            	</a>
            	            		<a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		查询
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="remove" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-remove icon-white" ></i>
               		删除
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

<script type="text/javascript" src="js/system/yewuguanlixiytong/liangshizhiliangzhuisu/shougouxinxilist.js"></script>
<script type="text/javascript">

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
