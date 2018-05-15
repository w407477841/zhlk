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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">脚粮数据信息</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/weighing/addFootGrain.shtml">
<input type="hidden" name="token" value="${token }">
     <div class="form-group col-md-12">
     <div class="col-md-2 div_label" style="text-align: left;">单据号</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" name="weighingFormMap.bId" value="${bId }" readonly="readonly">	
   </div>  
   </div>
   </div>
   
    <div class="form-group col-md-12">
      <div class="col-md-2 div_label" style="text-align: left;">皮重</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" name="weighingFormMap.tare" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" placeholder="请输入 ：皮重" maxlength="16">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-12">
      <div class="col-md-2 div_label" style="text-align: left;">毛重</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" name="weighingFormMap.grossWeight" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" placeholder="请输入 ：毛重" maxlength="16">
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
					if (data == "error") {
						layer.alert('添加失败！', 3);
					} else {
						//打印驳车凭证
						parent.my_print(data.substring(6));
						parent.layer.close(parent.pageii);
					}
				}
			});
		},
		rules : {
			"weighingFormMap.bId" : "required",
			"weighingFormMap.tare" : "required",
			"weighingFormMap.grossWeight" : "required"
		},
		messages : {
			"weighingFormMap.bId" : "<font color='red'>请输入单据号</font>",
			"weighingFormMap.tare" : "<font color='red'>请输入皮重</font>",
			"weighingFormMap.grossWeight" : "<font color='red'>请输入毛重</font>"
		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
			$("#errorDiv").css('display', 'block');
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
