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
</div>
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">车辆信息档案</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/car/edit.shtml">
<input type="hidden" name="token" value="${token }">
<input type="hidden" name="carFormMap.id" value="${carFormMap.id }">
<input type="hidden" name="carFormMap.version" value="${carFormMap.version }">
     <div class="form-group col-md-6">
     <div class="col-md-2 div_label">车牌号<span>*</span></div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control easyui-validatebox" missingMessage="请输入车牌号" data-options="required:true" name="carFormMap.cId" value="${carFormMap.cId }" placeholder="请输入 ：车牌号" maxlength="16">	
   </div>  
   </div>
   </div>
   
    <div class="form-group col-md-6">
      <div class="col-md-2 div_label">车型<span>*</span></div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control easyui-validatebox" missingMessage="请输入车型" data-options="required:true" name="carFormMap.carType" value="${carFormMap.carType }" placeholder="请输入 ：车型" maxlength="16">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">驾驶员</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" name="carFormMap.driver" value="${carFormMap.driver }" placeholder="请输入 ：驾驶员" maxlength="16">
   </div> 
   </div>
   </div>  
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">驾驶证</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" placeholder="请输入 ：驾驶证" name="carFormMap.driveLicense" value="${carFormMap.driveLicense }" maxlength="32">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">联系电话</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control easyui-validatebox" validType="telephone" invalidMessage="请输入正确的联系方式" name="carFormMap.phoneNumber" value="${carFormMap.phoneNumber }" placeholder="请输入 ：联系电话" maxlength="16">
   
    </div> 
   </div>
   </div> 
      <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div> 
   </form> 	
  	</div>
<script type="text/javascript">
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
</body>
</html>
