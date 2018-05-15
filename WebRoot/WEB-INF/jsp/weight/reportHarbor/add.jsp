<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/common/common.jspf"%>
	 <style type="text/css">
	 .chosen-container-single .chosen-single{
	 height:37px;
	 }
	 .title_header_label{
	  padding: 0 0 0 0;
	  border-left:1px #ffffff solid;
	  border-right:1px #ffffff solid;
	  text-align:center;
	  height:35px;
	  line-height:35px;
	  background-color: #D1D1D1;
	 }
	 </style>
</head>
<body style="background-color:#d9edf7">
<div class=" col-md-12"><div class=" col-md-6">  <h3 class="animated rubberBand">报港信息</h3> </div>   </div> 
<div class=" col-md-12"><div class=" col-md-6">  <h4 class="animated rubberBand">基础信息</h4> </div>   </div>
<form id="form" name="form" method="post" action="${ctx}/reportHarbor/add.shtml">
<input type="hidden" name="token" value="${token }">
<input type="hidden" name="reportHarborFormMap.inOrOut" value="${inOrOut }">
<div class=" col-md-12"> 
     <div class="form-group col-md-6">
     <div class="col-md-2 div_label">身份证</div>
   <div class="col-md-8">
   <div class="has-warning">
	<input type="text" class="form-control easyui-validatebox" id="idCard"  validType="IDCard" invalidMessage="请输入正确的身份证号"  onblur="find_Message(this)" name="reportHarborFormMap.IDCard" placeholder="请输入 ：身份证" maxlength="18">	
   </div>  
   </div>
   <div class="col-md-2">
   <button type="button" class="btn btn-primary" onclick="ReadIDCard_onclick()">读卡</button>
   </div>
   </div>
   
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">单位<span>*</span></div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control easyui-validatebox" missingMessage="请输入单位" data-options="required:true" id="userName" name="reportHarborFormMap.userName" placeholder="请输入 ：单位" maxlength="16">
   </div> 
   </div>
   </div> 
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">联系电话</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="phoneNumber" onblur="find_Message(this)" name="reportHarborFormMap.phoneNumber" placeholder="请输入 ：联系电话" maxlength="16">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">联系地址</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="address" placeholder="请输入 ：联系地址" name="reportHarborFormMap.address" maxlength="64">
    </div> 
   </div>
   </div> 
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">车船号<span>*</span></div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control easyui-validatebox" missingMessage="请输车船号" data-options="required:true" name="reportHarborFormMap.shipId" placeholder="请输入 ：车船号" maxlength="16" >
   </div> 
   </div>
   </div> 
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">一卡通</div>
   <div class="col-md-8">
    <div class="has-warning">
    <input type="text" class="form-control" id="oneCard" name="reportHarborFormMap.cardId" placeholder="请输入 ：一卡通" maxlength="32" ${usedOrNot == '1'?'':'disabled="disabled"' }>
   </div> 
   </div>
   <div class="col-md-2">
   <button type="button" class="btn btn-primary" onclick="ReadOneCard_onclick()" ${usedOrNot == '1'?'':'disabled="disabled"' }>读卡</button>
   </div>
   </div> 
  <div class="form-group col-md-6">
   <div class="col-md-2 div_label">粮库地点<span>*</span></div>
   <div class="col-md-10">
   <div class="has-warning">
   <select class="form-control" id="warehouseLocation" data-rel="chosen"  data-placeholder="请选择粮库地点"  >
   </select>	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">仓号<span>*</span></div>
   <div class="col-md-10">
   <div class="has-warning">
	<select class="form-control" id="warehouseName" name="reportHarborFormMap.wId" data-rel="chosen"  data-placeholder="请选择仓号"  >
   </select>	
   </div>  
   </div>
   </div>   
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">粮食品种</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="variety" name="reportHarborFormMap.grainVariety" readonly="readonly">
   </div> 
   </div>
   </div> 
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">粮食性质</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="property" name="reportHarborFormMap.grainProperty"  readonly="readonly">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">是否驳车</div>
   <div class="col-md-10">
   <div class="has-warning">
	<select class="form-control" id="usedCar" name="reportHarborFormMap.usedCar" data-rel="chosen"  data-placeholder="请选择是否驳车"  >
	<option value="2">不驳车</option>
	<option value="1">驳车</option>
   </select>	
   </div>  
   </div>
   </div>   
  	</div>
  	<div class=" col-md-12"><div class=" col-md-6">  <h4 class="animated rubberBand">质检信息</h4> </div>   </div>
   <div class="form-group col-md-12">
    <div class="col-md-12">
    <div class="col-md-1 title_header_label">容重|出糙</div>
    <div class="col-md-1 title_header_label">水分</div>
    <div class="col-md-1 title_header_label">杂质</div>
    <div class="col-md-1 title_header_label">其中矿物质 </div>
    <div class="col-md-1 title_header_label">不完善粒度</div>
    <div class="col-md-1 title_header_label">整精米粒</div>
    <div class="col-md-1 title_header_label">谷外糙米</div>
    <div class="col-md-1 title_header_label">黄粒米</div>
    <div class="col-md-1 title_header_label">互混</div>
    <div class="col-md-1 title_header_label">赤霉病粒</div>
    <div class="col-md-1 title_header_label">硬度指数</div>
    <div class="col-md-1 title_header_label">色泽气味</div>
    </div>
    <div class="form-group col-md-12">
    <div class="col-md-1 title_header_label">
     <input type="text" id="01or02" class="form-control" name="qualityCheckFormMap.rz" value="0.0" readonly="readonly" onblur="onChange_price(this)" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="03" class="form-control" name="qualityCheckFormMap.sf" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('03')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="04" class="form-control" name="qualityCheckFormMap.zz" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('04')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="05" class="form-control" name="qualityCheckFormMap.kwz" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('05')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="06" class="form-control" name="qualityCheckFormMap.bwsld" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('06')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="07" class="form-control" name="qualityCheckFormMap.zjml" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('07')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="08" class="form-control" name="qualityCheckFormMap.gwcm" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('08')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="09" class="form-control" name="qualityCheckFormMap.hlm" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('09')" maxlength="6">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="10" class="form-control" name="qualityCheckFormMap.hh" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" readonly="readonly" onblur="change_reduce_rate('10')" maxlength="6">
    </div>
    
    <div class="col-md-1 title_header_label">
      <input type="text" id="14" class="form-control" name="qualityCheckFormMap.cmbl" value="0.0" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="change_cmbl('14')" maxlength="5">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="12" class="form-control" name="qualityCheckFormMap.ydzs" value="48" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" maxlength="5">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="13" class="form-control" name="qualityCheckFormMap.szqw" value="正常" maxlength="12">
    </div>
    </div>
    <div class="col-md-12">
    <div class="col-md-1 title_header_label">等级</div>
    <div class="col-md-8 title_header_label">分项扣量(%)</div>
    <div class="col-md-1 title_header_label">其他扣量</div>
    </div>
    <div class="form-group col-md-12">
    <div class="col-md-1 title_header_label">
     <input type="text" id="01or02_val" class="form-control" name="qualityCheckFormMap.level" value="3" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="03_val" class="form-control" name="qualityCheckFormMap.sfkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="04_val" class="form-control" name="qualityCheckFormMap.zzkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="05_val" class="form-control" name="qualityCheckFormMap.kwzkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="06_val" class="form-control" name="qualityCheckFormMap.bwsldkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="07_val" class="form-control" name="qualityCheckFormMap.zjmlkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
     <input type="text" id="08_val" class="form-control" name="qualityCheckFormMap.gwcmkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="09_val" class="form-control" name="qualityCheckFormMap.hlmkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="10_val" class="form-control" name="qualityCheckFormMap.hhkl" value="0.0" readonly="readonly">
    </div>
    <div class="col-md-1 title_header_label">
      <input type="text" id="11" class="form-control" name="reportHarborFormMap.otherReduce" value="0.0" onkeyup="validFloat(this)" onblur="get_total_reduce()" maxlength="6">
    </div>
    </div>
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">收购价(50kg)</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" id="byPrice" maxlength="6" name="reportHarborFormMap.buyPrice">
    </div> 
   </div>
   </div> 
  <div class="form-group col-md-6">
      <div class="col-md-2 div_label">总扣量</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="totalReduce" name="reportHarborFormMap.totalReduce" value="0.0" readonly="readonly">
   </div> 
   </div>
   </div> 
    </div>
    
    <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div> 
   </form> 	
<script type="text/javascript">
$("#form").validate({
		submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
			ly.ajaxSubmit(form, {//验证新增是否成功
				type : "post",
				dataType : "json",
				success : function(data) {
					if (data != "error") {
						var usedCar = $("#usedCar").val();
						var usedOrNot = ${usedOrNot};
						if(usedCar == '1'){ //使用驳车
							parent.usedCar(data,usedOrNot);
						}else{
							if(usedOrNot != '1'){
						    	parent.createQRC(data);
						    }else{
						    	//layer.alert('添加成功！', {icon:6});
						    	layer.confirm('添加成功，是否关闭?', function(index) {
									layer.close(index);
									parent.layer.close(parent.pageii);
								});
						    }
						}
					} else {
						layer.alert('添加失败！', {icon:5});
					}
				}
			});
		},
		rules : {
		},
		messages : {
		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
		},
		success : function(label) {// 验证通过后
		}
	});
var sel= new myselect({
	obj_id:"warehouseLocation",
	url:"${ctx}/warehouse/findMap.shtml",
	option_val:["id"],
	option_val_prefix:",",
	option_html:["wName"],
	option_html_prefix:","
	
},function(){
	//给change事件添加方法
	$("#warehouseName").html("");
	$("#warehouseName").chosen("destroy"); 
	findWarehouse($("#warehouseLocation").val());
	$("#warehouseName").chosen({
		no_results_text : "未找到此选项!",
		width:"100%"
		});
},function(){
	//初始化执行方法
});

function findWarehouse(location){
	new myselect({
		obj_id:"warehouseName",
		url:"${ctx}/warehouse/findWareHouseByLocation.shtml",
		data:{"location_id":location},
		option_val:["id"],
		option_val_prefix:",",
		option_html:["wName"],
		option_html_prefix:","
		
	},function(){
		//给change事件添加方法
		find_variety_property($("#warehouseName").val());
		
	},function(){
		//初始化执行方法
	});
}
  //根据仓号获取粮食品种和粮食属性
  function find_variety_property(warehouse_id){
	  $.ajax({
			dataType:'json',
			type:'post',
			url:'${ctx}/kcxx/findVAndPByWId.shtml',
			data:{id:warehouse_id},
			success:function(data){
				if(data.name != null){
					$("#variety").val(data.variety);
					$("#property").val(data.property);
					find_quality(data.name);
					find_variety(data.name);
				}else{
					$("#variety").val('');
					$("#property").val('');
					readOnly();
				}
			}
	  });
  }
  
  function readOnly(){
	 $("#01or02").val("0.0");
	 $("#01or02").attr("readonly","readonly");
	 $("#byPrice").val("");
	  for(var i=3;i<=10;i++){
		  if(i<10){
			$("#0"+i).val("0.0");
			$("#0"+i).attr("readonly","readonly");
		  }else{
			$("#"+i).val("0.0");
			$("#"+i).attr("readonly","readonly");
		  }
	  }
  }
  //根据粮食品种获取国标质检信息
  function find_quality(grainId){
	  $.ajax({
			dataType:'json',
			type:'post',
			url:'${ctx}/quality/findQualityByVarietyId.shtml',
			data:{id:grainId},
			success:function(data){
				if(data != null){
					//console.log(data);
					qualityArr = data;
					for(var i=0;i<data.length;i++){
						var id = data[i].id;
						var vId = data[i].aId;
						if(vId != undefined){
							if(id == '01' || id=='02'){
								$("#01or02").val(data[i].standard);
								$("#01or02").removeAttr("readonly");
							}else{
								$("#"+id).val(data[i].standard);
								$("#"+id).removeAttr("readonly");
							}
						}else{
							if(id == '01' || id=='02'){
								//$("#01|02").val(data[i].standard);
							}else{
								$("#"+id).val("0.0");
								$("#"+id).attr("readonly","readonly");
							}
						}
					}
					//出库获取默认质检信息
					find_check($("#warehouseName").val());
				}else{
					layer.alert('国标质检信息获取失败！', {icon:7});
				}
			}
	  });
  }
  //根据品种获取采购价等级差价
  function find_variety(grainId){
	  $.ajax({
			dataType:'json',
			type:'post',
			url:'${ctx}/variety/findByVarietyId.shtml',
			data:{id:grainId},
			success:function(data){
				if(data != null){
					//console.log(data);
					variety = data;
					$("#byPrice").val(data.buyPrice);
				}else{
					layer.alert('粮食品种信息获取失败！', {icon:7});
				}
			}
	  });
  }
  var qualityArr;
  var variety;
  //改变容重或出糙，进行等级计算和价格计算
   function onChange_price(obj){
	   var temp = null;
	   for(var i=0;i<qualityArr.length;i++){
		   if(qualityArr[i].id == '01' || qualityArr[i].id == '02'){
			   if(qualityArr[i].vId != undefined){
				   temp = qualityArr[i];
				   break;
			   }
		   }
	   }
	   if(temp != null){
		   var maxVal = temp.maxiValue; //最大区间
		   var minVal = temp.miniValue; //最小区间
		   var standard = temp.standard; //标准值
		   var rank = temp.rank; //等级差
		   
		   var byPrice = variety.buyPrice;
		   var rankPrice = variety.rankPrice;
		   var valu = $(obj).val();
		   if(!isNumber(valu)){
				  $(obj).val(standard);
				  $("#01or02_val").val("0.0");
				  layer.alert("【数据输入有误！】",{icon:7});
				  return ;
		    }
		   if(valu>maxVal || valu<minVal){
			   $(obj).val(standard);
			   $("#01or02_val").val("3");
			   layer.alert("超出范围【"+minVal+"-"+maxVal+"】",{icon:7});
		   }else{
			   var diff = Math.floor((valu - standard)/rank);
			   if(3-diff<1){
				   $("#01or02_val").val("1");
				   $("#byPrice").val(byPrice+(3-1)*rankPrice);
			   }else if(3-diff>5){
				   $("#01or02_val").val("等外");
				   $("#byPrice").val(byPrice-(5-3)*rankPrice);
			   }else{
				   $("#01or02_val").val(3-diff);
				   $("#byPrice").val(byPrice+(diff)*rankPrice);
			   }
		   }
	   }
   }
  
  //根据质检信息进行扣量计算
  function change_reduce_rate(obj){
	  var temp = null;
	  for(var i=0;i<qualityArr.length;i++){
		   if(qualityArr[i].id == obj){
			 temp = qualityArr[i];
		   }
	   }
	  if(temp !=null){
		  var maxVal = temp.maxiValue; //最大区间
		  var minVal = temp.miniValue; //最小区间
		  var standard = temp.standard; //标准值
		  var reduceRate = temp.reduceStandard;
		  var reduceValue = temp.reduceValue;
		  var increaseRate = temp.increaseRange;
		  var increaseValue = temp.increaseValue;
		  
		  var valu = $("#"+obj).val();
		  if(!isNumber(valu)){
			  $("#"+obj).val(standard);
			  $("#"+obj+"_val").val("0.0");
			  layer.alert("【数据输入有误！】",{icon:7});
			  return ;
		  }
		  if($("#"+obj).attr("readonly") != 'readonly'){
			  if(valu>maxVal || valu<minVal){
				   $("#"+obj).val(standard);
				   $("#"+obj+"_val").val("0.0");
				   layer.alert("超出范围【"+minVal+"-"+maxVal+"】",{icon:7});
			   }else{
				   if(valu>=standard){
					   if(reduceRate != 0){
						   var diff = Math.floor((valu - standard)/reduceRate);
						   $("#"+obj+"_val").val(diff*reduceValue);
					   }else{
						   $("#"+obj+"_val").val("0.0");
					   }
				   }else{
					   if(increaseRate!=0){
						   var diff = Math.floor((standard - valu)/increaseRate);
						   $("#"+obj+"_val").val(-(diff*increaseValue));
					   }else{
						   $("#"+obj+"_val").val("0.0");
					   }
				   }
				   get_total_reduce();
			   }
		  }
	  }
  }
  //获取总的扣量
  function get_total_reduce(){
	  var total = 0.0;
	  for(var i=3;i<10;i++){
		  total +=parseFloat( $("#0"+i+"_val").val());
	  }
	  total +=parseFloat($("#10_val").val());
	  total +=parseFloat($("#11").val());
	  $("#totalReduce").val(total);
  }
  //赤霉病粒
  function change_cmbl(obj){
	  var txt = $("#"+obj).val();
	  if(!isNumber(txt)){
		  $("#"+obj).val("0.0");
		  layer.alert("【数据输入有误！】",{icon:7});
		  return ;
	  }
	  if(txt<0 || txt >4){
		  $("#"+obj).val("0.0");
		  layer.alert("超出范围【0-4】",{icon:7});
	  }
  }
  
  //添加驳车
  function add_used_car(bId){
	  parent.layer.close(parent.pageii);
	  parent.usedCar(bId);
  }
  
  
	function _submit() {
	if($("#form").form("validate")){
		$("#form").submit();     
     }
	}
	
	//当出库时，自动获取最后一条统仓质检信息
	function find_check(wId){
		var inOrOut = "${inOrOut}";
		if(inOrOut == '1'){ //入库2：出库1
			$.ajax({
				dataType:'json',
				type:'post',
				url:'${ctx}/reportHarbor/findLastByWId.shtml',
				data:{wId:wId},
				success:function(data){
					if(data != null){
						console.log(data);
						$("#01or02").val(data.rz);
						$("#03").val(data.sf);
						$("#04").val(data.zz);
						$("#05").val(data.kwz);
						$("#06").val(data.bwsld);
						$("#07").val(data.zjml);
						$("#08").val(data.gwcm);
						$("#09").val(data.hlm);
						$("#10").val(data.hh);
						$("#14").val(data.cmbl);
						$("#12").val(data.ydzs);
						$("#13").val(data.szqw);
						change_reduce_rate("03");
						change_reduce_rate("04");
						change_reduce_rate("05");
						change_reduce_rate("06");
						change_reduce_rate("07");
						change_reduce_rate("08");
						change_reduce_rate("09");
						change_reduce_rate("10");
						change_cmbl("14");
						onChange_price($("#01or02"));
					}
				}
		  });
		}
	}
	
	
	
	
</script>
<script type="text/javascript">
//读取身份证
function ReadIDCard_onclick(){
	$.ajax({
		async:false,
		type:'GET',
		dataType:'jsonp',
		url:'http://127.0.0.1:9898/websocket/websocket/IDCard',
		jsonpCallback:"jsonpCallback",
		error:function(){
			 layer.alert("网络配置失败!",{icon:5});
		}
	});	
}
function jsonpCallback(data){
	if(data.result == 'success'){
		$("#userName").val(data.Name);
		$("#idCard").val(data.IDCard);
		$("#address").val(data.Address);
		$("#userName").attr('readonly','readonly');
		$("#idCard").attr('readonly','readonly');
		$("#address").attr('readonly','readonly');
		//根据身份证查找电话号码
		find_phone(data.IDCard);
	}else{
		layer.alert(data.result,{icon:7});
	}
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
			layer.alert("网络配置失败!",{icon:5});
		}
	});	
}

function oneCardCallback(data){
	if(data.result == 'success'){
		$("#oneCard").val(data.oneCard);
		$("#oneCard").attr('readonly','readonly');
		findCardId(data.oneCard);
	}else{
		layer.alert(data.result,{icon:7});
	}
}

function findCardId(oneCard){
	$.ajax({
		type:'post',
		dataType:'json',
		url:'${ctx}/reportHarbor/findByCardId.shtml',
		data:{cardId:oneCard},
		success:function(data){
			//console.log(data);
			if(data == null || data == ''){
				
			}else{
				$("#oneCard").val('');
				$("#oneCard").removeAttr('readonly');
				layer.alert('此卡已被绑定！', {icon:7});
			}
		}
	});
}
//ajax 自动获取供应商信息
function find_Message(obj){
	var realonly = $(obj).attr("readonly");
	if(realonly != 'readonly'){//当无readonly属性时，进行ajax数据请求，若有则说明已经请求过
		var id = $(obj).val();
	    if(id!=null && id != ''){
	    	$.ajax({
				dataType:'json',
				type:'post',
				url:'${ctx}/supplier/findSupplierByIDCardOrPhone.shtml',
				data:{id:id},
				success:function(data){
					if(data == null){
						
					}else if(data.length == 1){
						//console.log(data);
						$("#userName").val(data[0].userName);
						$("#idCard").val(data[0].cID);
						$("#address").val(data[0].address);
						$("#phoneNumber").val(data[0].phoneNumber);
						$("#userName").attr('readonly','readonly');
						$("#idCard").attr('readonly','readonly');
						$("#address").attr('readonly','readonly');
						$("#phoneNumber").attr('readonly','readonly');
					}else if(data.length > 1){
						open_select_layer(data);
					}
				}
			});
	    }
	}
}
//根据身份证获取联系方式
function find_phone(idCard){
	$.ajax({
		dataType:'json',
		type:'post',
		url:'${ctx}/supplier/findSupplierByIDCardOrPhone.shtml',
		data:{id:idCard},
		success:function(data){
			if(data == null){
				
			}else if(data.length>0){
				//console.log(data);
				$("#phoneNumber").val(data[0].phoneNumber);
				$("#phoneNumber").attr('readonly','readonly');
			}
		}
	});
}
//当根据手机号获取供应商信息使，当信息大于一条时，弹出选择框，进行选择
function open_select_layer(data){
	var text = "";
	for(var i=0;i<data.length;i++){
		text+="<input type='radio' name='radioBox' value='"+i+"'>"+data[i].cID+"-"+data[i].userName+"</input></br>";
	}
	layer.confirm(text, {
		  btn: ['确定','取消'] //按钮
		}, function(){
		    var index = $('input[name="radioBox"]:checked ').val();
		    $("#userName").val(data[index].userName);
			$("#idCard").val(data[index].cID);
			$("#address").val(data[index].address);
			$("#phoneNumber").val(data[index].phoneNumber);
			$("#userName").attr('readonly','readonly');
			$("#idCard").attr('readonly','readonly');
			$("#address").attr('readonly','readonly');
			$("#phoneNumber").attr('readonly','readonly');
			
			layer.closeAll('dialog');
		}, function(){
		  
		});
}

</script>

</body>
</html>
