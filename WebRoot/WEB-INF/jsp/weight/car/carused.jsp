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
	 
<script type="text/javascript">
function doopen() 
{ 
	if(${hardwareConfig == null}){
		layer.alert("读卡器配置失败",{icon:5});
	}else{
		var Port = ${hardwareConfig.COMNum};
	    var Baud = ${hardwareConfig.baudRate};
	    var sum = TUHFReader09.Open(Port,Baud);
	    if(sum=="00" || sum=="35"){
	    	doquery();
	    }
	    else{
	    	layer.alert("设备连接失败",{icon:5});    	
	    }
	    TUHFReader09.Close(); 
	}
    	
} 

function doclose() 
{ 
    TUHFReader09.Close(); 	
} 
function doquery() 
{ 
    var sum = TUHFReader09.Inventory(); 
    if(sum=="") 
    {	
    	layer.alert("未询查到电子标签",{icon:5});
    }
    else
    {
    	//doRead(sum);
    	var EPC_Len=parseInt(sum.substr(0,2),16);
        var EPC=sum.substr(2,EPC_Len*2);
    	$("#rfid").val(EPC);
        $("#rfid").attr("readonly","readonly");
        isUsed(EPC);
    } 
} 
function doRead(Temp) 
{ 
    if(Temp=="") return;
    var WordPtr=${hardwareConfig.startAddress};
    if(WordPtr=="") return;

    var WordNum=${hardwareConfig.wordNum};
    if(WordNum=="") return;

    var EPC_Len=parseInt(Temp.substr(0,2),16);
    var EPC=Temp.substr(2,EPC_Len*2);
    var Mem =1;
    var sum = TUHFReader09.Read(EPC,WordPtr,WordNum,Mem); 	
    if(sum=="") 
    {	
       layer.alert("读数据失败",{icon:5});
    }
    else
    {
       $("#rfid").val(EPC);
       $("#rfid").attr("readonly","readonly");
       isUsed(sum);
    } 	
}

function isUsed(sum){
	$.ajax({
		type:'post',
		dataType:'json',
		url:'${ctx}/car/isUsed.shtml',
		data:{rfid:sum},
		success:function(data){
			if(data == 'success'){
				layer.alert('此卡已被绑定',{icon:5});
			}
		},
		error:function(){
			
		}
		
	});
}
</script>
</head>
<body style="background-color:#d9edf7">
<div id="errorDiv" class="col-md-12">
</div>
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">车辆信息档案</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/car/used.shtml">
<input type="hidden" name="token" value="${token }">
<input type="hidden" name="carFormMap.id" value="${carFormMap.id }">
<input type="hidden" name="carFormMap.version" value="${carFormMap.version }">
     <div class="form-group col-md-6">
     <div class="col-md-2 div_label">车牌号</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" name="carFormMap.cId" value="${carFormMap.cId }" placeholder="请输入 ：车牌号" maxlength="16" disabled="disabled">	
   </div>  
   </div>
   </div>
   
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">车型</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" name="carFormMap.carType" value="${carFormMap.carType }" placeholder="请输入 ：车型" maxlength="16" disabled="disabled">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">驾驶员</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" name="carFormMap.driver" value="${carFormMap.driver }" placeholder="请输入 ：驾驶员" maxlength="16" disabled="disabled">
   </div> 
   </div>
   </div>  
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">驾驶证</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" placeholder="请输入 ：驾驶证" name="carFormMap.driveLicense" value="${carFormMap.driveLicense }" maxlength="32" disabled="disabled">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">联系电话</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control easyui-validatebox" validType="telephone" invalidMessage="请输入正确的联系方式" name="carFormMap.phoneNumber" value="${carFormMap.phoneNumber }" placeholder="请输入 ：联系电话" maxlength="16" disabled="disabled">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">单据号</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" placeholder="请输入 ：单据号" name="carFormMap.bId" maxlength="16" value="${bId }" readonly="readonly">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">RFID</div>
   <div class="col-md-8" style="padding-right:0;">
    <div class="has-warning">
    <input type="text" class="form-control" id="rfid" placeholder="请输入 ：RFID" name="carFormMap.RFID" value="${carFormMap.RFID }" maxlength="32">
    </div> 
   </div>
    <div class="col-md-2">
      <button type="button" class="btn btn-primary" onclick="doopen()">读卡</button>
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">RFID卡名</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" placeholder="请输入 ：RFID卡名" name="carFormMap.RFIDName" value="${carFormMap.RFIDName }" maxlength="32">
    </div> 
   </div>
   </div> 
      <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div> 
   </form> 	
  	</div>
  	
<OBJECT	id="TUHFReader09" codebase="UHFReader09Proj.ocx"
        TYPE="application/x-itst-activex"
		clsid="{14428901-AF2B-4B45-ACBD-0B4779551E5D}"
	  	width="0"
	  	height="0"
	  	hspace="0"
	  	vspace="0"
		>
</OBJECT>
  	
  	
<script type="text/javascript">
$("#form").validate({
		submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
			ly.ajaxSubmit(form, {//验证新增是否成功
				type : "post",
				dataType : "json",
				success : function(data) {
					if (data == "success") {
						layer.confirm('分配成功，是否关闭?', function(index) {
							layer.close(index);
							parent.layer.close(parent.pageii);
						});
					} else {
						layer.alert('分配失败！', 3);
					}
				}
			});
		},
		rules : {
			"carFormMap.bId" : "required",
			"carFormMap.RFID" : "required",
			"carFormMap.RFIDName" : "required"
		},
		messages : {
			"carFormMap.bId" : "<font color='red'>请输入单据号</font>",
			"carFormMap.RFID" : "<font color='red'>请输入RFID</font>",
			"carFormMap.RFIDName" : "<font color='red'>请输入RFID卡名</font>"
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
  
	function _submit() {
	if($("#form").form("validate")){
		$("#form").submit();     
     }
	}
</script>
</body>
</html>
