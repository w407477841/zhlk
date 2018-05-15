<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
	 <style type="text/css">
	 .chosen-container-single .chosen-single{
	 height:37px;
	 }
	 
	 </style>
</head>
<body style="background-color:#d9edf7">
<div id="errorDiv" class="col-md-12">
</div>
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">收款通知单</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/shoukuantongzhidan/edit.shtml">
<input type="hidden" name="shouKuanTongZhiDanFormMap.id" value="${shouKuanTongZhiDanFormMap.id }" >
<input type="hidden" name="shouKuanTongZhiDanFormMap.version" value="${shouKuanTongZhiDanFormMap.version }" >
<input type="hidden" name="token" value="${token }">
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">粮库地点</div>
   <div class="col-md-10">
   <div class="has-warning">
   <select class="form-control" id="warehouseLocation" data-rel="chosen"  data-placeholder="请选择粮库地点"  >
   </select>	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">仓号</div>
   <div class="col-md-10">
   <div class="has-warning">
	<select class="form-control" id="warehouseName" name="shouKuanTongZhiDanFormMap.cnWId" data-rel="chosen"  data-placeholder="请选择仓号"  >
   </select>	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">粮食性质</div>
   <div class="col-md-10">
   <div class="has-warning">
	<select class="form-control" id="selectvariety" name="shouKuanTongZhiDanFormMap.cnProperty" data-rel="chosen"  data-placeholder="请选择粮食性质"  >
   </select>	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">粮食品种</div>
   <div class="col-md-10">
   <div class="has-warning">
	<select class="form-control" id="selectcategory" name="shouKuanTongZhiDanFormMap.cnVariety" data-rel="chosen"  data-placeholder="请选择粮食品种"  >
   </select>	
   </div>  
   </div>
   </div>  
   
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">客户名称</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" name="shouKuanTongZhiDanFormMap.cnCustomName" value="${shouKuanTongZhiDanFormMap.cnCustomName }" placeholder="请输入 ：客户名称" maxlength="32">
   </div> 
   </div>
   </div>
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">货款(元)</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" name="shouKuanTongZhiDanFormMap.cnPayment" value="${shouKuanTongZhiDanFormMap.cnPayment }" placeholder="请输入 ：货款(元)" maxlength="9">
   </div> 
   </div>
   </div>
    
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">到账日期</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" id="dateformat" placeholder="请输入 ：到账日期" name="shouKuanTongZhiDanFormMap.cnMoneyDate" value="${shouKuanTongZhiDanFormMap.cnMoneyDate }">
  </div> 
   </div>
   </div>   
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">收获年度</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" onblur="validInt(this)" placeholder="请输入 ：收获年度" name="shouKuanTongZhiDanFormMap.cnYear" value="${shouKuanTongZhiDanFormMap.cnYear }" maxlength="4">
    </div> 
   </div>
   </div> 
      <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div> 
   </form> 	
  	</div> 	

<script type="text/javascript">
laydate({
	elem : '#dateformat',
	event : 'focus'
});
$("#form").validate({
		submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
			ly.ajaxSubmit(form, {//验证新增是否成功
				type : "post",
				dataType : "json",
				success : function(data) {
					if (data == "success") {
						layer.confirm('修改成功，是否关闭?', function(index) {
							layer.close(index);
							parent.layer.close(parent.pageii);
						});
					} else {
						layer.alert('修改失败！', 3);
					}
				}
			});
		},
		rules : {
			"shouKuanTongZhiDanFormMap.cnCustomName" : "required",
			"shouKuanTongZhiDanFormMap.cnPayment" : "required",
			"shouKuanTongZhiDanFormMap.cnMoneyDate" : "required",
			"shouKuanTongZhiDanFormMap.cnYear" : "required"
		},
		messages : {
			"shouKuanTongZhiDanFormMap.cnCustomName" : "<font color='red'>请输入客户姓名</font>",
			"shouKuanTongZhiDanFormMap.cnPayment" : "<font color='red'>请输入货款(元)</font>",
			"shouKuanTongZhiDanFormMap.cnMoneyDate" : "<font color='red'>请输入付款期日</font>",
			"shouKuanTongZhiDanFormMap.cnYear" : "<font color='red'>请输入收获年度</font>"
		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
			$("#errorDiv").css('display', 'block');
			// element.css('border','3px solid #FFCCCC');
			$("#errorDiv").html(error.html());
		},
		success : function(label) {// 验证通过后
			label.parent().attr("class", "has-success");
		}
	});
var sel= new myselect({
	obj_id:"warehouseLocation",
	url:"${ctx}/warehouse/findMap.shtml",
	option_val:["id"],
	option_val_prefix:",",
	option_html:["wName"],
	option_html_prefix:",",
	selected_val:${shouKuanTongZhiDanFormMap.wLocation}
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
	findWarehouse($("#warehouseLocation").val());
});


function findWarehouse(location){
	new myselect({
		obj_id:"warehouseName",
		url:"${ctx}/warehouse/findWareHouseByLocation.shtml",
		data:{"location_id":location},
		option_val:["id"],
		option_val_prefix:",",
		option_html:["wName"],
		option_html_prefix:",",
		selected_val:${shouKuanTongZhiDanFormMap.cnWId}
	},function(){
		//给change事件添加方法
	},function(){
		//初始化执行方法
	});
}
//粮食性质
var sele= new myselect({
	obj_id:"selectvariety",
	url:"${ctx}/property/findEnable.shtml",
	option_val:["id"],
	option_val_prefix:",",
	option_html:["text"],
	option_html_prefix:",",
	selected_val:${shouKuanTongZhiDanFormMap.cnProperty}
},function(){
	//给change事件添加方法
},function(){
	//初始化执行方法
});
$("#selectvariety").chosen({
	no_results_text : "未找到此选项!",
	width:"100%"
});

//粮食品种
var selec= new myselect({
	obj_id:"selectcategory",
	url:"${ctx}/variety/findEnableVariety.shtml",
	option_val:["id"],
	option_val_prefix:",",
	option_html:["text"],
	option_html_prefix:",",
	selected_val:${shouKuanTongZhiDanFormMap.cnVariety}
},function(){
	//给change事件添加方法
},function(){
	//初始化执行方法
});
$("#selectcategory").chosen({
	no_results_text : "未找到此选项!",
	width:"100%"
});


function _submit() {
	$("#form").submit();
}
</script>
</body>
</html>
