<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
</head>
<body style="background-color:#d9edf7">

<div class=" col-md-12"><div class=" col-md-6">  <h3 class="animated rubberBand"></h3> </div>   </div> <div class=" col-md-6">	</div>
<div class="col-md-12">
<div class="form-group col-md-12">
   <div class="has-warning">
   <input type="text" class="form-control" disabled="disabled" value="审批人：${userName}">
   </div>
</div>
<div class="form-group col-md-12">
   <div class="has-warning">
   <textarea rows="4" cols="20" class="form-control" disabled="disabled">审批意见：${gsaRemark}</textarea>
   </div>
</div>
</div>
</body>
</html>
