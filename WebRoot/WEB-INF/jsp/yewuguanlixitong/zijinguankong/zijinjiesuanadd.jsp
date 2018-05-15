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
<div class=" col-md-4"><div class=" col-md-6">  <h3 class="animated rubberBand">资金结算</h3> </div>   </div> <div class=" col-md-8">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/zijinjiesuan/add.shtml">
<input type="hidden" name="token" value="${token }">
     <div class="form-group col-md-6">
        <div class="col-md-2 div_label">货主姓名</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" id="mrBrand" name="ziJinJieSuanFormMap.bbName" placeholder="请输入 ：货主姓名" maxlength="32">	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">车牌号</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" id="mrPage" name="ziJinJieSuanFormMap.bbPlateNumber" placeholder="请输入 ：车牌号"  maxlength="10">
   </div> 
   </div>
   </div>  
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">品种</div>
   <div class="col-md-10">
    <div class="has-warning">
    <select name="ziJinJieSuanFormMap.bbAssortment" id="selectcategory" data-rel="chosen" data-placeholder="请选择品种" class="form-control">
    </select>
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">粮食性质</div>
   <div class="col-md-10">
    <div class="has-warning">
    <select name="ziJinJieSuanFormMap.bbQuality" id="selectvariety" data-rel="chosen" data-placeholder="请选择粮食性质" class="form-control">
    </select>
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">等级</div>
   <div class="col-md-10">
    <div class="has-warning">
   <select name="ziJinJieSuanFormMap.bbGrade" id="grade" data-rel="chosen" data-placeholder="请选择等级" class="form-control">
     
    </select>
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">单价</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" id="price" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)"  name="ziJinJieSuanFormMap.bbPrice" placeholder="请输入 ：单价" maxlength="6">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">结算净数</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" id="number" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" name="ziJinJieSuanFormMap.bbSettleNumber" placeholder="请输入 ：结算净数" maxlength="10">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">结算金额</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" id="money" maxlength="10" onfocus="getCount(this)" onkeyup="chengeUpper(this)" onblur="validInt(this)" value="" name="ziJinJieSuanFormMap.bbSettleSum"  placeholder="请输入 ：结算金额">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">结算状态</div>
   <div class="col-md-10">
    <div class="has-warning">
     <select name="ziJinJieSuanFormMap.bbSettleStatus" id="settleStatus" data-rel="chosen" data-placeholder="请选择结算状态" class="form-control">
      <option value=""></option>
      <option value="已结算">已结算</option>
      <option value="未结算">未结算</option>
    </select>
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">结算时间</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" id="dateformat" data-placeholder="请输入 ：结算时间" name="ziJinJieSuanFormMap.bbSettleDate">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">结算类型</div>
   <div class="col-md-10">
    <div class="has-warning">
   <select name="ziJinJieSuanFormMap.bbSettleCategory" id="settleCategory" data-rel="chosen" data-placeholder="请选择结算类型" class="form-control">
      <option value=""></option>
      <option value="现金">现金</option>
      <option value="转账汇款">转账汇款</option>
    </select> </div> 
   </div>
   </div>
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">账户</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" name="ziJinJieSuanFormMap.bbAccount" placeholder="请输入 ：账户"  maxlength="32">
   </div> 
   </div>
   </div>  
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">结算人员</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" name="ziJinJieSuanFormMap.bbSettlePerson" placeholder="请输入 ：结算人员"  maxlength="32">
   </div> 
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">金额(大写)</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="upmoney"  placeholder="请输入 ：拨款金额(大写)" disabled="disabled">
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
						layer.alert('添加成功！', 3);
					} else {
						layer.alert('添加失败！', 3);
					}
				}
			});
		},
		rules : {
			"ziJinJieSuanFormMap.bbName" : "required",
			"ziJinJieSuanFormMap.bbPrice" : "required",
			"ziJinJieSuanFormMap.bbSettleNumber" : "required",
			"ziJinJieSuanFormMap.bbSettlePerson" : "required"
		},
		messages : {
			"ziJinJieSuanFormMap.bbName" : "<font color='red'>请输入货主姓名</font>",
			"ziJinJieSuanFormMap.bbPrice" : "<font color='red'>请输入单价</font>",
			"ziJinJieSuanFormMap.bbSettleNumber" : "<font color='red'>请输入结算净数</font>",
			"ziJinJieSuanFormMap.bbSettlePerson" : "<font color='red'>请输入结算员</font>"
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


function getCount(obj){
  var price = parseFloat($("#price").val());
  var number = parseInt($("#number").val());
  $(obj).val(Math.round(price*number));
  chengeUpper(obj);
}

  

   var number = [ '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' ];
   var bit = [ '拾', '佰', '仟', '万', '亿' ];
	function chengeUpper(obj) {
		var result = obj.value.replace(/\D/g, '');
		var val = '';
		
		if (result.length == 1) {
			if (result == '0') {
				result = '';
			} else {
				var nvm = parseInt(result);
				val = number[nvm - 1];
			}
		} else if (result.length > 1 && result.length < 6) {  //万元
			val += conventLong(val,result);
		} else if (result.length > 5 && result.length < 9) {  //千万元
			var hei = result.substring(0, result.length - 5);
			var low = result.substring(result.length - 5);

			val = conventShot(val,hei);

			if(low.substring(0,1) == '0'){  //万位为0，须进行补填：万
			 val +=bit[3];			
			}
			val = conventLong(val,low);
		} else if (result.length > 8 && result.length < 13) { //千亿
			var top = result.substring(0, result.length - 8);
			var hei = result.substring(result.length - 8, result.length - 5);
			var low = result.substring(result.length - 5);
			val += conventLong(val,top);
			val+=bit[4];
			val = conventShot(val,hei);
			if(low.substring(0,1) == '0'){
			if(parseInt(low)>0){
			 val +=bit[3];			
			}
			}
			val = conventLong(val,low);
		}
		$("#upmoney").val(val);
		$("#upmoneyt").val(val);
		obj.value = result;
	}
	
	function conventLong(val,data){
	  var ind =  data.length;
	  for ( var i = 0; i < data.length; i++) {
				var temp = data.substring(i, i + 1);
				if (i == data.length - 1) {
					if (temp != '0') {
						val += number[parseInt(temp) - 1];
					}
				} else {
					if (temp != '0') {
						val += number[parseInt(temp) - 1];
						val += bit[ind - i - 2];
					}
				}
			}
			return val;
	}
	function conventShot(val,data){
	  var ind =  data.length;
	  for ( var i = 0; i < data.length; i++) {
				var temp = data.substring(i, i + 1);
				if (temp != '0') {
					val += number[parseInt(temp) - 1];
					val += bit[ind - i - 1];
				}
		}
		return val;
	}
	//粮食性质
	var sele= new myselect({
		obj_id:"selectvariety",
		url:"${ctx}/code/findCodeItemTreeGrid.shtml",
		data:{"codeItemFormMap.codeid":11},
		option_val:["id"],
		option_val_prefix:",",
		option_html:["text"],
		option_html_prefix:","
		
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
		url:"${ctx}/code/findCodeItemTreeGrid.shtml",
		data:{"codeItemFormMap.codeid":12},
		option_val:["id"],
		option_val_prefix:",",
		option_html:["text"],
		option_html_prefix:","
		
	},function(){
		//给change事件添加方法
	},function(){
		//初始化执行方法
	});
	$("#selectcategory").chosen({
		no_results_text : "未找到此选项!",
		width:"100%"
	});
	
	//等级
	var selec= new myselect({
		obj_id:"grade",
		url:"${ctx}/code/findCodeItemTreeGrid.shtml",
		data:{"codeItemFormMap.codeid":10},
		option_val:["id"],
		option_val_prefix:",",
		option_html:["text"],
		option_html_prefix:","
		
	},function(){
		//给change事件添加方法
	},function(){
		//初始化执行方法
	});
	$("#grade").chosen({
		no_results_text : "未找到此选项!",
		width:"100%"
	});
	function _submit() {
		$("#form").submit();
	}
</script>
</body>
</html>
