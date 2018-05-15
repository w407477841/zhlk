<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
<style>
.form-control{
padding: 0px 12px
}
.input_title_mine{ height: 30px}
</style>
    <div id="content" class="col-lg-12 col-sm-12">
            <!-- content starts -->
                <div>
        
    </div>
  <div class="row">
    <div class="box col-md-12">
    <div class="box-inner">
    <div class="box-header well" data-original-title="">
        <h2><i class="glyphicon glyphicon-list"></i> 业务结算</h2>

        <div class="box-icon">
            <a href="javascript:void(0)" class="btn btn-setting btn-round btn-default"><i class="glyphicon glyphicon-cog"></i></a>
            <a href="javascript:void(0)" class="btn btn-minimize btn-round btn-default"><i
                    class="glyphicon glyphicon-chevron-up"></i></a>
            <a href="javascript:void(0)" class="btn btn-close btn-round btn-default"><i class="glyphicon glyphicon-remove"></i></a>
        </div>
    </div>
    <div class="box-content" id="page">
    <div class="alert alert-info"> 
     <form class="form-inline" role="form" id="searchForm"name="searchForm">
      <input class="input_title_mine form-control" type="text" name=""  placeholder="流水单号">
      <input class="input_title_mine form-control" type="text" name=""  placeholder="货主">
      <div style="margin-top: 10px">
      		<select id="selectType" data-rel="chosen" name="" class="form-control" data-placeholder="结算类型"  style="width:100px">
					<option value="0"></option>
					<option value="1">已结算</option>
					<option value="2">未结算</option>
			</select>
			<select id="selectStatus" data-rel="chosen" name="" data-placeholder="结算状态" >
					<option value="0"></option>
					<option value="1">现金</option>
					<option value="2">转账</option>
			</select>
      </div>
    </form>
  <a class="btn btn-primary" href="javascript:void(0)" id="add" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-plus icon-white" ></i>
               		新增
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="edit" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-edit icon-white" ></i>
               		结算
            	</a>
            		<a class="btn btn-primary" href="javascript:void(0)" id="search" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-search icon-white" ></i>
               		查询
            	</a>
            	<a class="btn btn-primary" href="javascript:void(0)" id="export" style="text-shadow: black 5px 3px 3px;">
                <i class="glyphicon glyphicon-export icon-white" ></i>
               		导出
            	</a>
            	</div>
            <table id="magazineGrid"  style="width:99%;height:400px">
			</table>
			

    </div>
    </div>
    </div>
    <!--/span-->

    </div><!--/row-->
	</div>

	<div  id="paywayConfirm" style="display:none">
				<div class="form-group col-md-12">
					<div class="col-md-3 div_label">结算类型:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="settleType" data-rel="chosen" name="" data-placeholder="结算类型">
									       	<option value="1">现金</option>
		      				 	<option value="2" selected="selected">转账</option>
							</select>
						</div>
					</div>
				</div>
				<div id="_soh">
				<div class="form-group col-md-12">
					<div class="col-md-3 div_label">开户银行:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control inline_block "name=""  placeholder="开户银行">
						</div>
					</div>
				</div>

				<div class="form-group col-md-12">
					<div class="col-md-3 div_label">银行卡号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control inline_block"name="" placeholder="银行卡号">
						</div>
					</div>
				</div>
				</div>
</div>

 <style>
 *{box-sizing:border-box}
 .inline_block{
 display: inline-block;
 width: 300px;
 float: left
 }
 #settleWay label{ width: 100px;float: left;}
 #settleWay li{
 float: left;
 line-height: 50px;
 width: 100%
 }
 #settleType_chosen .chosen-single{width: 300px;height: 38px}
 #settleType_chosen{float:left}
 #paywayConfirm:after{content:'';display:block; content:"clear"; height:0; clear:both; overflow:hidden; visibility:hidden;}
#paywayConfirm{display: inline-block;vertical-align: middle;height: 100%;padding: 20 0}
.layui-layer-content:after{content:'';display: inline-block;vertical-align: middle;height: 100%;overflow: hidden;}
 </style> 
<script type="text/javascript" src="js/storage/fiancePayment.js"></script>
<script type="text/javascript">

$("#selectType, #selectStatus,#settleType").chosen({no_results_text : "未找到此选项!"});
$(".chosen-container").css("verticalAlign","top")
$(".chosen-single").css("height","30px").css("width","100px").css("borderRadius","4px")
$(".chosen-drop").css("width","100px");
$("#settleType_chosen > .chosen-single").css("height","38px").css("width","300px")
$("#settleType_chosen > .chosen-drop").css("width","300px");


		laydate({
			elem : '#start',
			event : 'focus'
		});
		laydate({
			elem : '#start1',
			event : 'focus'
		});


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

	$("#settleType").on("change",function(){
		if($(this).val()=="1"){	
		$("#_soh").css("visibility","hidden");
		}else{
		$("#_soh").css("visibility","visible");
		}
	})


</script>
