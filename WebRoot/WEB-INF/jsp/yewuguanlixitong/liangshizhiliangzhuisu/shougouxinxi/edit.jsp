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
			action="${ctx}/shougouxinxi/editBuyMsg.shtml">
			<input type="hidden" name="token" value="${token}"> 
			<input type="hidden" name="BuyMsgFormMap.id" value="${BuyMsgFormMap.id}"> 
			
			<input type="hidden" class="temp" name="" value="${BuyMsgFormMap.breed}">
			<input type="hidden" class="temp" name="" value="${BuyMsgFormMap.level}">
			

			<div class="form-group col-md-12"
				style="border: 1px dashed; padding: 10px;margin: 10px 0">

				<div class=" col-md-12">
					<div class=" col-md-6">
						<h3 class="animated rubberBand">基础信息</h3>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">收购单位:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control"name="BuyMsgFormMap.company" placeholder="收购单位" value="${ BuyMsgFormMap.company}">
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
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食品种" name="BuyMsgFormMap.breed" value="${BuyMsgFormMap.breed }">
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
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食等级" name="BuyMsgFormMap.level" value="${BuyMsgFormMap.level }">
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
							<input type="text" class="form-control"name="BuyMsgFormMap.name" placeholder="货主姓名" value="${BuyMsgFormMap.name }">
						</div>
					</div>
				</div>
				

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">车船号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name="BuyMsgFormMap.carid" placeholder="车船号" value="${BuyMsgFormMap.carid }">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">收购重量:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class="form-control" name="BuyMsgFormMap.weights" placeholder="收购重量" value="${BuyMsgFormMap.weights }">
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">单价:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="BuyMsgFormMap.price"  placeholder="单价" value="${BuyMsgFormMap.price }">
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">收购日期:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class=" inline laydate-icon  form-control " 
								name="BuyMsgFormMap.dates"  value="${BuyMsgFormMap.dates }" placeholder="收购日期">
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
