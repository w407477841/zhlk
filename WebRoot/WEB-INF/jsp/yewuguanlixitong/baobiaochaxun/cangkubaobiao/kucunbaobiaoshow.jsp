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
    <!--startprint-->
    <div id="content">
    
    </div>
    <!--endprint-->
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
		url : rootPath+"/kucunbaobiao/export.shtml",
		type : 'post',
		dataType : 'html',
		data:{locationList:'${locationList}',propertyList:'${propertyList}',varietyList:'${varietyList}',mingcheng:'${mingcheng}',writeUnit:'${writeUnit}',writeDate:'${writeDate}',showType:'html'},
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
	  /*
	  changeWidth();
	  bdhtml=window.document.body.innerHTML;//获取当前页的html代码
	  sprnstr="<!--startprint-->";//设置打印开始区域
	  eprnstr="<!--endprint-->";//设置打印结束区域
	  prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html

	  prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
	  window.document.body.innerHTML=prnhtml;
	  window.print();
	  //window.document.body.innerHTML=bdhtml;
	  */
	  $("#content").jqprint();
  });
  $("#pdf").click("click",function(){
	    var mingcheng = '${mingcheng}';
		var locationId = '${locationList}';
		var propertyList = '${propertyList}';
		var varietyList = '${varietyList}';
		var writeUnit = '${writeUnit}';
		writeUnit = encodeURI(writeUnit);
		writeUnit = encodeURI(writeUnit);
		var writeDate ='${writeDate}';
		window.open(rootPath+"/kucunbaobiao/export.shtml?locationId="+locationId+"&propertyList="+propertyList+"&writeUnit="+writeUnit+"&writeDate="+writeDate+"&mingcheng="+mingcheng+"&varietyList="+varietyList+"&showType=pdf");
  });
  $("#excel").click("click",function(){
	  var mingcheng = '${mingcheng}';
		var locationId = '${locationList}';
		var propertyList = '${propertyList}';
		var varietyList = '${varietyList}';
		var writeUnit = '${writeUnit}';
		writeUnit = encodeURI(writeUnit);
		writeUnit = encodeURI(writeUnit);
		var writeDate ='${writeDate}';
		window.open(rootPath+"/kucunbaobiao/export.shtml?locationId="+locationId+"&propertyList="+propertyList+"&writeUnit="+writeUnit+"&writeDate="+writeDate+"&mingcheng="+mingcheng+"&varietyList="+varietyList+"&showType=excel");
  });
  $("#word").click("click",function(){
	  var mingcheng = '${mingcheng}';
		var locationId = '${locationList}';
		var propertyList = '${propertyList}';
		var varietyList = '${varietyList}';
		var writeUnit = '${writeUnit}';
		writeUnit = encodeURI(writeUnit);
		writeUnit = encodeURI(writeUnit);
		var writeDate ='${writeDate}';
		window.open(rootPath+"/kucunbaobiao/export.shtml?locationId="+locationId+"&propertyList="+propertyList+"&writeUnit="+writeUnit+"&writeDate="+writeDate+"&mingcheng="+mingcheng+"&varietyList="+varietyList+"&showType=word");
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
