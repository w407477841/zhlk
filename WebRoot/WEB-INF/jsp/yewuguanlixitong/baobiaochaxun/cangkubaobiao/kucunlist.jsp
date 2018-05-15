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
        <h2><i class="glyphicon glyphicon-list"></i> 库存报表</h2>
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
     		
     		<div style="margin-bottom: 10px">
     		<input type="hidden" value="" name="StorageFormMap.location" id="location_p">
			<select id="location" data-rel="chosen"   data-placeholder="库点名称" >
				<option value="" > </option>
			</select>
			</div>
			
			
			<div style="margin-bottom: 10px">
			<select id="storageStation" data-rel="chosen" name="station" multiple="multiple" data-placeholder="所属粮站" >
				<option value="" selected="selected"> </option>
			</select>
			<input class="form-control" style="height: 30px;margin-left: 58px" name="StorageFormMap.title" placeholder="如东县粮食购销总公司" value="如东县粮食购销总公司"></input>
			</div>
			
<!-- 			<div style="width: 120px;float: left;">
			<select id="storageID" data-rel="chosen" name="StorageFormMap.storageID"  data-placeholder="所属仓库" >
				<option value="" selected="selected"> </option>
			</select>
			</div> -->
			
			<div style="width: 120px;float: left;">
			<select id="pack" data-rel="chosen" name="StorageFormMap.pack"  data-placeholder="包装方式" >
				<option value="" selected="selected"> </option>
				<option value="不包装" > 不包装</option>
				<option value="亚麻布包装" > 亚麻布包装</option>
				<option value="塑料袋包装" > 塑料袋包装</option>
				<option value="铁盒包装" > 铁盒包装</option>
			</select>
			</div>
			
<!-- 			<div style="width: 120px;float: left;">
			<select id="breed" data-rel="chosen" name="StorageFormMap.breed"  data-placeholder="品种" >
				<option value="" selected="selected"> </option>
			</select>
			</div> -->
			
			<div style="width: 120px;float: left;">
			<select id="property" data-rel="chosen" name="StorageFormMap.property"  data-placeholder="粮食性质" >
				<option value=""></option>
								<option value=""></option>
								<option  value="最低收购价粮">最低收购价粮</option>
								<option value="国家储备粮">国家储备粮</option>
								<option value="省级储备粮">省级储备粮</option>
								<option value="地市级储备粮">地市级储备粮</option>
								<option value="县级储备粮">县级储备粮</option>
								<option value="商品粮">商品粮</option>
								<option value="地方临时存储粮 ">地方临时存储粮 </option>
			</select>
			</div>
		<input type="text" id="start" name="StorageFormMap.times"  class="inline laydate-icon  form-control" placeholder="填报日期" style="margin-left: 50px">
		
    </form>
    
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


<script type="text/javascript" src="js/system/yewuguanlixiytong/baobiaochaxun/cangkubaobiao/kucunbaobiaolist.js"></script>
<script type="text/javascript">
laydate({elem : '#start',event : 'focus'});
initLocation();initBreed()
function initLocation() {
	$.ajax({
		url : rootPath + "/kcxx/contrastLocation.shtml",
		type : "post",
		async : false,
		data : {
			"source" : 1
		},
		success : function(rs) {
			var sel = document.getElementById("location");
			if (rs.success) {
				for ( var i = 0; i < rs.list.length; i++) {
					let ops=new Option(rs.list[i].code, rs.list[i].code);
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
					sel.add(new Option(rs.list[i].text, rs.list[i].text))
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
					sel.add(new Option(rs.list[i].text, rs.list[i].text))
				}
			}

		}
	})
}

$("#location").on("change",function(event) {
			var value = this.value;
			$.ajax({
				url : rootPath + "/kcxx/contrastStation.shtml",
				type : "post",
				async : false,
				data : {
					"location" : value
				},
				success : function(rs) {
					var sel = document.getElementById("storageStation");
					sel.innerHTML = "<option value=''></option>"
					$("#storageStation").chosen("destroy");
					if (rs.success) {
						var list=[];
						for ( var i = 0; i < rs.list.length; i++) {
							sel.add(new Option(rs.list[i].wName,rs.list[i].WNo));
							list.push(rs.list[i].WNo);
						}
						document.getElementById("location_p").value=list.join();
						$("#storageStation").chosen({
							no_results_text : "未找到此选项!",
							width : "100px"
						});
						
						
						$(".chosen-container-multi").css("minWidth","300px").css("width","auto")
						$(".chosen-choices").css("minHeight","28px").css("borderRadius","4px")
						$(".chosen-choices input").css("height","auto");
						$(".chosen-single").css("height", "32px").css("borderRadius", "4px");
					}
				}
			})
		});





/*  $("#storageStation").on("change",function(event) {
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
							sel.add(new Option(rs.result[i].wName,rs.result[i].id))
						}
						$("#storageID").chosen({
							no_results_text : "未找到此选项!",
							width : "100px"
						});
						
						$(".chosen-single").css("height", "32px").css("borderRadius", "4px");
					}
				}
			})
		});  */
$("#location,#pack,#property,#breed,#property,#storageStation,#storageID").chosen({no_results_text : "未找到此选项!"});
$(".chosen-container").css("verticalAlign","top")
$(".chosen-single").css("height","30px").css("width","100px").css("borderRadius","4px")
$(".chosen-drop").css("width","100px");
$(".chosen-container-multi").css("minWidth","300px").css("width","auto")
$(".chosen-choices").css("minHeight","28px").css("borderRadius","4px")
$(".chosen-choices input").css("height","auto");


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
