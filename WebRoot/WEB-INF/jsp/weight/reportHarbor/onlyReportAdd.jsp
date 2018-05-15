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
<form id="form" name="form" method="post" action="${ctx}/reportHarbor/onlyReportAdd.shtml">
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
				}else{
					$("#variety").val('');
					$("#property").val('');
				}
			}
	  });
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
