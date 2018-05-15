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
        <h2><i class="glyphicon glyphicon-list"></i> 实时库存</h2>
        <!--实时库存为 初始存量+历史出入库记录  -->
        <!--实时库存质量信息为  统仓质检信息/初始质量信息   -->

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content" id="page">
    <div class="alert alert-info"> 
     <form class="form-inline clear-float" role="form" id="searchForm" name="searchForm">
			<div style="width: 250px;float: left;">
			<select id="location" data-rel="chosen" name="location"  data-placeholder="库点名称" >
				<option value="" selected="selected"> </option>
			</select>
			</div>
			
			<div style="width: 250px;float: left;">
			<select id="breed" data-rel="chosen" name="breed"  data-placeholder="品种" >
				<option value="" selected="selected"> </option>
			</select>
			</div>
			
			<div style="width: 250px;float: left;">
			<select id="property" data-rel="chosen" name="property"  data-placeholder="粮食性质" >
				<option value="" selected="selected"> </option>
			</select>
			</div>
			
			
    </form>
            
            <a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		查询信息
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

  
<script type="text/javascript" src="js/system/yewuguanlixiytong/cunchuguanli/kucunguanli/shishikucun.js"></script>
<script type="text/javascript">

initLocation();initProperty();initBreed()
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

function initBreed() {
	$.ajax({
		url : rootPath + "/kcxx/breeds.shtml",
		type : "post",
		async : false,
		success : function(rs) {
			var sel = document.getElementById("breed");
			if (rs.success) {
				for ( var i = 0; i < rs.list.length; i++) {
					sel.add(new Option(rs.list[i].text, rs.list[i].id))
				}
			}

		}
	})
}

function initProperty() {
	$.ajax({
		url : rootPath + "/kcxx/properties.shtml",
		type : "post",
		async : false,
		success : function(rs) {
			var sel = document.getElementById("property");
			if (rs.success) {
				for ( var i = 0; i < rs.list.length; i++) {
					sel.add(new Option(rs.list[i].text, rs.list[i].id))
				}
			}

		}
	})
}

$("#location,#breed,#property").chosen({no_results_text : "未找到此选项!"});
$(".chosen-container").css("verticalAlign","top")
$(".chosen-single").css("height","30px").css("width","150px").css("borderRadius","4px")
$(".chosen-drop").css("width","180px");



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
