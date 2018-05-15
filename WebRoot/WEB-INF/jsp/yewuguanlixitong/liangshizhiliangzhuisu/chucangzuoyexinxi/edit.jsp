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

.laydate-icon {
	height: 38px;
	line-height: 38px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div id="errorDiv" class="col-md-12"></div>
	<div class=" col-md-4">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">方案修改</h3>
		</div>
	</div>
	<div class=" col-md-8"></div>
	<div class=" col-md-12">
		<form id="form" name="form" method="post"
			action="${ctx}/chucangzuoyexinxi/editStoreMsg.shtml">
			<input type="hidden" name="token" value="${token}"> 
			<input type="hidden" name="StoreMsgFormMap.id" value="${StoreMsgFormMap.id}"> 
			
			<input type="hidden" class="temp" name="" value="${StoreMsgFormMap.location}">
			<input type="hidden" class="temp" name="" value="${StoreMsgFormMap.houseid}">
			<input type="hidden" class="temp" name="" value="${StoreMsgFormMap.title}">
			

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">

				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">基础信息</h3>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属粮库:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"  name="StoreMsgFormMap.location" data-placeholder="所属粮库">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属仓号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectHouseid" data-rel="chosen" name="StoreMsgFormMap.houseid" data-placeholder="所属仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">作业标题:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectTitle" data-rel="chosen" data-placeholder="作业标题" name="StoreMsgFormMap.title">
								<option value=""></option>
								<option value="1">通风作业</option>
								<option value="2">熏蒸作业</option>
								<option value="3">冷却作业</option>
								<option value="4">降温作业</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">作业内容:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name="StoreMsgFormMap.content" value="${StoreMsgFormMap.content}" placeholder="作业内容">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">操作人:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="StoreMsgFormMap.operator"  value="${StoreMsgFormMap.operator }" placeholder="操作人">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">开始时间:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class=" inline laydate-icon  form-control " 
								name="StoreMsgFormMap.stime" value="${StoreMsgFormMap.stime}" placeholder="开始时间">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">结束时间:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text" class=" inline laydate-icon  form-control " 
								name="StoreMsgFormMap.etime" value="${StoreMsgFormMap.etime}" placeholder="结束时间">
						</div>
					</div>
				</div>





			</div>

	<div class="form-group col-md-12">
		<button type="button" class="btn btn-info bt-submit"
			onclick="_submit()">提交</button>
	</div>
	</form>
	</div>
	<script type="text/javascript">
		laydate({
			elem : '#start',
			event : 'focus'
		});


		$.ajax({
			url : rootPath + "/kcxx/locations.shtml",
			type : "post",
			async:false,
			data : {
				"source" : 1
			},
			success : function(rs) {
				var sel = document.getElementById("selectLocation");
				if (rs.success) {
					for ( var i = 0; i < rs.list.length; i++) {
						sel.add(new Option(rs.list[i].wName, rs.list[i].wNo))
					}
				}

			}
		})
			
	$("#selectLocation").on("change",function(event){
		var value=this.value//||"${BusinessAgreementFormMap.location}";
			if(!value){
			value="${StoreMsgFormMap.location}";
			var flag=true;
			}
		
			$.ajax({
				url : rootPath + "/businessManager/findHouses.shtml",
				type : "post",
				async:false,
				data : {
					"wno" :value
				},
				success : function(rs) {
				var sel = document.getElementById("selectHouseid");
				sel.innerHTML="<option value=''></option>"
			if(!flag)	$("#selectHouseid").chosen("destroy"); 
						flag=false;
				rs=JSON.parse(rs);
					if(rs.success){
						for ( var i = 0; i < rs.result.length; i++) {
							var ops=new Option(rs.result[i].wName, rs.result[i].id+","+rs.result[i].wName);
							if(rs.result[i].id=="${fn:split(StoreMsgFormMap.houseid,',')[0]}"){
							ops.selected=true;
							}
							sel.add(ops);
						}
						   
						    
						    $("#selectHouseid").chosen({no_results_text : "未找到此选项!",width:"100%"});
					}
				}
			})	
		}).trigger("change")	




		var autoSettingValue = (function() {
			var ls = []
			return function() {
				for ( var i = 0; i < document.forms[0].elements.length; i++) {
					if (document.forms[0].elements[i].type == "select-one") {
						ls.push(document.forms[0].elements[i]);
					}
				}
				return ls
			}

		})()
		var elem = autoSettingValue();
		var v = document.getElementsByClassName("temp");
		for ( var i = 0; i < elem.length; i++) {
			for ( var j = 0; j < elem[i].options.length; j++) {
				if (elem[i].options[j].value == v[i].value)
					elem[i].options[j].selected = true;

			}
		}

		$("#form").validate({
			submitHandler : function(form) {
				ly.ajaxSubmit(form, {
					type : "post",
					dataType : "json",
					success : function(data) {
						if (data) {
							alert('修改成功！', 3);
							setTimeout(function() {
								parent.layer.closeAll()
							}, 1000)
						} else {
							alert('修改失败！', 3);
						}
					}
				});
			},
			rules : {},
			messages : {
},
			errorPlacement : function(error, element) {
				if (element[0].classList.contains("error")) {
					element[0].style.cssText = "border: 1px solid #ff0000";
				} else if (element[0].classList.contains("valid")) {
					element[0].style.cssText = "";
				}

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
