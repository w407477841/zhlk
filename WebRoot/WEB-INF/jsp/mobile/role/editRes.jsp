<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/menutaglib" prefix="mt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
	<style type="text/css">

#mytable {
 width: 660px;
 padding: 0;
 margin: 0;
}

caption {
 padding: 0 0 5px 0;
 width: 660px;  
 font: italic 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 text-align: right;
}

th {
 font: bold 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #4f6b72;
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 letter-spacing: 2px;
 text-transform: uppercase;
 text-align: left;
 padding: 6px 6px 6px 12px;
}

th.nobg {
 border-top: 0;
 border-left: 0;
 border-right: 1px solid #C1DAD7;
 system: none;
}

#mytable td {
 border-right: 1px solid #C1DAD7;
 border-bottom: 1px solid #C1DAD7;
 system: #fff;
 font-size:11px;
 padding: 6px 6px 6px 12px;
 color: #4f6b72;
}

.lanyuan_bb{
border-bottom: 1px solid #C1DAD7;
}

td.alt {
 system: #F5FAFA;
 color: #797268;
}

th.spec {
 border-left: 1px solid #C1DAD7;
 border-top: 0;
 system: #fff ;
 font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
}

th.specalt {
 border-left: 1px solid #C1DAD7;
 border-top: 1px solid #C1DAD7;
 system: #f5fafa ;
 font: bold 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 color: #797268;
}
/*---------for IE 5.x bug*/
html>body td{ font-size:13px;}
</style>
</head>
<body style="background-color:#d9edf7">
<div id="errorDiv" class="col-md-12">
</div>
<div class=" col-md-4"><div class=" col-md-6">  <h3 class="animated rubberBand">权限修改 </h3> </div>   </div> <div class=" col-md-8">	</div>
<div class=" col-md-12"> 
	<form id="form" name="form" method="post">
<input id='roleId' name="roleId" type="hidden" value="${param.roleId}">
<mt:showResources menuList="${allRes}" />
<br>
<div class="doc-buttons" style="text-align: center;">
			<a href="javascript:void(0)" class="btn btn-s-md btn-success btn-rounded" onclick="sub()">保存</a>
<a href="javascript:void(0)" class="btn btn-s-md btn-info btn-rounded" onclick="closeWin();">关闭</a>
</div>
	<br>
	
   </form> 	
  	</div> 	

<script type="text/javascript">
function smenu(obj,id){  
	$(obj).parent().next().find("input").prop("checked",obj.checked);
	var ids= $(obj).attr("_key").split(",");
	if(obj.checked){
	for(var i=0;i<ids.length;i++){
		$("#menu_"+ids[i]).prop("checked",obj.checked);
	}
	}
	
}


function closeWin(){
	var offset="-"+($(document).height()*1-$(window).height()*1)+"px";
	layer.confirm('是否关闭窗口？',{icon: 3,offset: offset},  function(index) {
  	parent.layer.close(parent.pageii);
  	return false;
	});
}
function sub(){
		ly.ajax({
			async : false, //请勿改成异步，下面有些程序依赖此请数据
			type : "POST",
			data : $("#form").serializeJson(),
			url : rootPath + '/mobile/role/addRoleRes.shtml',
			dataType : 'json',
			success : function(json) {
				var offset="-"+($(document).height()*1-$(window).height()*1)+"px";
				if (json == "success") {
						layer.confirm('分配成功！是否关闭窗口？',{icon: 3,offset: offset}, function(index) {
				        	parent.layer.close(parent.pageii);
				        	return false;
						 });
				} else {
					layer.alert(json,{icon: 2,offset: offset});
				}
				;
			}
		});
}


</script>
<script type="text/javascript">
	$.ajax({
		type : "POST",
		data : {
			"mobileResourceFormMap.roleId" : "${param.roleId}"
		},
		url : rootPath + '/mobile/role/findRes.shtml',
		dataType : 'json',
		success : function(json) {
			for (index in json) {
				$("input[name='resId']:checkbox[value='" + json[index].id + "']").prop(
						'checked', 'true');
			}
		}
	});
	</script>

</body>
</html>
