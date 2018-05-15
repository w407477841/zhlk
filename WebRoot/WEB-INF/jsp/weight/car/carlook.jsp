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
<div class=" col-md-6"><div class=" col-md-6">  <h3 class="animated rubberBand">车辆信息档案</h3> </div>   </div> <div class=" col-md-6">	</div>
<div class=" col-md-12"> 
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
    <input type="text" class="form-control" placeholder="请输入 ：单据号" name="carFormMap.bId" value="${carFormMap.bId }" maxlength="16" disabled="disabled">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">RFID</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" id="rfid" placeholder="请输入 ：RFID" name="carFormMap.RFID" value="${carFormMap.RFID }" maxlength="32" disabled="disabled">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">RFID卡名</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" placeholder="请输入 ：RFID卡名" name="carFormMap.RFIDName" value="${carFormMap.RFIDName }" maxlength="32" disabled="disabled">
    </div> 
   </div>
   </div>  
  	</div>
</body>
</html>
