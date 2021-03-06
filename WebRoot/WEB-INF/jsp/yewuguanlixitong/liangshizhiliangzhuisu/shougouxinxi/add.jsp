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
.laydate-icon{
height: 38px;
line-height: 38px
}
.div_lable1{
text-align: center; height: 56px;line-height: 56px
}
.form-control{
padding: 0px 12px
}
.form-control{
padding: 0px 12px
}
</style>
</head>
<body style="background-color:#d9edf7">
	<div class=" col-md-12">
		<form id="form" name="form" method="post" action="${ctx}/shougouxinxi/addBuyMsg.shtml">
			<input type="hidden" name="token" value="${token}">
			<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
			
				<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">基础信息</h3>
		</div>
	</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">收购单位:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="BuyMsgFormMap.company" placeholder="收购单位">
						</div>
					</div>
				</div>
				
				
<!-- 				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属粮库:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"  name="BuyMsgFormMap.location" data-placeholder="所属粮库">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属仓号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectHouseid" data-rel="chosen" name="BuyMsgFormMap.houseid" data-placeholder="所属仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div> -->
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食品种" name="BuyMsgFormMap.breed">
								<option value=""></option>
								<option value="1114">混合小麦</option>
								<option value="1132002">晚粳稻谷</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食等级:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食等级" name="BuyMsgFormMap.level">
								<option value=""></option>
								<option value="一级">一级</option>
								<option value="二级">二级</option>
								<option value="三级">三级</option>
								<option value="四级">四级</option>
								<option value="五级">五级</option>
								<option value="等级外">等级外</option>
							</select>
						</div>
					</div>
				</div>


				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">货主姓名:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="BuyMsgFormMap.name" placeholder="货主姓名">
						</div>
					</div>
				</div>
				

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">车船号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name="BuyMsgFormMap.carid" placeholder="车船号">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">收购重量:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name="BuyMsgFormMap.weights" placeholder="收购重量">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单价:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="BuyMsgFormMap.price"  placeholder="单价">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">收购日期:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class=" inline laydate-icon  form-control " 
								name="BuyMsgFormMap.dates" value="" placeholder="收购日期">
						</div>
					</div>
				</div>


				</div>	
				
				
		

			<div class="form-group col-md-12" style="text-align: center;">
				<button type="button" class="btn btn-info bt-submit"onclick="_submit()">提交</button>
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
	var value=this.value;
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
			$("#selectHouseid").chosen("destroy"); 
			rs=JSON.parse(rs);
				if(rs.success){
					for ( var i = 0; i < rs.result.length; i++) {
						sel.add(new Option(rs.result[i].wName, rs.result[i].id+","+rs.result[i].wName))
					}
					    $("#selectHouseid").chosen({no_results_text : "未找到此选项!",width:"100%"});
				}
			}
		})	
	})	
		

		$("#form").validate({
		submitHandler : function(form) {
								ly.ajaxSubmit(form, {
									type : "post",
									dataType : "json",
									success : function(data) {
										if (data) {
											alert('添加成功！', 3);
											setTimeout(function(){parent.layer.closeAll()},1000)
										} else {
											alert('添加失败！', 3);
										}
									}
								});
							},
							rules : {
								"BuyMsgFormMap.carid" : {required : true},
								"BuyMsgFormMap.weights" : {required : true,number : true},
								"BuyMsgFormMap.price" : {required : true,number : true},
								"BuyMsgFormMap.dates" : {required : true}
								
							},
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

		//验证select
		function vaildateSelects() {
			var eles = document.forms[0].elements;
			var ids = [];
			var j = 0
			for ( var i = 0; i < eles.length; i++) {
				if (eles[i].type == "select-one"&&eles[i].id) {
					ids.push(eles[i].id + "_chosen");
				}
			}
			ids.forEach(function(str, index) {
						var t = document.getElementById(str).children[0].children[0].textContent;
						var n = document.getElementById(str.replace("_chosen","")).dataset.placeholder;
						document.getElementById(str).children[0].style.removeProperty("border");
						if (t == "" || t == n) {
							j++;
							document.getElementById(str).scrollIntoView();
							document.getElementById(str).children[0].style.setProperty("border", "1px solid #ff0000");
							return false
						}
					})
			return !!!j
		}

		function _submit() {
			if (typeof vaildateSelects == "function"&& vaildateSelects.call(null))
				$("#form").submit();
		}
	</script>
</body>
</html>
