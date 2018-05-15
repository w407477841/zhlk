<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">补二维码(一卡通)</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/car/used.shtml">
<input type="hidden" name="token" value="${token }">
<input type="hidden" name="reportHarborFormMap.id" value="${reportHarborFormMap.id }">
<input type="hidden" name="reportHarborFormMap.version" value="${reportHarborFormMap.version }">
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">单据号</div>
   <div class="col-md-8">
   <div class="has-warning">
	<input type="text" class="form-control" id="bId" name="reportHarborFormMap.bId" value="${bId }" placeholder="请输入 ：单据号">	
   </div>  
   </div>
   <div class="col-md-2">
     <button type="button" class="btn btn-primary" onclick="search_info()">查询</button>
   </div>
   </div>
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">一卡通</div>
   <div class="col-md-6">
    <div class="has-warning">
    <input type="text" class="form-control" id="oneCard" name="reportHarborFormMap.cardId"  ${usedOrNot == '1'?'':'disabled="disabled"' }>
   </div> 
   </div>
   <div class="col-md-2">
   <button type="button" class="btn btn-primary" onclick="ReadOneCard_onclick()" ${usedOrNot == '1'?'':'disabled="disabled"' }>读卡</button>
   </div>
   <div class="col-md-2">
   <button type="button" class="btn btn-info" onclick="save_onclick()" ${usedOrNot == '1'?'':'disabled="disabled"' }>保存</button>
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">车船号</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="ship" name="reportHarborFormMap.cardId">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">粮食品种</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="variety" name="reportHarborFormMap.cardId">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">客户姓名</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="userName" name="reportHarborFormMap.cardId">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">身份证</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="idCard" name="reportHarborFormMap.cardId" >
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">地址</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="address" name="reportHarborFormMap.cardId" >
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
     <button type="button" class="btn btn-info" onclick="print_qrc()">打印二维码</button>
   </div>
   <div class="form-group col-md-12" id="image">
     
   </div>
   </form> 	
  	</div>	
  	
<script type="text/javascript">

	function search_info(){
		var bId = $("#bId").val();
		$.ajax({
			type:'post',
			dataType:'json',
			url:'${ctx}/reportHarbor/findByBId.shtml',
			data:{bId:bId},
			success:function(data){
				if(data == null){
					layer.alert('无查找数据！', {icon:7});
				}else{
					$("#ship").val(data.shipId);
					$("#variety").val(data.grainVariety);
					$("#userName").val(data.userName);
					$("#idCard").val(data.IDCard);
					$("#address").val(data.address);
					
					var imgDiv = $("#image");
					imgDiv.text("");
					imgDiv.append('<img alt="二维码" src="${ctx}/car/createqrc.shtml?qc='+data.bId+'">');
				}
			},
			error:function(data){
				layer.alert('查找失败！', {icon:7});
			}
			
		});
		
		
	}
	
	function print_qrc(){
		var bId = $("#bId").val();
		if(bId !=null && bId.length==12){
			parent.createQRC(bId);
		}else{
			layer.alert("单据号有误！");
		}
	}
	/**
	*绑定一卡通
	*/
	function save_onclick(){
		var bId = $("#bId").val();
		var oneCard = $("#oneCard").val();
		if(bId !=null && bId.length==12){
			if(oneCard !=null){
				$.ajax({
					type:'post',
					dataType:'json',
					url:'${ctx}/reportHarbor/bindOneCard.shtml',
					data:{bId:bId,oneCard:oneCard},
					success:function(data){
						if(data == 'success'){
							layer.alert("绑定成功！");
						}else{
							layer.alert("绑定失败！");
						}
					},
					error:function(data){
						layer.alert("绑定失败！");
					}
				});
			}else{
				layer.alert("未绑定一卡通！");
			}
		}else{
			layer.alert("单据号有误！");
		}
	}
</script>
<script type="text/javascript">
//读取一卡通
function ReadOneCard_onclick(){
	$.ajax({
		async:false,
		type:'GET',
		dataType:'jsonp',
		url:'http://127.0.0.1:9898/websocket/websocket/OneCard',
		jsonpCallback:"oneCardCallback",
		error:function(){
			alert("网络配置失败");
		}
	});	
}

function oneCardCallback(data){
	if(data.result == 'success'){
		$("#oneCard").val(data.oneCard);
		$("#oneCard").attr('readonly','readonly');
		
		findCardId(data.oneCard);
	}else{
		alert(data.result);
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
				layer.alert('此卡已被绑定！', 3);
			}
		}
	});
}
</script>
</body>
</html>
