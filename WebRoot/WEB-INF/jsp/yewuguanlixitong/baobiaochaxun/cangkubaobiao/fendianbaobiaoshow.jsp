<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <%@include file="/common/common.jspf"%>
  </head>
  <body>
    <div class="print_download" id="operate" style="display: none;">
          <a class="btn btn-default" href="javascript:void(0)" id="print"> 
              <i class="fa fa-print"></i> 打印
		  </a>
          <a class="btn btn-default print_btn_pdf" href="javascript:void(0)" id="pdf"> 
              <i class="fa fa-file-text"></i> PDF
		  </a>
          <a class="btn btn-default print_btn_excel" href="javascript:void(0)" id="excel"> 
              <i class="fa fa-table"></i> Excel
		  </a>
          <a class="btn btn-default print_btn_word" href="javascript:void(0)" id="word"> 
              <i class="fa fa-file-o"></i> Word
		  </a>
    </div>
    <div id="content">
    </div>
  </body>
  <script type="text/javascript" src="${ctx}/js/jquery.jqprint-0.3.js"></script>
  <script type="text/javascript">
  function loadingImg() {
		var html = '<div class="alert alert-warning">'
				+ '<div style="text-align:center">'
				+ '<img src="' + rootPath + '/img/ajax-loaders/ajax-loader-5.gif"/><div>'
				+ '</div>';
		return html;
  }
 $("#content").html(loadingImg());
  $.ajax({
		url : rootPath+"/fendianmingxi/export.shtml",
		type : 'post',
		dataType : 'html',
		data:{locationId:'${locationId}',propertyList:'${propertyList}',varietyList:'${varietyList}',mingcheng:'${mingcheng}',showType:'html'},
		error : function(data) {
			if (data.status = 404)
				$("#content").html(data.responseText);
		},
		success : function(data) {
			$("#content").html(data);
			$("#operate").show();
			changeWidth();
		}
	});
  
  $("#print").click("click",function(){
	  $("#content").jqprint();
  });
  $("#pdf").click("click",function(){
	  var mingcheng = '${mingcheng}';
	  var locationId = '${locationId}';
	  var propertyList = '${propertyList}';
	  var varietyList = '${varietyList}';
	  window.open(rootPath+"/fendianmingxi/export.shtml?locationId="+locationId+"&propertyList="+propertyList+"&mingcheng="+mingcheng+"&varietyList="+varietyList+"&showType=pdf");
  });
  $("#excel").click("click",function(){
	  var mingcheng = '${mingcheng}';
	  var locationId = '${locationId}';
	  var propertyList = '${propertyList}';
	  var varietyList = '${varietyList}';
	  window.open(rootPath+"/fendianmingxi/export.shtml?locationId="+locationId+"&propertyList="+propertyList+"&mingcheng="+mingcheng+"&varietyList="+varietyList+"&showType=excel");
  });
  $("#word").click("click",function(){
	  var mingcheng = '${mingcheng}';
	  var locationId = '${locationId}';
	  var propertyList = '${propertyList}';
	  var varietyList = '${varietyList}';
	  window.open(rootPath+"/fendianmingxi/export.shtml?locationId="+locationId+"&propertyList="+propertyList+"&mingcheng="+mingcheng+"&varietyList="+varietyList+"&showType=word");
  });
  
  function changeWidth(){
	  $("table").each(function(i){
		  if(i==0){
		     $(this).find('td:first').attr("width","0");
		     $(this).find('td:last').attr("width","0");
		  }else{
			  $(this).attr("style","width: 100%; border-collapse: collapse; empty-cells: show");
		  }
	  }); 
  }
  </script>
</html>
