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
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";
</script>
</head>
<body style="background-color:#d9edf7">
<div id="errorDiv" class="col-md-12">
</div>
<div class=" col-md-12"><div class=" col-md-6">  <h3 class="animated rubberBand">需方运输工具情况</h3> </div>   </div>
<div class="col-md-12">
<form id="form" name="form" method="post" action="${ctx}/transfertools/add.shtml">
   <div class="form-group col-md-12">

   <div class="has-warning">
	<input type="text" class="form-control" name="chuKuShenQingTransferToolsFormMap.gsaaNo" value="" placeholder="请输入 ：车船号" maxlength="16">	
   </div>  
   </div>   
   <div class="form-group col-md-12">
    <div class="has-warning">
   <input type="text" class="form-control" name="chuKuShenQingTransferToolsFormMap.gsaaWeight" value="" placeholder="请输入 ：车船吨位" maxlength="32">
   </div> 
   </div>  
   <div class="form-group col-md-12">
   <div class="has-warning">
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
						layer.alert('添加成功！', 3);
					} else {
						layer.alert('添加失败！', 3);
					}
				}
			});
		},
		rules : {
			"chuKuShenQingTransferToolsFormMap.gsaaNo" : "required",
			"chuKuShenQingTransferToolsFormMap.gsaaWeight" : "required"
		},
		messages : {
			"chuKuShenQingTransferToolsFormMap.gsaaNo" : "<font color='red'>请输入车船号</font>",
			"chuKuShenQingTransferToolsFormMap.gsaaWeight" : "<font color='red'>请输入车船吨位</font>"
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
		$("#form").submit();
	}
</script>
</body>
</html>
