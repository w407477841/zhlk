<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
#parent {
	width:100%;
	height: 20px;
}

#son {
	width: 0;
	height: 100%;
	background-color: #008B8B;
	text-align: center;
	line-height: 20px;
	color:white;
	font-size: 20px;
	font-weight: bold;
	border-radius:3px;
}
.slb{
margin: 10px 0;
}
#drag{
width:100%;
height: 200px;
background: silver;
display: inline-block;
margin: 10px 0;
border-radius:5px;
text-align: center;
line-height: 200px;
cursor:pointer;
font-size: large;
color: white;
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class="col-md-12">
		<div id="drag">
			文件拖拽区域
		</div>
	</div>
	<input type="file" id="f" name="pic"  style="display: none"/>
	<div class="col-md-12" id="content">
	
	</div>
</body>
<script type="text/javascript">
	var drag = document.getElementById("drag");
	var f=document.getElementById("f");
	EventUtil.addHandler(drag, "dragenter", handle);
	EventUtil.addHandler(drag, "dragover", handle);
	EventUtil.addHandler(drag, "drop", handle);
	EventUtil.addHandler(drag, "click", handle);
	EventUtil.addHandler(f, "change", function(){
			file=f.files[0];
			uploadFile(file);
	
	});
	function handle(e) {
		var file;
		EventUtil.preventDefault(e);
		switch (e.type) {

		case "dragenter":
			break;

		case "dragover":
			break;

		case "drop":
			file = e.dataTransfer.files[0];
			uploadFile(file);
			break;
		case "click":
		f.click();
		break;

		}

	}

	function uploadFile(file) {
	if(!file) 
		return false;
	var fileName = file.name;
	var index=fileName.lastIndexOf('.');
	var ex = fileName.substr(index);
	 if(ex==".jpg"||ex==".png"||ex==".JPG"||ex==".PNG"){ 
         
     }else{
    	 document.getElementById("drag").innerHTML="<span style='color:red;font-size:large'>请上传JPG/PNG文件!</span>";
 		return false;
     }
	
	document.getElementById("drag").innerHTML="文件拖拽区域";
	document.getElementById("content").innerHTML="<div class='col-md-12 slb'><span>文件名称：</span><span>"+file.name+"</span>"+
	"</div><div class=' col-md-12 slb'><span> 文件大小：</span><span>"+parseFloat(file.size/1024).toFixed(1)+"KB"+"</span>"+
	"</div><div class='col-md-12 ' >上传进度："+
	"<div id='parent'><div id='son'></div></div>"+
	"</div>";
	
	
	var formData = new FormData();
		formData.append("file", file);
		formData.append("dataid","${id}");
		formData.append("dataType","${type}");
		
		$.ajax({
			type : "POST",
			url : "${ctx}" + "/warehouseLocation/uploadFile.shtml",
			data : formData,
			processData : false,
			contentType : false,
			xhr : function() {
				var xhr = $.ajaxSettings.xhr();
				if (onprogress && xhr.upload) {
					xhr.upload.addEventListener("progress", onprogress, false);
					xhr.addEventListener("load", onloaded, false);
					return xhr;
				}
			}
		});
	}
	/**
	 * 进度事件
	 */
	function onprogress(evt) {
		var loaded = evt.loaded; 
		var tot = evt.total; 
		var per = Math.floor(100 * loaded / tot); //上传百分比 
		$("#son").html(per + "%");
		$("#son").css("width", per + "%");
		if(per===100) 
			$("#son").html("上传完成等待服务器处理!");
	}
	/**
	 * 回调函数,相当于success
	 */
	function onloaded(event){
		var _this=this;
		var rs=JSON.parse(_this.responseText,null);
		if(rs == "success"){
			$("#son").html("上传成功!");
		}else{
			$("#son").html("上传失败!");
		}
	}
</script>
</html>