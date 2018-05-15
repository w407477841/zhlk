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
<div class=" col-md-4"><div class=" col-md-6"><h3 class="animated rubberBand">药剂领用</h3> </div>   </div> <div class=" col-md-8">	</div>
<div class=" col-md-12"> 
	<div class="form-group col-md-6">
 <div class="col-md-2 div_label">粮库地点</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="name"  value="${yaoJiLingYongFormMap.wName}" disabled="disabled">
   </div>
   </div>
   </div>
   <div class="form-group col-md-6">
 <div class="col-md-2 div_label">药剂类型</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="name"  value="${yaoJiLingYongFormMap.drug}" disabled="disabled">
   </div>
   </div>
   </div>
 <div class="form-group col-md-6">
 <div class="col-md-2 div_label">药剂名称</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="name"  name="yaoJiLingYongFormMap.muName" value="${yaoJiLingYongFormMap.muName}" disabled="disabled">
   </div>
   </div>
   </div>
     <div class="form-group col-md-6">
     <div class="col-md-2 div_label">药剂品牌</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control"  name="yaoJiLingYongFormMap.muBrand" value="${yaoJiLingYongFormMap.muBrand}" disabled="disabled">	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">单位</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control"  name="yaoJiLingYongFormMap.muPage" value="${yaoJiLingYongFormMap.page }" disabled="disabled">
   </div> 
   </div>
   </div>  
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">药剂规格</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="guige"  name="yaoJiLingYongFormMap.muStandard" value="${yaoJiLingYongFormMap.muStandard}" disabled="disabled">
   </div>  
   </div>
   </div>
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">药剂单价(元)</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="price"  name="yaoJiLingYongFormMap.muPrice" value="${yaoJiLingYongFormMap.muPrice }" disabled="disabled">
   </div>  
   </div>
   </div>  
  <div class="form-group col-md-6">
   <div class="col-md-2 div_label">药剂库存数量</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="mrNumber"  name="yaoJiLingYongFormMap.mrNumber" value="${yaoJiLingYongFormMap.muNumber }" disabled="disabled">
   </div> 
   </div>
   </div>
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">药剂包装</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="danwei"  name="yaoJiLingYongFormMap.muUnit" value="${yaoJiLingYongFormMap.muUnit}" disabled="disabled">
   </div>  
  </div>
   </div> 
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">生产日期</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="dateformat" value="${yaoJiLingYongFormMap.muManufactureDate}"  name="yaoJiLingYongFormMap.muManufactureDate" disabled="disabled">
   </div>  
   </div>
   </div> 
   <div class="form-group col-md-12">
   <div class="col-md-1 div_label">生产厂家</div>
   <div class="col-md-11">
   <div class="has-warning">
   <input type="text" class="form-control"  id="productCompany"  name="yaoJiLingYongFormMap.muProductCompany" value="${yaoJiLingYongFormMap.muProductCompany}" disabled="disabled">
   </div>  
   </div>
   </div> 
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">领用日期</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="dateformat1"  name="yaoJiLingYongFormMap.muUsedDate" value="${yaoJiLingYongFormMap.muUsedDate }" disabled="disabled">
   </div>  
   </div>
   </div> 
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">领用数量</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="operator" onkeyup="this.value=this.value.replace(/\D/g,'')" onblur="validIOK(this)"  name="yaoJiLingYongFormMap.muQuantity" value="${yaoJiLingYongFormMap.muQuantity }" placeholder="请输入 ：领用数量" disabled="disabled">
   </div>  
   </div>
   </div> 
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">经办人</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="operator"  name="yaoJiLingYongFormMap.muApplicant" value="${yaoJiLingYongFormMap.muApplicant }" placeholder="请输入 ：经办人" disabled="disabled">
   </div>  
   </div>
   </div> 
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">核批人</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="auditor"  name="yaoJiLingYongFormMap.muAuditor" value="${yaoJiLingYongFormMap.muAuditor }" placeholder="请输入 ：批核人" disabled="disabled">
   </div>  
   </div>
   </div> 
    <div class="form-group col-md-6">
    <div class="col-md-2 div_label">使用监管人</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" id="auditor"  name="yaoJiLingYongFormMap.muSupervisor" value="${yaoJiLingYongFormMap.muSupervisor }" placeholder="请输入 ：使用监管人" disabled="disabled">
   </div>  
   </div>
   </div> 
   <div class="form-group col-md-12">
   <div class="col-md-1 div_label">用途</div>
   <div class="col-md-11">
   <div class="has-warning">
   <textarea rows="4" cols="20" class="form-control" name="yaoJiLingYongFormMap.muUsed" placeholder="请输入 ：用途" disabled="disabled">${yaoJiLingYongFormMap.muUsed }</textarea>
   </div> 
   </div>
   </div> 
   
   
    <div class="form-group col-md-12">
       <button type="button" class="btn btn-warning" onclick="closeLayer()">关闭</button>
      </div>
  	</div> 	
</body>
<script type="text/javascript">
laydate({
	elem : '#dateformat',
	event : 'focus'
});
laydate({
	elem : '#dateformat1',
	event : 'focus'
});
 function closeLayer(){
  parent.layer.close(parent.pageii);
 }
</script>
</html>
