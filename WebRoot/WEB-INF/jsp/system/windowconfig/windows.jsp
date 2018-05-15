<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
    <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-facetime-video"></i>智能窗户控制</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    
    <div class="box-content" id="page" style="height:470px;position:relative;">
    <div class="" style="position:relative;top:0px;left:0px ;z-index:1;text-align:center" >
    <img src="${imgPath}"  style="height:450px;">
    </div>
    
    	<c:forEach items="${list}" var="var">
	<div class="cangkudianwei" data-left="${var.cLeft}" data-top="${var.cTop}" data-id="${var.id}" style="border-radius:4px;opacity:0.2;background-color:#2fa4e7;position:absolute;height:40px;width:40px;z-index:3 ;padding-left:4px;padding-top:10px;cursor:pointer " >
  
    </div>
    <div class="cangkudianwei"  data-left="${var.cLeft}" data-top="${var.cTop}" data-id="${var.id}" style="border-radius:4px;position:absolute;height:40px;width:40px;z-index:4 ;padding-left:4px;padding-top:10px;cursor:pointer;color:#FFF " >
   <small> ${var.name}</small>
    </div>
    </c:forEach>
   
  </div>
    </div>
    </div>
    </div>
    </div>
<script type="text/javascript" src="js/system/windowconfig/list.js"></script>

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

var pageii;
$("#page").click(function(ev){
	var target=ev.target;
	var $obj;
	console.debug(target.nodeName);
	if(target.nodeName=="DIV"&&target.className=="cangkudianwei"||target.nodeName=="SMALL"){
		if(target.nodeName=="SMALL")  $obj=$(target).parent();
		else $obj=$(target);
		
		window.open(rootPath + '/windowConfig/optionUI.shtml?cangkudianwei='+$obj.attr("data-id"),'','resizable=no,scrollbars=no,status=no,toolbar=no,menubar=no,location=no');
		//showModelessDialog(rootPath + '/windowConfig/optionUI.shtml?cangkudianwei='+$obj.attr("data-id"),'dialogWidth:1000px;dialogHeight:600px;dialogLeft:10px;dialogTop:10px;center:yes;help:yes;resizable:yes;status:yes');
		/*
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>窗户控制<h5>",
			type : 2,
			maxmin :true,
			area : [ "800px", "600px" ],
			content : rootPath + '/windowConfig/optionUI.shtml?cangkudianwei='+$obj.attr("data-id"),
			end :function(){
				grid.datagrid("reload");
			}
		});*/
	}
});

var div_width=800;
var div_height=450;
$(function(){
	$.each($(".cangkudianwei"),function(i,v){
		$obj=$(v);
		var _left=parseFloat($obj.attr("data-left"));
		var _top=parseFloat($obj.attr("data-top"));
		$obj.css("left",8*_left+"px").css("top",4.5*_top+"px");
		
		
	});
});
</script>
