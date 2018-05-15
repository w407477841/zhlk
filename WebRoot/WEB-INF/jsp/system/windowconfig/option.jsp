<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<script type="text/javascript">
var rootPath="${pageContext.servletContext.contextPath}";

</script>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}

  .shipinframe {
            margin: 0;
            padding: 0;
            border: 0;
            width: 450px;
            height: 350px;
        }
</style>
</head>



<body  style="background-color:#d9edf7;" onload="">


	<div class=" col-md-12 " >
	
		<div class="col-sm-7" style="margin-top:10px">
		<div class="col-sm-12">
			<div class="panel panel-primary">
  <div class="panel-heading">智能窗户控制</div>
  <div class="panel-body">
  
		<img id="changePNG" src="${ctx}/img/window/1-1.png" style="height:300px;">
	</div></div>
		</div>
			
		<div class="col-sm-12" style="margin-top:10px">
		<div class="panel panel-primary">
  			<div class="panel-heading">窗户控制</div>
  			<div class="panel-body">
		<c:forEach items="${list}" var="var" varStatus="status">
		<div class="col-sm-2">
    	<label>
     	 <input type="checkbox" class="window-check" data-id="prog-${status.index}" data-ip="${var.ip}" data-port="${var.port}" data-duration="${var.duration}" data-open1="${var.open1}" data-open2="${var.open2}" data-close1="${var.close1}" data-close2="${var.close2}" data-open-need="${needClosedBeforeOpen}"  data-close-need="${needOpenBeforeClose}"> ${var.name}
    		
    	</label>
  		</div>
  		<div class="col-sm-4">
  		<div class="progress progress-striped ">
         	<div id="prog-${status.index}" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="10"   style="width:100%;">
             <span id="proglabel">等待操作</span>
        	</div>
  		</div>
  		</div>
		</c:forEach>		
  	
  		
    </div> 
		<div class="col-md-5 col-sm-offset-3">
		<button class="btn btn-success" id="kq"><i class="glyphicon glyphicon-step-forward"></i> 开启</button>
		<button class="btn btn-info" id="gb"> <i class="glyphicon glyphicon-step-backward"></i>关闭</button>
		<button class="btn btn-warning" id="zt" value="pause" > <i class="glyphicon glyphicon-pause"></i> 暂停</button>
		</div>
	</div>
	</div></div>
	<div class="col-sm-5" style="margin-top:10px" >
	<div class="panel panel-primary">
  <div class="panel-heading">视频监控</div>
  <div class="panel-body">
  
 
	
	<c:if test="${empty shipin or fn:length(shipin)==0}"><div class="col-sm-12"><div class="jumbotron" style="background-color:#d9edf7">
  <h1>未配置视频</h1>
  <p><a class="btn btn-primary btn-lg" href="#" data-id="${param.cangkudianwei}" id="editCangkudianwei" role="button">前往配置</a></p>
</div></div></c:if>
		<c:forEach items="${shipin}" var="var">
		
		
		
		<div class="col-sm-12" style="padding-left:30px;">

        <iframe src="${ctx}/html/shipin/iframe.html" class="shipinframe" frameborder="0" onload="iframeLoaded();"
        
        data-ipnum="${var.ipNum-31}"  data-ip="${var.ip}" data-port="${var.port}" data-username="${var.userName }" data-password="${var.password}"></iframe>
		</div>
        </c:forEach>
	 </div>
</div>
	</div>
	</div>

	<script type="text/javascript" src="${ctx}/js/json.js"></script>
	<script type="text/javascript" src="${ctx}/js/webVideoCtrl.js"></script>
	
	<script type="text/javascript" src="${ctx}/js/system/windowconfig/option.js">
		
	</script>
</body>
</html>
