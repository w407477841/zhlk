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
<div class=" col-md-4"><div class=" col-md-6">  <h3 class="animated rubberBand">打印模板添加</h3> </div>   </div> <div class=" col-md-8">	</div>
<div class=" col-md-12"> 
	<form id="form" name="form" method="post"
		action="${ctx}/printtemplet/add.shtml">
		  <div class="form-group col-md-6">
   <div class="has-warning">
   <input type="text" class="form-control" id="name"  name="printTempletFormMap.name" value="" placeholder="请输入 ：名称 必填">
   </div>  
   </div>  
		     <div class="form-group col-md-12">
		 
		<input name="printTempletFormMap.value" readonly="readonly" id="value"  >
		
		<a href="javascript:DisplayDesign()">模板设计</a>
		<a href="javascript:DesignByPRGData()">修改模板</a>
		<a href="javascript:getProgramData()">加载模板</a>
		 </div>
      <div class="form-group col-md-6">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
     
      </div> 
      <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=800 height=400> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=820 height=450 pluginspage="install_lodop32.exe"></embed>
</object> 
  
      
   </form> 	
  	</div> 	


<script type="text/javascript">


$("#form").validate({
	submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
		ly.ajaxSubmit(form,{//验证新增是否成功
			type : "post",
			dataType : "json",
			success : function(data) {
				if (data == "success") {
					layer.confirm('继续添加?', function(index) {
						CommnUtil.disableButton('bt-submit',false);
						layer.close(index);
						$("#form")[0].reset();
					});
				} else {
					layer.alert('添加失败！', 3);
				}
			}
		});
	},
	rules: {
		"printTempletFormMap.name": "required"
		},
	messages: {
		"printTempletFormMap.name": "<font color='red'>请输入名称</font>"
		},
		errorPlacement : function(error, element) {// 自定义提示错误位置
			$("#errorDiv").css('display', 'block');
			// element.css('border','3px solid #FFCCCC');
			$("#errorDiv").html(error.html());
			CommnUtil.disableButton('bt-submit',false);
		},
		success : function(label) {// 验证通过后
			label.parent().attr("class","has-success");
			
		}
});

function _submit(){

CommnUtil.disableButton('bt-submit',true);
$("#form").submit();
}

var LODOP; 
function DisplayDesign() {		
	CreatePage();	
	LODOP.SET_SHOW_MODE("DESIGN_IN_BROWSE",1);		  
   	LODOP.PRINT_DESIGN();  
};
function CreatePage() {
	LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));  
	LODOP.PRINT_INITA(0,0,665,600,"模板设计");
	LODOP.On_Return=function(TaskID,Value){
		document.getElementById('value').value=getFormatValue('CHAR:EncodeBase64',Value);};	
};
function getFormatValue(strType,strValue){
    LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));  
    return LODOP.FORMAT(strType,strValue);
}
function DesignByPRGData() {		
	LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM')); 
	LODOP.ADD_PRINT_DATA("ProgramData",document.getElementById('value').value); //装载模板
	//按类名赋值
	LODOP.SET_SHOW_MODE("DESIGN_IN_BROWSE",1);
	LODOP.PRINT_DESIGN();
};
function getProgramData() {	
	if (LODOP.CVERSION) LODOP.On_Return=function(TaskID,Value){document.getElementById('value').value=Value;};	
	document.getElementById('value').value=LODOP.GET_VALUE("ProgramData",0);	//获得文档式模板

};



</script>
</body>
</html>
