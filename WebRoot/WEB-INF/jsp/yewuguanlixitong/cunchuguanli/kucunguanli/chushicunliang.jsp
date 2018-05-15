<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

 <style type="text/css">
	 .chosen-container-single .chosen-single{
	 height:38px;
	 }
	 
	 </style>
    <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-list"></i> 初始存粮</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content" id="page">
  <div class="row">
     <div id="errorDiv" class="col-md-12">
</div>
<div class=" col-md-12"> 
	<form id="form" name="form" method="post"
		action="${pageContext.servletContext.contextPath}/store/initStore.shtml">
	<div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectLocation" data-rel="chosen" data-placeholder="库点" name="storeInfoFormMap.location_id" style="width:100%">
  	<option value=""></option>
   </select>
    </div>    
   </div>
		<div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectCk" data-rel="chosen" data-placeholder="仓号" name="storeInfoFormMap.warehouse_id" style="width:100%">
  	<option value=""></option>
   </select>
    </div>    
   </div> 
		
		 <div class="form-group col-md-3">
   <div class="has-warning">
   <input type="text" class="form-control" id="siType"  name="storeInfoFormMap.siType" value="" placeholder="仓型">
   </div>
   </div>
     <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siDesignCapacity"  name="storeInfoFormMap.siDesignCapacity" value="" placeholder="设计仓容(吨)">	
   </div>  
   </div>   
       <div class="form-group col-md-3">
   <div class="has-warning">
	<select id="selectPerson" data-rel="chosen" data-placeholder="保管员" name="storeInfoFormMap.person_id" style="width:100%">
   </select>	
   </div>  
   </div>   
      <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectNature" data-rel="chosen" data-placeholder="储粮性质" name="storeInfoFormMap.siNature" style="width:100%">
   </select>
    </div>    
   </div> 
  <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectCategory" data-rel="chosen" data-placeholder="粮食类别" name="storeInfoFormMap.siCategory" style="width:100%">
   </select>
    </div>    
   </div> 
    <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectVariety" data-rel="chosen" data-placeholder="粮食品种" name="storeInfoFormMap.siVariety" style="width:100%">
   </select>
    </div>    
   </div> 
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siYear"  name="storeInfoFormMap.siYear" value="" placeholder="收获年度">	
   </div>  
   </div>  
   <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectPack" data-rel="chosen" data-placeholder="包装方式" name="storeInfoFormMap.siPack" style="width:100%">
   </select>
    </div>    
   </div> 
      <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siOrigin"  name="storeInfoFormMap.siOrigin" value="" placeholder="产地">	
   </div>  
   </div> 
   
      <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siPutin"  name="storeInfoFormMap.siPutin" value="" placeholder="入库时间">	
   </div>  
   </div>  
      <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siQuantity"  name="storeInfoFormMap.siQuantity" value="" placeholder="存粮数量(公斤)">	
   </div>  
   </div>  
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siPrice"  name="storeInfoFormMap.siPrice" value="" placeholder="单价">	
   </div>  
   </div>  
      <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectLevel" data-rel="chosen" data-placeholder="等级" name="storeInfoFormMap.siLevel" style="width:100%">
   </select>
    </div>    
   </div> 
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siMoisture"  name="storeInfoFormMap.siMoisture" value="" placeholder="水份(%)">
   </div>  
   </div>  
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siImpurity"  name="storeInfoFormMap.siImpurity" value="" placeholder="杂质(%)">	
   </div>  
   </div>  
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siUnitweight"  name="storeInfoFormMap.siUnitweight" value="" placeholder="容重(g/l)">	
   </div>  
   </div>  
       <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siUnsoundgrain"  name="storeInfoFormMap.siUnsoundgrain" value="" placeholder="不完善粒(%)">	
   </div>  
   </div>  
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siYellowrice"  name="storeInfoFormMap.siYellowrice" value="" placeholder="黄粒(%)">	
   </div>  
   </div>  
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siHeadricerate"  name="storeInfoFormMap.siHeadricerate" value="" placeholder="整精米率(%)">	
   </div>  
   </div>  
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siBrownricerate"  name="storeInfoFormMap.siBrownricerate" value="" placeholder="出糙(%)">	
   </div>  
   </div> 
       <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siHuskedriceinpeddy"  name="storeInfoFormMap.siHuskedriceinpeddy" value="" placeholder="谷外糙米(%)">	
   </div>  
   </div>  
  
      <div class="form-group col-md-12">
       <input type="submit" class="btn btn-info bt-submit" value="保存"></button>
      </div> 
   </form> 	
  	</div> 	
  </div>
   
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
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/common/common_code.js">

</script>
<script type="text/javascript">
//添加日期空间--2017-06-13
laydate({
	elem : '#siPutin',
	event : 'focus'
});
//初始化 select控件
(function(){
	$('[data-rel="chosen"],[rel="chosen"]').chosen();

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
})();
(function(){
//	  $('[data-rel="chosen"],[rel="chosen"]').html("");
//	  $('[data-rel="chosen"],[rel="chosen"]').chosen("destroy"); 
//	  $('[data-rel="chosen"],[rel="chosen"]').chosen({
//  		no_results_text : "未找到此选项!",
//			width:"100%"});
	var rootPath="${pageContext.servletContext.contextPath}";
	//初始化库点下拉框
	
	(function location(){
		$("#selectLocation").html("");
		$("#selectLocation").chosen("destroy"); 
	new myselect({
		obj_id:"selectLocation",
		url:rootPath+"/warehouse/findMap.shtml",
		option_val:["wNo"],
		option_val_prefix:",",
		option_html:["wName"],
		option_html_prefix:","
		
	},function(){
		//给change事件添加方法
		 ck();
	},function(){
		//初始化执行方法
		
	});
	$("#selectLocation").chosen({
		no_results_text : "未找到此选项!",
		width:"100%"
		});
	})();
	
	person();
	
function ck(){
	$("#selectCk").html("");
	$("#selectCk").chosen("destroy"); 
	 new myselect({
		obj_id:"selectCk",
		url:rootPath+"/warehouse/findWareHouseByLocation2.shtml",
		data:{"location_id":$("#selectLocation").val()},
		option_val:["id"],
		option_val_prefix:",",
		option_html:["wName"],
		option_html_prefix:","
	},function(){
		//给change事件添加方法
	},function(){
		//初始化执行方法
	});
	$("#selectCk").chosen({
		no_results_text : "未找到此选项!",
		width:"100%"
		});
	
}	
	
function person(){
	$("#selectPerson").html("");
	$("#selectPerson").chosen("destroy"); 
	 new myselect({
		obj_id:"selectPerson",
		url:rootPath+"/renyuandangan/findRenYuanDangAn.shtml",
		//data:{"location_id":$("#selectLocation").val()},
		option_val:["id"],
		option_val_prefix:",",
		option_html:["paName"],
		option_html_prefix:","
	},function(){
		//给change事件添加方法
	},function(){
		//初始化执行方法
	});
	$("#selectPerson").chosen({
		no_results_text : "未找到此选项!",
		width:"100%"
		});
}


//粮食性质 开始
$("#selectNature").html("");
$("#selectNature").chosen("destroy"); 
Util.code({
	obj_id:"selectNature",
	codeid:"11"
});
$("#selectNature").chosen({
	no_results_text : "未找到此选项!",
	width:"100%"
	});
//粮食性质结束
//粮食品种 开始
$("#selectVariety").html("");
$("#selectVariety").chosen("destroy"); 
Util.code({
	obj_id:"selectVariety",
	codeid:"12"
});
$("#selectVariety").chosen({
	no_results_text : "未找到此选项!",
	width:"100%"
	});
//粮食品种 结束
//包装方式 开始
$("#selectPack").html("");
$("#selectPack").chosen("destroy"); 
Util.code({
	obj_id:"selectPack",
	codeid:"26"
});
$("#selectPack").chosen({
	no_results_text : "未找到此选项!",
	width:"100%"
	});
//包装方式 结束

//类别 开始
$("#selectCategory").html("");
$("#selectCategory").chosen("destroy"); 
Util.code({
	obj_id:"selectCategory",
	codeid:"27"
});
$("#selectCategory").chosen({
	no_results_text : "未找到此选项!",
	width:"100%"
	});
//类别 结束

//类别 开始
$("#selectLevel").html("");
$("#selectLevel").chosen("destroy"); 
Util.code({
	obj_id:"selectLevel",
	codeid:"10"
});
$("#selectLevel").chosen({
	no_results_text : "未找到此选项!",
	width:"100%"
	});
//类别 结束
})();

$("#form").validate({
	submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
		ly.ajaxSubmit(form,{//验证新增是否成功
			type : "post",
			dataType : "json",
			success : function(data) {
				if (data == "success") {
					layer.alert('添加成功！', 3);
				} else {
					layer.alert('添加失败！', 3);
				}
			}
		});
	},
	rules: {
	
		},
	messages: {

		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
			$("#errorDiv").css('display', 'block');
			// element.css('border','3px solid #FFCCCC');
			$("#errorDiv").html(error.html());
		},
		success : function(label) {// 验证通过后
			label.parent().attr("class","has-success");
		}
});


</script>
