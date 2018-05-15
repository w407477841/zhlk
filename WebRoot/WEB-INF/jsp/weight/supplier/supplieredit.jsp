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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">供应商信息档案</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/supplier/edit.shtml">
<input type="hidden" name="token" value="${token }">
<input type="hidden" name="supplierFormMap.id" value="${supplierFormMap.id }">
<input type="hidden" name="supplierFormMap.version" value="${supplierFormMap.version }">

     <div class="form-group col-md-6">
     <div class="col-md-2 div_label">身份证</div>
   <div class="col-md-8">
   <div class="has-warning">
	<input type="text" class="form-control" id="cId" name="supplierFormMap.cID" value="${supplierFormMap.cID }" placeholder="请输入 ：身份证" maxlength="18">	
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
    <input type="text" class="form-control easyui-validatebox" missingMessage="请输入单位" data-options="required:true" id="userName" name="supplierFormMap.userName" value="${supplierFormMap.userName }" placeholder="请输入 ：单位" maxlength="16">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">性别</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="sex" name="supplierFormMap.sex" value="${supplierFormMap.sex }" placeholder="请输入 ：性别" maxlength="1">
   </div> 
   </div>
   </div>  
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">出生日期</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="dateformat" placeholder="请输入 ：出生日期" name="supplierFormMap.birthday" value="${supplierFormMap.birthday }">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">联系电话<span>*</span></div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" id="phoneNumber" class="form-control easyui-validatebox" missingMessage="请输入联系方式" data-options="required:true" validType="telephone" invalidMessage="请输入正确的联系方式" name="supplierFormMap.phoneNumber" value="${supplierFormMap.phoneNumber }" placeholder="请输入 ：联系电话" maxlength="16">
   
    </div> 
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">联系地址</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" id="address" name="supplierFormMap.address" value="${supplierFormMap.address }" placeholder="请输入 ：联系地址" maxlength="64">
   </div> 
   </div>
   </div> 
      <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div>
       <div class="form-group col-md-12" style="height:100px;">
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
						layer.alert('修改失败！', {icon:5});
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
  
	function _submit() {
	if($("#form").form("validate")){
		$("#form").submit();     
     }
	}
</script>
<script type="text/javascript">
function ReadIDCard_onclick(){
	$.ajax({
		async:false,
		type:'GET',
		dataType:'jsonp',
		url:'http://127.0.0.1:9898/websocket/websocket/IDCard',
		jsonpCallback:"jsonpCallback",
		error:function(){
			alert("网络配置失败");
		}
	});	
}
function jsonpCallback(data){
	if(data.result == 'success'){
		$("#cId").val(data.IDCard);
		$("#userName").val(data.Name);
		$("#dateformat").val(data.Birthday);
		$("#address").val(data.Address);
		$("#sex").val(data.Sex);
		
		$("#cId").attr("readonly","readonly");
		$("#userName").attr("readonly","readonly");
		$("#dateformat").attr("readonly","readonly");
		$("#address").attr("readonly","readonly");
		$("#sex").attr("readonly","readonly");
	}else{
		alert(data.result);
	}
}

</script>
</body>
</html>
