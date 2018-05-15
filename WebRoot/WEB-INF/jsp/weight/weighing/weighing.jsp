<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@include file="/common/common.jspf"%>
<script type="text/javascript">
	var rootPath = "${pageContext.servletContext.contextPath}";
</script>
<title>称重系统</title>
<style>
.row_border {
	border: 1px solid #f5f5f5;
	border-radius: 5px;
	padding-top: 10px;
}

.weight_num {
	height: 144px;
	background-color: #f5f5f5;
	line-height: 144px;
	font-size: xx-large;
	border-radius: 5px;
	margin-bottom: 10px;
}

.weight_font_red {
	font-family: "宋体";
	font-weight:bold;
	font-size:1.7em;
	color: red;
	text-align: center;
}
.weight_font_green {
	font-family: "宋体";
	font-weight:bold;
	font-size:1.7em;
	color: #00CD00;
	text-align: center;
}
.weight_font_black {
	font-family: "宋体";
	font-weight:bold;
	font-size:1.7em;
	color: black;
	text-align: center;
}

.no_left_padding {
	padding-left: 0;
}
.no_right_padding {
	padding-right: 0;
}
.no_padding{
    padding-left: 0;
    padding-right: 0; 
}

.error_color{
   background-color: #EE9A49;
   line-height: 30px;
   margin-bottom: 10px;
   border-radius:5px;
   font-weight: bold;
   text-align: center;
}
.error_color a{
color: white;
}
.btn_padding_weight{
   width: 100%;
}

.panel-body{
border-color: #dddddd;
}
.chosen-container-single .chosen-single{
	 height:38px;
}
</style>
<div class="row row_border">
<div class="col-md-12">
<div class="col-md-11" id="errorDiv">
</div>
<div class="col-md-1 no_padding" style="text-align: right; margin-bottom: 10px;">
 <button type="button" id="resetweighing" disabled="disabled" class="btn btn-default btn-sm" onclick="reset_weighing()">称重复位</button>
</div>
</div>
  <div class="col-md-3">
  <div class="col-md-12 no_padding" id="videoShowDiv2" style="padding-bottom: 20px;">
	<iframe src="${ctx }/weighing/showVideoIFrame.shtml" frameborder="0" width="100%" height="250px" z-index="1" onload="iframeLoaded();" ></iframe>
	</div>
  </div>
  <div class="col-md-6">
    <div class="col-md-12 no_padding weight_num">
		<div class="form-group col-md-12 ">
			<div class="col-md-4 no_padding weight_font_black" style="text-align: right;">重量：</div>
			<div class="col-md-5 no_padding weight_font_red" id="weighing">000000.00</div>
			<div class="col-md-3 no_padding weight_font_black" style="text-align: left;">KG</div>
		</div>
	</div>
	<div class="col-md-12 no_padding">
	    <input type="hidden" id="usedCarOrNot">
	    <input type="hidden" id="pictureNames">
	    <div class="col-md-12 no_padding">
		<div class="form-group col-md-4 no_padding">
			<div class="col-md-4 div_label">单据号：</div>
			<div class="col-md-8 no_padding">
				<input type="text" class="form-control" id="bill"  name="carFormMap.cId" onkeyup="find_data(this)">
			</div>
		</div>
		<div class="form-group col-md-4 no_padding">
		<div class="col-md-6 no_padding" style="text-align: right;">
		         <a class="btn btn-primary" href="javascript:void(0)" id="readCard" style="text-shadow: black 5px 3px 3px;">
                     <i class="glyphicon glyphicon-credit-card icon-white"></i> 一卡通
			    </a>
			</div>
			<div class="col-md-6 no_padding" style="text-align: right;">
			     <a class="btn btn-info" href="javascript:void(0)" id="bozai" style="text-shadow: black 5px 3px 3px;">
                     <i class="glyphicon glyphicon-transfer icon-white"></i> 驳载
			    </a>
			</div>
		</div>
		<div class="form-group col-md-4 no_padding">
			<div class="col-md-4 div_label">单位：</div>
			<div class="col-md-8 no_padding">
				<input type="text" id="userName" class="form-control">
			</div>
		</div>
	    </div>
		<div class="col-md-12 no_padding">
		<div class="form-group col-md-4 no_padding">
			<div class="col-md-4 div_label">车船号：</div>
			<div class="col-md-8 no_padding">
				<input type="text" id="shipId" class="form-control">
			</div>
		</div>
		<div class="form-group col-md-4 no_padding">
			<div class="col-md-4 div_label">司机姓名：</div>
			<div class="col-md-8 no_padding">
				<input type="text" id="driverName" class="form-control">
			</div>
		</div>
		<div class="form-group col-md-4 no_padding">
			<div class="col-md-4 div_label">驳车号：</div>
			<div class="col-md-8 no_padding">
				<select class="form-control" id="usedCar"  data-placeholder="请选择驳车号" onchange="find_used_car_info()">
				</select>
			</div>
		</div>
	    </div>
	</div>
	</div>
	<div class="col-md-3 " >
	<div class="col-md-12 no_padding" id="videoShowDiv" style="padding-bottom: 20px;">
	<iframe src="${ctx }/weighing/showVideoIFrame.shtml" frameborder="0" width="100%" height="250px" z-index="1" onload="iframeLoaded();" ></iframe>
	</div>
	</div>
	<div class="col-md-12" style="padding-bottom: 10px;">
	  <!-- 轮询称重 -->
		  <c:if test="${turnWeighing == '1' }">
		    <div class="col-md-4 no_left_padding">
				<button type="button" id="turnWeighing" disabled="disabled" class="btn btn-default btn-lg btn_padding_weight" onclick="weighing_turn_weight()">轮&nbsp;询&nbsp;称&nbsp;重</button>
			</div>
			<div class="col-md-4 no_left_padding">
				<button type="button" id="finishAndSave" disabled="disabled" class="btn btn-default btn-lg btn_padding_weight" onclick="weighing_end()">完&nbsp;成&nbsp;提&nbsp;交</button>
			</div>
		    <div class="col-md-4 no_padding">
				<button type="button" id="printbybill" disabled="disabled" class="btn btn-default btn-lg btn_padding_weight" onclick="printBill($('#bill').val())">打&nbsp;印&nbsp;凭&nbsp;证</button>
			</div>
		  </c:if>
		  <!-- 随机称重 -->
		 <c:if test="${turnWeighing == '2' }">
		    <div class="col-md-3 no_left_padding">
				<button type="button" id="maozhong" disabled="disabled" class="btn btn-default btn-lg btn_padding_weight" onclick="weighing_weight('1')">称&nbsp;毛&nbsp;重</button>
			</div>
			<div class="col-md-3 no_left_padding">
				<button type="button" id="pizhong" disabled="disabled" class="btn btn-default btn-lg btn_padding_weight" onclick="weighing_weight('2')">称&nbsp;皮&nbsp;重</button>
			</div>
			<div class="col-md-3 no_left_padding" >
				<button type="button" id="finishAndSave" disabled="disabled" class="btn btn-default btn-lg btn_padding_weight" onclick="weighing_end()">完&nbsp;成&nbsp;提&nbsp;交</button>
			</div>
		    <div class="col-md-3 no_padding">
				<button type="button" id="printbybill" disabled="disabled" class="btn btn-default btn-lg btn_padding_weight" onclick="printBill($('#bill').val())">打&nbsp;印&nbsp;凭&nbsp;证</button>
			</div>
		  </c:if>
	</div>
	<div class="col-md-12">
		<div class="tabbable" id="tabs-435228">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#panel-861281" data-toggle="tab" onclick="div_show()">散户称重记录</a>
				</li>
				<li><a href="#panel-891936" data-toggle="tab" onclick="div_hide()">驳载称重记录</a></li>
			</ul>
			<div class="tab-content div_table">
				<div id="panel-861281">
					<div class="table_pane">
						<table id="retailGrid"  style="width:100%;min-height:310px; max-height: 400px;">
						</table>
					</div>
				</div>
				<div id="panel-891936">
					<div class="table_pane">
						<table id="usedCarGrid"  style="width:100%;min-height:310px; max-height: 400px;">
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function div_show(){
	$("#panel-891936").hide();
	$("#panel-861281").show();
}
function div_hide(){
	$("#panel-891936").show();
	$("#panel-861281").hide();
}

$("#bill").focus();
</script>

<script src="${ctx }/js/system/weight/weighing/weighinglist.js"></script>

<script type="text/javascript">
//$('[data-rel="chosen"],[rel="chosen"]').chosen();
    //LED屏
	(function() {
		$.ajax({
			async : false,
			type : 'GET',
			dataType : 'jsonp',
			url : 'http://127.0.0.1:9898/websocket/websocket/initTextToLED',
			error : function() {
				//alert("网络配置失败");
			}
		});
	})();
	(function() {
		var url1 = 'ws://localhost:9898/websocket/weighbridge';
		//var url2 = 'ws://localhost:9898/websocket/sockjs/weighbridge';
		var websocket = new WebSocket(url1);
		//if(window.WebSocket){
		//	 websocket = new WebSocket(url1);
		//}else{
		//	websocket =  new SockJS(url2);
		//}
		websocket.onopen = function(evnt) {
			//console.log(evnt);
		};
		websocket.onmessage = function(evnt) {
			var obj = document.getElementById("weighing");
			if(obj !=null && obj !='ERROR'){
				$("#weighing").removeClass("weight_font_red").addClass("weight_font_green");
				obj.innerHTML = evnt.data;
			}else{
				$("#weighing").removeClass("weight_font_green").addClass("weight_font_red");
			}
		};
		websocket.onerror = function(evnt) {
			$("#weighing").removeClass("weight_font_green").addClass("weight_font_red");
			$("#weighing").html("ERROR");
			showOPInfo("地磅连接错误！");
		};
		websocket.onclose = function(evnt) {
			$("#weighing").removeClass("weight_font_green").addClass("weight_font_red");
		};
	})();
</script>
<script type="text/javascript">
$("#readCard").click("click",function(){
	ReadOneCard_onclick();
});
$("#bozai").click("click",function(){
	ReadRFIDCard();
});


/**
 * 根据单据号查找信息
 */
function find_data(){
	var bId = $("#bill").val();
	if(bId.length == 12){
		find_reportHarbor(bId);
	}else if(bId.length == 16){
		find_car_info(bId);
	}
	else{
		$("#userName").val("");
		$("#shipId").val("");
		$("#usedCarOrNot").val("");
		$("#driverName").val("");
		$("#pictureNames").val("");
		$("#usedCar").find("option").remove();
		
		btn_hide($("#pizhong"),"btn-info");
		btn_hide($("#maozhong"),"btn-primary");
		btn_hide($("#finishAndSave"),"btn-success");
		
		btn_hide($("#printbybill"),"btn-warning");
		btn_hide($("#turnWeighing"),"btn-info");
		
		btn_hide($("#resetweighing"),"btn-danger");
	}
}

/**
 * 根据车辆RFID/二维码获取信息
 */
 
 var carData;
 var selectCarText = '';
function find_car_info(rfid){
	$.ajax({
		type:'post',
		dataType:'json',
		data:{rfid:rfid},
		url:rootPath+'/car/findByRFID.shtml',
		success:function(data){
			if(data != null){
				var bId = data.bId;
				$("#bill").val(bId);
				selectCarText = data.cId;
				$("#driverName").val(data.driver);
				find_reportHarbor(bId);
			}else{
				layer.alert("获取信息失败！",{icon: 5});
				clear();
			}
		},
		error:function(data){
			layer.alert("获取信息失败！",{icon: 5});
			clear();
		}
	});
}

/**
 * 根据单据号查找报港信息
 */
function find_reportHarbor(bId){
	$.ajax({
		type:'post',
		dataType:'json',
		data:{bId:bId},
		url:rootPath+'/reportHarbor/findByBId.shtml',
		success:function(data){
			if(data != null){
				$("#userName").val(data.userName);
				$("#shipId").val(data.shipId);
				var totalWeight = data.totalWeight;
				var usedCar = data.usedCar;
				$("#usedCarOrNot").val(usedCar);
				
				if(totalWeight != null){ //称重流程已经完成
					hide_all_btn();
					btn_show($("#printbybill"),"btn-warning");
				}else{
					if(usedCar == '1'){//驳车
						
						hide_all_btn();
				    	btn_show($("#pizhong"),"btn-info");
				    	btn_show($("#maozhong"),"btn-primary");
				    	btn_show($("#turnWeighing"),"btn-info");
				    	
				    	find_weighing_by_bId(bId);
						find_usedCar(bId);
					}else{ //不驳车，自动轮询称重
						var obj = $("#usedCar");
						$(obj).find("option").remove(); 
						$(obj).append("<option value='-1'>未启动驳车</option>");
						
						//1:出库，2：入库
						var inOrOut = data.inOrOut;
						findWeighingByBId(inOrOut,bId);
					}
				}
				
				
			}else{
				layer.alert("获取信息失败！",{icon: 5});
				clear();
			}
		},
		error:function(data){
			layer.alert("获取信息失败！",{icon: 5});
			clear();
		}
	});
}
/**
 * 根据单据号查找称重信息
 * 只针对散户，根据称重信息获取其称重按钮显示/隐藏
 */
function findWeighingByBId(inOrOut,bId){
	$.ajax({
		type:'post',
		dataType:'json',
		data:{bId:bId},
		url:rootPath+'/weighing/findWeighingByBId.shtml',
		success:function(data){
			if(data == null || data == ''){ //未进行称重操作
				if(inOrOut == '1'){//出库，先皮--后毛
					hide_all_btn();
					btn_show($("#pizhong"),"btn-info");
					btn_show($("#turnWeighing"),"btn-info");
				}else{//入库，先毛---后皮
					hide_all_btn();
			    	btn_show($("#maozhong"),"btn-primary");
			    	btn_show($("#turnWeighing"),"btn-info");
				}
			}else{ //进行称重操作
				var weighingObj = data[0];
			    var grossweight = weighingObj.grossWeight;
			    var tare = weighingObj.tare;
			    if(grossweight == null){//未称毛重
			    	hide_all_btn();
			    	btn_show($("#maozhong"),"btn-primary");
			    	btn_show($("#turnWeighing"),"btn-info");
			    	
			    	btn_show($("#resetweighing"),"btn-danger");
			    }else if(tare == null){//未称皮重
			    	hide_all_btn();
					btn_show($("#pizhong"),"btn-info");
					btn_show($("#turnWeighing"),"btn-info");
					
					btn_show($("#resetweighing"),"btn-danger");
			    }else{//称重完成
			    	hide_all_btn();
			    	btn_show($("#printbybill"),"btn-warning");
			    }
			}
		}
	});
}
/**
 * 根据单据号查找车辆信息
 */
function find_usedCar(bId){
	$.ajax({
		type:'post',
		dataType:'json',
		data:{bId:bId},
		url:rootPath+'/car/findUsedCarByBId.shtml',
		success:function(data){
			carData = data;
			var obj = $("#usedCar");
			$(obj).find("option").remove(); 
			$(obj).append("<option value='-1'>--驳车信息--</option>");
			if(data != null && data.length>0){
				for(var i=0;i<data.length;i++){
					if(selectCarText == data[i].cId){
						$(obj).append("<option value='"+data[i].id+"' selected='selected'>"+data[i].cId+"</option>");
					}else{
						$(obj).append("<option value='"+data[i].id+"'>"+data[i].cId+"</option>");
					}
					
				}
			}else{
				$(obj).find("option").remove();
				$(obj).append("<option value='-1'>未分配驳车</option>");
			}
		}
	});
}
/**
 * 驳车--根据bId判断是否有称重信息，来确定能否进行完成提交和复位称重
 */
function find_weighing_by_bId(bId){
	$.ajax({
		type:'post',
		dataType:'json',
		data:{bId:bId},
		url:rootPath+'/weighing/findWeighingByBId.shtml',
		success:function(data){
			if(data != null && data.length>0){
				btn_show($("#finishAndSave"),"btn-success");
		    	btn_show($("#resetweighing"),"btn-danger");
			}
		}
	});
}

//读取一卡通
function ReadOneCard_onclick(){
	$.ajax({
		async:false,
		type:'GET',
		dataType:'jsonp',
		url:'http://127.0.0.1:9898/websocket/websocket/OneCard',
		jsonpCallback:"oneCardCallback",
		error:function(){
			layer.alert("网络配置失败！",{icon: 5});
		}
	});	
}
//回调函数
function oneCardCallback(data){
	if(data.result == 'success'){
		findCardId(data.oneCard);
	}else{
		layer.alert(data.result,{icon: 5});
	}
}
//根据读取一卡通获取报港信息
function findCardId(oneCard){
	$.ajax({
		type:'post',
		dataType:'json',
		url:'${ctx}/reportHarbor/findByCardId.shtml',
		data:{cardId:oneCard},
		success:function(data){
			if(data == null || data == ''){
				layer.alert("获取信息失败！",{icon: 5});
				clear();
			}else{
				$("#bill").val(data.bId);
				//根据单据号进行数据读取
				find_data();
			}
		},
		error:function(data){
			layer.alert("获取信息失败！",{icon: 5});
			clear();
		}
	});
}
//读取RFID卡
function ReadRFIDCard(){
	$.ajax({
		async:false,
		type:'GET',
		dataType:'jsonp',
		url:'http://127.0.0.1:9898/websocket/websocket/readerRFID',
		jsonpCallback:"rfidCardCallback",
		error:function(){
			//ReadOneCard_onclick();
			layer.alert("网络配置失败！",{icon: 5});
		}
	});	
}
//RFID卡回调函数
function rfidCardCallback(data){
	if(data.result == 'success'){
		if(data.rfidCard == null || data.rfidCard == ''){
			//ReadOneCard_onclick();
			layer.alert(data.result,{icon: 5});
		}else{
		   find_car_info(data.rfidCard);			
		}
	}else{
		//ReadOneCard_onclick();
		layer.alert(data.result,{icon: 5});
	}
}

/**
 * 根据选中的车牌号进行车辆信息查询
 */
function find_used_car_info(){
	var selectVal = $("#usedCar").val();
	if(selectVal != '-1'){
		if(carData != null && carData.length>0){
			for(var i = 0;i<carData.length;i++){
				if(selectVal ==  carData[i].id){
					$("#driverName").val(carData[i].driver);
					break;
				}
			}
		}else{
			$("#driverName").val("");
		}
	}else{
		$("#driverName").val("");
	}
	
}
/**
 * 随机称重
 * type:1 -- 称毛重
 * type:2 -- 称皮重
 */
function weighing_weight(type){
	var bill = $("#bill").val();
	var usedCar = $("#usedCar").val();
	var userName = $("#userName").val();
	var usedCarText = $("#usedCar :selected").text();
	var weight = $("#weighing").text();
	var usedCarOrNot = $("#usedCarOrNot").val();
	var printType = '${printType}';
	if(bill == null || bill == ''){
		layer.alert("单据号为空！",{icon: 7});
	}else if(bill.length != 12){
		layer.alert("单据号有误！",{icon: 7});
	}else if(weight == null || weight == '' || weight == 'ERROR'){
		layer.alert("称重数据有误！",{icon: 7});
	}else if(usedCarOrNot == '1' && usedCar == '-1'){
		layer.alert("选择驳车信息！",{icon: 7});
	}else{
		//语音播报时车牌号处理
		var CarText = usedCarOrNot == '1'?usedCarText:$("#shipId").val();
		
		var txt = type == '1'?'毛重':'皮重';
		layer.confirm('<h1>'+txt+'：<font color="red">'+weight+'</font> kg</h1>', function(index) {
			//称重视频截图
			clickCapturePicture(bill);
	        var pictureNames = $("#pictureNames").val();
			$.ajax({
				type:'post',
				dataType:'json',
				url:rootPath+'/weighing/addWeightingweight.shtml',
				data:{bill:bill,usedCarText:usedCarText,weight:weight,type:type,usedCarOrNot:usedCarOrNot,printType:printType,pictureNames:pictureNames},
				success:function(data){
					if(data == 'error'){
						layer.close(index);
						layer.alert("称重失败!",{icon: 5});
					}else if(data == 'success'){
						speckText(userName,txt,weight,CarText);
						showToLED(userName,txt,weight,CarText);
						layer.close(index);
						layer.alert("称重成功",{icon: 6});
					}else{
						speckText(userName,txt,weight,CarText);
						showToLED(userName,txt,weight,CarText);
						layer.close(index);
						my_print(data.substring(6));
					}
				},
				error:function(data){
					layer.close(index);
					layer.alert("称重失败!",{icon: 5});
				}
				
			});
			
		});	
		clear();
	}
}
//轮询称重
function weighing_turn_weight(){
	var bill = $("#bill").val();
	var usedCar = $("#usedCar").val();
	var userName = $("#userName").val();
	var usedCarText = $("#usedCar :selected").text();
	var weight = $("#weighing").text();
	var usedCarOrNot = $("#usedCarOrNot").val();
	var printType = '${printType}';
	if(bill == null || bill == ''){
		layer.alert("单据号为空！",{icon: 7});
	}else if(bill.length != 12){
		layer.alert("单据号有误！",{icon: 7});
	}else if(weight == null || weight == '' || weight == 'ERROR'){
		layer.alert("称重数据有误！",{icon: 7});
	}else if(usedCarOrNot == '1' && usedCar == '-1'){
		layer.alert("选择驳车信息！",{icon: 7});
	}else{
		var txt = find_weight_grossOrtare(bill,usedCarText);
		
		if(txt == '' || txt == undefined){
			layer.alert("称重出错！",{icon: 7});
		}else{
			var CarText = usedCarOrNot == '1'?usedCarText:$("#shipId").val();
			
			layer.confirm('<h1>'+txt+'：<font color="red">'+weight+'</font> kg</h1>', function(index) {
				//称重视频截图
				clickCapturePicture(bill);
		        var pictureNames = $("#pictureNames").val();
				$.ajax({
					type:'post',
					dataType:'json',
					url:rootPath+'/weighing/addWeighingTurnWeight.shtml',
					data:{bill:bill,usedCarText:usedCarText,weight:weight,printType:printType,pictureNames:pictureNames},
					success:function(data){
						if(data == 'error'){
							layer.close(index);
							layer.alert("称重失败!",{icon: 5});
						}else if(data == 'success'){
							speckText(userName,txt,weight,CarText);
							showToLED(userName,txt,weight,CarText);
							layer.close(index);
							layer.alert("称重成功",{icon: 6});
						}else{
							speckText(userName,txt,weight,CarText);
							showToLED(userName,txt,weight,CarText);
							layer.close(index);
							my_print(data.substring(6));
						}
					},
					error:function(data){
						layer.close(index);
						layer.alert("称重失败!",{icon: 5});
					}
					
				});
				
			});	
		}
		
		clear();
	}
}
//查找是称毛重还是皮重
function find_weight_grossOrtare(bId,carId){
	var rtn ='';
	$.ajax({
		type:'post',
		dataType:'json',
		async:false,
		url:rootPath+'/weighing/findWeighingByBidAndCarId.shtml',
		data:{bId:bId,carId:carId},
		success:function(data){
			rtn =  data;
		}
	});
	return rtn;
}

//查找是清除毛重还是皮重
function reset_weight_grossOrtare(bId,carId){
	var rtn ='';
	$.ajax({
		type:'post',
		dataType:'json',
		async:false,
		url:rootPath+'/weighing/resetLastWeighingByBidAndCarId.shtml',
		data:{bId:bId,carId:carId},
		success:function(data){
			rtn =  data;
		}
	});
	return rtn;
}
//完成提交----驳车数据
var pageii;
function weighing_end(){
	var bill = $("#bill").val();
	if(bill == null || bill == ''){
		layer.alert("单据号为空！",{icon: 7});
	}else{
		pageii = layer.open({
			title : "<h5><i class='glyphicon glyphicon-link'></i>新增<h5>",
			type : 2,
			maxmin :true,
			area : [ "400px", "500px"],
			offset:["100px", "50px"],
			content : rootPath + '/weighing/addFootGrainUI.shtml?bId='+bill,
			end :function(){
				clear();
			}
		});
	}
}

//复位称重
function reset_weighing(){
	var bill = $("#bill").val();
	var usedCar = $("#usedCar").val();
	var usedCarOrNot = $("#usedCarOrNot").val();
	var usedCarText = $("#usedCar :selected").text();
	if(bill == null || bill == ''){
		layer.alert("单据号为空！",{icon: 7});
	}else if(bill.length != 12){
		layer.alert("单据号有误！",{icon: 7});
	}else if(usedCarOrNot == '1' && usedCar == '-1'){
		layer.alert("选择驳车信息！",{icon: 7});
	}else{
		var rutn = reset_weight_grossOrtare(bill,usedCarText);
		if(rutn == '' || rutn == undefined || rutn=='error'){
			layer.alert("称重复位出错！",{icon: 7});
		}else{
			layer.confirm('<h2><font color="red">称重复位：'+rutn+'</font></h2>', function(index) {
				layer.confirm('<font color="red">数据将会擦出！</font>',{icon: 7},function(){
					$.ajax({
						type:'post',
						dataType:'json',
						url:rootPath+'/weighing/resetWeighing.shtml',
						data:{bill:bill,usedCarText:usedCarText},
						success:function(data){
							if(data == 'error'){
								layer.alert("称重复位出错！",{icon: 7});
							}else{
								layer.alert("称重复位:"+data+"成功！",{icon:6});
							}
						},
						error:function(data){
							layer.alert("称重复位出错！",{icon: 7});
						}
					});
				});
				
			});
		}
		
		clear();
	}
}

/**
 * 打印
 */
function my_print(num){
	
	if(num != null && num.length == 12){
		printBill(num);
	}else{
		layer.alert("打印凭证："+num);
	}
}


function clear(){
	$("#bill").val("");
	$("#userName").val("");
	$("#shipId").val("");
	$("#usedCarOrNot").val("");
	$("#driverName").val("");
	$("#pictureNames").val("");
	$("#usedCar").find("option").remove();
	
	btn_hide($("#pizhong"),"btn-info");
	btn_hide($("#maozhong"),"btn-primary");
	btn_hide($("#finishAndSave"),"btn-success");
	
	btn_hide($("#printbybill"),"btn-warning");
	btn_hide($("#turnWeighing"),"btn-info");
	
	btn_hide($("#resetweighing"),"btn-danger");
}

function hide_all_btn(){
	btn_hide($("#pizhong"),"btn-info");
	btn_hide($("#maozhong"),"btn-primary");
	btn_hide($("#finishAndSave"),"btn-success");
	
	btn_hide($("#printbybill"),"btn-warning");
	btn_hide($("#turnWeighing"),"btn-info");
	
	btn_hide($("#resetweighing"),"btn-danger");
}

/**
 * 显示按钮
 */
function btn_show(obj,style){
	$(obj).removeAttr("disabled");
	$(obj).removeClass("btn-default");
	$(obj).addClass(style);
}
/**
 * 隐藏按钮
 */
function btn_hide(obj,style){
	$(obj).attr("disabled","disabled");
	$(obj).removeClass(style);
	$(obj).addClass("btn-default");
}
/**
 * 语音播报
 */
function speckText(userName,weighingType,weighing,carId){
	//#[userName]  -- 客户姓名
	//#[weighingType]  -- 称重类型：皮重，毛重
	//#[weight]  -- 称重数量
	//#[carId] -- 车牌号，未驳车的代表车船号
	var content = '${weighingSpeckConfig.content}';
	content = content.replace("#[userName]", userName).replace("#[weighingType]", weighingType).replace("#[weight]", weighing).replace("#[carId]", carId);
	var isOpen = '${weighingSpeckConfig.isOpen}';
	if(isOpen == '1'){
		var speechRate='${weighingSpeckConfig.speechRate}';
		var url = "http://tts.baidu.com/text2audio?lan=zh&ie=UTF-8&spd="+speechRate+"&text=" + encodeURI(content);
	    var n = new Audio(url);
	    n.src = url;
	    n.play();
	}
 }
 
 function showToLED(userName,weighingType,weighing,carId){
	 $.ajax({
			async : false,
			type : 'GET',
			dataType : 'jsonp',
			url : 'http://127.0.0.1:9898/websocket/websocket/sendTextToLED',
			data:{userName:userName,weighingType:weighingType,weighing:weighing,carId:carId},
			error : function() {
				//alert("网络配置失败");
			}
		});
 }
 
 
 function printBill(bId){
	 clear();
	 $.ajax({
			type:'post',
			dataType:'json',
			url:rootPath+'/reportHarbor/findDetailByBill.shtml',
			data:{bId:bId},
			success:function(data){
				if(data != null){
					myPrint(data);
				}else{
					layer.alert("打印异常！",{icon: 7});
				}
			},
			error:function(data){
				layer.alert("打印异常！",{icon: 7});
			}
	 });
	 
	 
 }
</script>
<script type="text/javascript" src="${ctx}/js/LodopFuncs.js">
</script>
<script type="text/javascript" src="${ctx }/js/system/weight/print/print.js"></script> 
<script type="text/javascript" src="${ctx }/js/webVideoCtrl.js"></script>
<script type="text/javascript">
(function(){
	var mac = '${mac_addr}';
	if(mac == null || mac == ''){
		layer.alert('未获得本机MAC地址，请查看本机程序是否运行！若未启动，请启动后重新登录！',{icon:7});
	}
})();
g_aIframe = $("iframe");
$(function () {
	// 检查插件是否已经安装过
    var iRet = WebVideoCtrl.I_CheckPluginInstall();
	if (-2 == iRet) {
		layer.alert("您的Chrome浏览器版本过高，不支持NPAPI插件！",{icon: 7});
		return;
	} else if (-1 == iRet) {
		$("#videoShowDiv").empty();
		$("#videoShowDiv").addClass("error_color");
		$("#videoShowDiv").html("<a href='${ctx}/codebase/WebComponentsKit.exe'>还未装插件，请点击下载,安装完后重新打开浏览器</a>");
		$("#videoShowDiv2").empty();
		$("#videoShowDiv2").addClass("error_color");
		$("#videoShowDiv2").html("<a href='${ctx}/codebase/WebComponentsKit.exe'>还未装插件，请点击下载,安装完后重新打开浏览器</a>");
		return;
    }	

	// 关闭浏览器
	$(window).unload(function () {
		$.each(g_aIframe, function (i, oIframe) {
            getWebVideoCtrl(oIframe).I_Stop();
        });
	});
});
var iLoadedCount = 0;
//视频配置数据
var videoConfigStr = '${jsonData}';

function iframeLoaded() {
    iLoadedCount++;
    if (2 === iLoadedCount) {
    	if(videoConfigStr == null || videoConfigStr == ''){
    		$("#videoShowDiv").empty();
    		$("#videoShowDiv").addClass("error_color");
    		$("#videoShowDiv").html("<font color='white'>暂无视频配置信息</font>");
    		$("#videoShowDiv2").empty();
    		$("#videoShowDiv2").addClass("error_color");
    		$("#videoShowDiv2").html("<font color='white'>暂无视频配置信息</font>");
    	}else{
    		var videoConfig = eval("("+videoConfigStr+")");
    		if(videoConfig.length == 1){ //当只配置一个视频通道时，两个显示相同
    			//当其ip设置未空时，说明只是配置是否轮询，并未配置视频信息
    			if(videoConfig[0].ipAddr == null || videoConfig[0].ipAddr == ''){
    				$("#videoShowDiv").empty();
    	    		$("#videoShowDiv").addClass("error_color");
    	    		$("#videoShowDiv").html("<font color='white'>暂无视频配置信息</font>");
    			}else{
    				$.each(g_aIframe, function (i, oIframe) {
        	            var oWebVideoCtrl = getWebVideoCtrl(oIframe);
        	            // 登录设备
        	            oWebVideoCtrl.I_Login(videoConfig[0].ipAddr, 1, videoConfig[0].ipPort, videoConfig[0].userName, videoConfig[0].password, {
        	                success: function (xmlDoc) {
        	                    // 开始预览
        	                    oWebVideoCtrl.I_StartRealPlay(videoConfig[0].ipAddr, {
        	                        iStreamType: 1,
        	                        iChannelID: parseInt(videoConfig[0].throughPort)-31,
        	                        bZeroChannel:false
        	                    });
        	                }
        	            });
        	        });
    			}
    		}else if(videoConfig.length >1){ //当配置多个视频通道时，只显示前两个
    			$.each(g_aIframe, function (i, oIframe) {
    	            var oWebVideoCtrl = getWebVideoCtrl(oIframe);
    	            // 登录设备
    	            oWebVideoCtrl.I_Login(videoConfig[i].ipAddr, 1, videoConfig[i].ipPort, videoConfig[i].userName, videoConfig[i].password, {
    	                success: function (xmlDoc) {
    	                    // 开始预览
    	                    oWebVideoCtrl.I_StartRealPlay(videoConfig[i].ipAddr, {
    	                        iStreamType: 1,
    	                        iChannelID: parseInt(videoConfig[i].throughPort)-31,
    	                        bZeroChannel:false
    	                    });
    	                }
    	            });
    	        });
    		}
    	}
    }
}
/**
 * 抓图
 */
function clickCapturePicture(bill){
	if(videoConfigStr != null && videoConfigStr != ''){
		var videoConfig = eval("("+videoConfigStr+")");
		//配置截图路径
		var screenshotPath = videoConfig[0].screenshotPath;
		//alert(screenshotPath);
		if(screenshotPath == undefined || screenshotPath == ''){
			showOPInfo("未配置截图路径！");
		}else{
			clickSetLocalCfg(screenshotPath);
			if(videoConfig.length == 1){
				$.each(g_aIframe, function (i, oIframe) {
		            var oWebVideoCtrl = getWebVideoCtrl(oIframe);
		            var szPicName = bill+ "_" + new Date().getTime();
		            var iRet = oWebVideoCtrl.I_CapturePic(szPicName);
		            if(iRet == 0){
		            	$("#pictureNames").val(dateFormat(new Date(), "yyyy-MM-dd")+"/"+szPicName+".jpg");
		            }
				});
				
			}else{
				$.each(g_aIframe, function (i, oIframe) {
		            var oWebVideoCtrl = getWebVideoCtrl(oIframe);
	                var szPicName = bill+ "_" + new Date().getTime();
					
	                var iRet = oWebVideoCtrl.I_CapturePic(szPicName);
		            if(iRet == 0){
		            	if($("#pictureNames").val() ==  null || $("#pictureNames").val() ==''){
		            	   $("#pictureNames").val(dateFormat(new Date(), "yyyy-MM-dd")+"/"+szPicName+".jpg");	            		
		            	}else{
		            	  $("#pictureNames").val($("#pictureNames").val()+";"+dateFormat(new Date(), "yyyy-MM-dd")+"/"+szPicName+".jpg");	            		
		            	}
		            }
				});
			}
			
			clickCapturePicTransform();
		}
		
	}
}
function getWebVideoCtrl(oIframe) {
    return oIframe.contentWindow.WebVideoCtrl;
}
//显示操作信息
function showOPInfo(szInfo) {
	szInfo = "<div>" + dateFormat(new Date(), "yyyy-MM-dd hh:mm:ss") + " " + szInfo + "</div>";
	//layer.alert(szInfo);
	$("#errorDiv").addClass("error_color");
	$("#errorDiv").html("<font color='white'>"+szInfo+"</font>");
}
//格式化时间
function dateFormat(oDate, fmt) {
	var o = {
		"M+": oDate.getMonth() + 1, //月份
		"d+": oDate.getDate(), //日
		"h+": oDate.getHours(), //小时
		"m+": oDate.getMinutes(), //分
		"s+": oDate.getSeconds(), //秒
		"q+": Math.floor((oDate.getMonth() + 3) / 3), //季度
		"S": oDate.getMilliseconds()//毫秒
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (oDate.getFullYear() + "").substr(4 - RegExp.$1.length));
	}
	for (var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}
//设置本地参数
function clickSetLocalCfg(screenshotPath) {
	screenshotPath = screenshotPath.replace(/\//g, "\\");

	var arrXml = [];
	arrXml.push("<LocalConfigInfo>");
	arrXml.push("<CapturePath>"+ screenshotPath +"</CapturePath>");
	arrXml.push("</LocalConfigInfo>");
	$.each(g_aIframe, function (i, oIframe) {
        getWebVideoCtrl(oIframe).I_SetLocalCfg(arrXml.join(""));
    });
}
//将截图图片上传到服务器
function clickCapturePicTransform() {
	var imageNames = $("#pictureNames").val();
	if(imageNames != null && imageNames != ''){
		$.ajax({
			async : false,
			type : 'GET',
			dataType : 'jsonp',
			url : 'http://127.0.0.1:9898/websocket/websocket/sendImageToServer',
			data:{imageNames:imageNames},
			error : function() {
				//alert("网络配置失败");
			}
		});
	}
}
</script>

