<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<%@include file="/common/common.jspf"%>
<style type="text/css">
.chosen-container-single .chosen-single {
	height: 37px;
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div id="errorDiv" class="col-md-12"></div>
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">智能电表</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12 ">
		<form id="form" class="form-horizontal" name="form" method="post" action="${ctx}/cangkuzhinenghuaxitong/ammeterConfig/edit.shtml">
		<input type="hidden" name="token" value="${token}" />
				<input type="hidden" class="form-control" id="id"name="ammeterConfigFormMap.id"  value="${ammeterConfigFormMap.id}" placeholder="请输入 ：电表名称">
				<div class="form-group">
				<label for="name" class="col-sm-2 control-label">电表名称</label>
				<div class="col-sm-6">
						<input type="text" class="form-control" id="name"name="ammeterConfigFormMap.name"  value="${ammeterConfigFormMap.name}" placeholder="请输入 ：窗户名称">
				</div>
					<p class="help-block col-sm-4">给该电表起个响亮的名字</p>	
				</div>
	 <div class="form-group">
	 <label for="selectLocation" class="col-sm-2 control-label">所属粮库</label>
	 <div class="col-sm-6">
   	<select id="selectLocation" data-rel="chosen" data-placeholder="所属粮库">
   	<option value=""></option>
   	</select>
   	</div>
   		<p class="help-block col-sm-4">选择粮站</p>	
   	</div> 
				
				<div class="form-group">
				<label for="selectHouse" class="col-sm-2 control-label"> 点位 </label>
				<div class="col-sm-6">
						<select id="selectHouse" data-rel="chosen" data-placeholder="点位" name="ammeterConfigFormMap.cangkudianwei" >
						   <option value=""></option>
						</select>
				</div>		
				<p class="help-block col-sm-4">选择仓库点位，用于定位</p>	
				</div>

				<div class="form-group">
				<label for="ipNum" class="col-sm-2 control-label">IP地址</label>
				<div class="col-sm-6">
						<input type="text" class="form-control" id="ipNum"name="ammeterConfigFormMap.ip" value="${ammeterConfigFormMap.ip}" placeholder="请输入 ：ip">
						</div>
							<p class="help-block col-sm-4">该处输入该电表所属协议转换器IP</p>	
				</div>
				<div class="form-group">
				<label for="sLeft" class="col-sm-2 control-label">端口号</label>
				<div class="col-sm-6">
						<input type="text" class="form-control" id="sLeft"name="ammeterConfigFormMap.port" value="${ammeterConfigFormMap.port}" placeholder="请输入 ：端口号">
				</div>
					<p class="help-block col-sm-4">该处输入该电表所属协议转换器端口号</p>	
				</div>
					
			<div class="form-group">
				<label for="close1" class="col-sm-2 control-label">指令</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="instructions"name="ammeterConfigFormMap.instructions" value="${ammeterConfigFormMap.instructions}" placeholder="查询指令">
					</div>
						<p class="help-block col-sm-4">指令(查询指令),<font class="text-danger"><strong>空格去除</strong></font></p>	
				</div>
				
				
		
			<div class="form-group col-md-12">
				<button type="button" class="btn btn-info bt-submit"
					onclick="_submit()">提交</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	toSelLocation();
		function toSelLocation(){
		var url="${ctx}/warehouse/findMap.shtml";
		var warehousecondition=CommnUtil.ajax(url, null,'json');
		if(warehousecondition!=null){
				var sel=$("#selectLocation");
				sel.css("width",sel.parent().parent().css("width"));
				sel.empty().change(function(){
					
					$("#selectHouse").html("");
					$("#selectHouse").chosen("destroy"); 
					
					toSel($(this).val());
					$("#selectHouse").chosen({
						no_results_text : "未找到此选项!",
						width:"100%"
						});
				});
				var opt=$("<option>").val('').html("").appendTo(sel);
				for(var i=0;i<warehousecondition.length;i++){
				var opt=$("<option>").val(warehousecondition[i].wNo).html(warehousecondition[i].wName).appendTo(sel);
			}
			
		}
		
		}
	
	function toSel(houseid){
		$.ajax({
			url : rootPath + "/sensorManager/queryHouse.shtml",
			type : "post",
			async:false,
			cache : false,
			dataType : "json",
			data : {
				"location" : houseid
			},
			success : function(rs) {
			var sel = document.forms[0]["ammeterConfigFormMap.cangkudianwei"];
			sel.length=0;
			sel.style.width=document.getElementById("name").style.width;
				if (rs.success) {
				sel.add(new Option("", ""));
					for ( var i = 0; i < rs.rs.length; i++) {
						sel.add(new Option(rs.rs[i].name, rs.rs[i].id))
						}
				}

			}
		})
	}
		$("#selectLocation").change(function() {
			$("#img_cangku").css("background","url(${ctx}/img/cangku/" + $(this).val() + ".jpg)").css("background-size", "100% 100%").css("height","300px");
				});
		$("#selectLocation").css("width",$("#selectLocation").parent().parent().css("width"));
		$("#selectHouse").css("width",$("#selectHouse").parent().parent().css("width"));
		$("#img_cangku").click(function(event) {
			imgL = $("#img_cangku").css("width");
			imgL = imgL.substr(0, imgL.length - 2);
			imgH = $("#img_cangku").css("height");
			imgH = imgH.substr(0, imgH.length - 2);
			cL = event.offsetX;
			cH = event.offsetY;
			$("#sLeft").val(CommnUtil.roundFun(cL / imgL * 100, 1) + "%");
			$("#top").val(CommnUtil.roundFun(cH / imgH * 100, 1) + "%");
		});

		$("#form").validate({
							submitHandler : function(form) {// 必须写在验证前面，否则无法ajax提交
								ly.ajaxSubmit(form, {//验证新增是否成功
									type : "post",
									dataType : "json",
									success : function(data) {
										if (data) {
											layer.alert('修改成功！', 3);
											//layer.close();
										} else {
											layer.alert('修改失败！', 3);
										}
									}
								});
							},
							rules : {
								"ammeterConfigFormMap.name" : "required",
								"ammeterConfigFormMap.ip" : "required",
								"ammeterConfigFormMap.port" : "required",
								"ammeterConfigFormMap.lx" : "required"
							},
							messages : {
								"ammeterConfigFormMap.name" : "<font color='red'>这是一个必填字段</font>",
								"ammeterConfigFormMap.ip" : "<font color='red'>这是一个必填字段</font>",
								"ammeterConfigFormMap.port" : "<font color='red'>这是一个必填字段</font>"
							},
							errorPlacement : function(error, element) {// 自定义提示错误位置
								$("#errorDiv").css('display', 'block');
								$("#errorDiv").html(error.html());
							},
							success : function(label) {// 验证通过后
								label.parent().attr("class", "has-success");
							}
						});

		function _submit() {
			$("#form").submit();
		}
	</script>
</body>
</html>
