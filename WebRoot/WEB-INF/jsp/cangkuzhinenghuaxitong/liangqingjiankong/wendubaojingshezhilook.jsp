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
<div class=" col-md-4"><div class=" col-md-6">  <h3 class="animated rubberBand">粮温报警信息</h3> </div>   </div> <div class=" col-md-8">	</div>
<div class=" col-md-12"> 
   <div class="form-group col-md-6">
   <div class="col-md-2 div_label">粮库地点</div>
   <div class="col-md-10">
   <div class="has-warning">
   <input type="text" class="form-control" value="${temperatureAlarmFormMap.wlName}" disabled="disabled">	
   </div>  
   </div>
   </div>   
   <div class="form-group col-md-6">
        <div class="col-md-2 div_label">仓号</div>
   <div class="col-md-10">
   <div class="has-warning">
	<input type="text" class="form-control" value="${temperatureAlarmFormMap.wName}" disabled="disabled">
   </div>  
   </div>
   </div>    
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">采集时间</div>
   <div class="col-md-10">
    <div class="has-warning">
   <input type="text" class="form-control" value="${temperatureAlarmFormMap.cjsj}" disabled="disabled">
   </div> 
   </div>
   </div>  
   
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">报警时间</div>
   <div class="col-md-10">
    <div class="has-warning">
    <input type="text" class="form-control" value="${temperatureAlarmFormMap.alarmDate}" disabled="disabled">
   </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">报警温度</div>
   <div class="col-md-10">
    <div class="has-warning">
     <input type="text" class="form-control" value="${temperatureAlarmFormMap.alarmTemperature}" readonly="readonly">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-6">
      <div class="col-md-2 div_label">报警点位个数</div>
   <div class="col-md-10">
    <div class="has-warning">
     <input type="text" class="form-control" value="${temperatureAlarmFormMap.alarmNum}" readonly="readonly">
    </div> 
   </div>
   </div> 
   <div class="form-group col-md-12">
      <div class="col-md-1 div_label">报警点位</div>
   <div class="col-md-11">
    <div class="has-warning">
      <textarea rows="10" cols="20" class="form-control" disabled="disabled">${temperatureAlarmFormMap.position}</textarea>
    </div> 
   </div>
   </div> 
 

      <div class="form-group col-md-12">
       <button type="button" class="btn btn-info bt-submit" onclick="_submit()">提交</button>
      </div> 
  </div> 	
</body>
</html>
