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
        <h2><i class="glyphicon glyphicon-list"></i> 粮食储藏情况上报</h2>

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
		action="${pageContext.servletContext.contextPath}/warehouseSaveReport/add.shtml">
	<div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectLocation" data-rel="chosen" data-placeholder="库点" name="warehouseSaveReportFormMap.location_no" style="width:100%">
  	<option value=""></option>
   </select>
    </div>    
   </div>
		<div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectCk" data-rel="chosen" data-placeholder="仓号" name="warehouseSaveReportFormMap.warehouse_id" style="width:100%">
  	<option value=""></option>
   </select>
    </div>    
   </div> 
		 <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectVariety" data-rel="chosen" data-placeholder="粮食品种" name="warehouseSaveReportFormMap.wCategory" style="width:100%">
   </select>
    </div>    
   </div> 
   
   
      <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siPutin"  name="warehouseSaveReportFormMap.wInstocktime" value="" placeholder="入库时间  2017-01">	
   </div>  
   </div>  
     <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectPack" data-rel="chosen" data-placeholder="包装方式" name="warehouseSaveReportFormMap.wPacking" style="width:100%">
   </select>
    </div>    
   </div> 
     <div class="form-group col-md-3">
   <div class="has-success">
   <select id="selectNature" data-rel="chosen" data-placeholder="储粮性质" name="warehouseSaveReportFormMap.wQuality" style="width:100%">
   </select>
    </div>    
   </div> 
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siQuantity"  name="warehouseSaveReportFormMap.wStock" value="" placeholder="存粮数量(公斤)">	
   </div>  
   </div> 
   <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="wPrice"  name="warehouseSaveReportFormMap.wPrice" value="" placeholder="单价">
   </div>  
   </div>  
   <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="wSum"  name="warehouseSaveReportFormMap.wSum" value="" placeholder="金额">
   </div>  
   </div>  
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="siMoisture"  name="warehouseSaveReportFormMap.wMoisture" value="" placeholder="水份(%)">
   </div>  
   </div>  
		 <div class="form-group col-md-3">
   <div class="has-warning">
   <input type="text" class="form-control" id="wTempH"  name="warehouseSaveReportFormMap.wTempH" value="" placeholder="最高温度">
   </div>
   </div>
   	 <div class="form-group col-md-3">
   <div class="has-warning">
   <input type="text" class="form-control" id="wTempL"  name="warehouseSaveReportFormMap.wTempL" value="" placeholder="最低温度">
   </div>
   </div>
     <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="wGrainInsect"  name="warehouseSaveReportFormMap.wGrainInsect" value="" placeholder="虫情数量">	
   </div>  
   </div> 
    <div class="form-group col-md-3">
   <div class="has-warning">
	<input type="text" class="form-control" id="wPestis"  name="warehouseSaveReportFormMap.wPestis" value="" placeholder="主要虫害">	
   </div>  
   </div>   
       <div class="form-group col-md-3">
   <div class="has-warning">
	<select id="selectPerson" data-rel="chosen" data-placeholder="保管员" name="warehouseSaveReportFormMap.person_id" style="width:100%">
   </select>	
   </div>  
   </div>   
      <div class="form-group col-md-12">
   
   <textarea id="wRemark"  name="warehouseSaveReportFormMap.wRemark">
   </textarea>
	
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
  <script type="text/javascript" src="${pageContext.servletContext.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/ueditor/ueditor.all.js"></script>
<script type="text/javascript">
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

UE.getEditor("wRemark");


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
