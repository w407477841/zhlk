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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">品种信息档案</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/variety/edit.shtml">
<input type="hidden" name="token" value="${token }">
<input type="hidden" name="varietyFormMap.id" value="${varietyFormMap.id }">
<input type="hidden" name="varietyFormMap.version" value="${varietyFormMap.version }">
     <div class="form-group col-md-6">
     <div class="col-md-3 div_label">品种名称</div>
   <div class="col-md-9">
   <div class="has-warning">
	<input type="text" class="form-control" name="varietyFormMap.text" value="${varietyFormMap.text }" placeholder="请输入 ：品种名称" maxlength="32">	
   </div>  
   </div>
   </div>
   
    <div class="form-group col-md-6">
      <div class="col-md-3 div_label">自定义名称</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control" name="varietyFormMap.definedText" value="${varietyFormMap.definedText }" placeholder="请输入 ：自定义名称" maxlength="32">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">销售价格(50kg)</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" name="varietyFormMap.salePrice" value="${varietyFormMap.salePrice }" placeholder="请输入 ：驾销售价格" maxlength="8">
   </div> 
   </div>
   </div>  
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">采购价格(50kg)</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" placeholder="请输入 ：采购价格(50kg)" name="varietyFormMap.buyPrice" value="${varietyFormMap.buyPrice }" maxlength="8">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">等级差价</div>
   <div class="col-md-9">
    <div class="has-warning">
    <input type="text" class="form-control" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" name="varietyFormMap.rankPrice" value="${varietyFormMap.rankPrice }" placeholder="请输入 ：等级差价" maxlength="8">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-3 div_label">是否启用</div>
   <div class="col-md-9">
    <div class="has-warning" style="height: 38px; line-height: 38px;">
     <input type="checkbox" style="height: 30px; width: 20px;" name="varietyFormMap.isEnable" value="2"  ${varietyFormMap.isEnable == 2?'checked="checked"':''}/>
    </div> 
   </div>
   </div> 
  	
   <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div> 
   </form>
 </div> 
 <div class=" col-md-12"> 
    <table id="magazineGrid"  style="width:99%;height:300px">
	</table>
 </div>
 <script type="text/javascript">
 var vId = '${varietyFormMap.id}';
 </script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath }/js/system/weight/variety/qualitylist.js">
</script>

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
						layer.alert('修改失败！', {icon:7});
					}
				}
			});
		},
		rules : {
			"varietyFormMap.text" : "required"
		},
		messages : {
			"varietyFormMap.text" : "<font color='red'>请输入品种名称</font>"
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
