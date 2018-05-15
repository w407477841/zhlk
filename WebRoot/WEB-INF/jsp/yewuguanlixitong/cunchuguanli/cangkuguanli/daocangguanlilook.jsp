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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">倒仓信息</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
<form id="form" name="form" method="post" action="${ctx}/daocangguanli/add.shtml">
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">原粮库地点</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wlNameo }">	
   </div>  
   </div>
   </div>   
    <div class="form-group col-md-6">
   <div class="col-md-2 div_label">目标粮库地点</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wlNameo }">	
   </div>  
   </div>
   </div>   
   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">原仓号</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wNameo }">
   </div>  
   </div>
   </div>  
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">目标仓号</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wNamet }">
   </div>  
   </div>
   </div>  
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">原仓内品种</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="OriginalVariety" value="${daoCangGuanLiFormMap.variety }">
   
  </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">目标仓内品种</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="TargetVariety" value="${daoCangGuanLiFormMap.variety }">
  </div> 
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">原仓性质</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="OriginalCategory" value="${daoCangGuanLiFormMap.category }">
  </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">目标仓性质</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="TargetCategory" value="${daoCangGuanLiFormMap.category }">
  </div> 
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">原仓保管员</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="OriginalStoreman" value="${daoCangGuanLiFormMap.paNameo }">
  </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">目标仓保管员</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="TargetStoreman" value="${daoCangGuanLiFormMap.paNamet }">
  </div> 
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">原仓库存量</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="OriginalStorageRate" value="${daoCangGuanLiFormMap.wgtOriginalStorageRate}">
  </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">目标仓库存量</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  id="TargetStorageRate"  value="${daoCangGuanLiFormMap.wgtTargetStorageRate}">
  </div> 
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">倒仓单号</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control"  value="${daoCangGuanLiFormMap.wgtBill}" placeholder="请输入倒仓原单号" readonly="readonly">
  </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">倒仓日期</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly"  value="${daoCangGuanLiFormMap.wgtTransferDate}">
  </div> 
   </div>
   </div> 
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">倒仓原因</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" value="${daoCangGuanLiFormMap.wgtCause}" placeholder="请输入倒仓原因" readonly="readonly">
  </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">倒仓数量(kg)</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" onblur="validFloat(this)" readonly="readonly" value="${daoCangGuanLiFormMap.wgtNumber}" placeholder="请输入倒仓数量(kg)">
  </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">录入日期</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" readonly="readonly" value="${daoCangGuanLiFormMap.wgtAddDate}"">
  </div> 
   </div>
   </div> 
   </form> 	
  	</div> 	
</body>
</html>
