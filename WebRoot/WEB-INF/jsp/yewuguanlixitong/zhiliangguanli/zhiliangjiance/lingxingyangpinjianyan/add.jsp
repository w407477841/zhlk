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
		<form id="form" name="form" method="post" action="${ctx}/lingxingyangpinjianyan/addInstanceMsg.shtml">
			<input type="hidden" name="token" value="${token}">
			
			<input type="hidden" name="InstanceMsgFormMap.inorout" value="3"> </input>
			
			<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
			
				<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">基础信息</h3>
		</div>
	</div>
				
											<div class="form-group col-md-6">
					<div class="col-md-3 div_label">样品来源:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstanceMsgFormMap.source"   placeholder="样品来源">
						</div>
					</div>
				</div>
 
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食品种" name="InstanceMsgFormMap.breed">
								<option value=""></option>
								<option value="1114">混合小麦</option>
								<option value="1132002">晚粳稻谷</option>
							</select>
						</div>
					</div>
				</div>

				
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">代表数量:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="amounts" type="text" class=" form-control " 
								name="InstanceMsgFormMap.amounts" value="" placeholder="代表数量">
						</div>
					</div>
				</div>
				
				

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">检验日期:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class=" inline laydate-icon  form-control " 
								name="InstanceMsgFormMap.dates" value="" placeholder="检验日期">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">生产年度:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text" class=" inline laydate-icon  form-control " 
								name="InstanceMsgFormMap.bornDate" value="" placeholder="生产年度">
						</div>
					</div>
				</div>

				</div>	
				
	<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
			
				<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">质检信息</h3>
		</div>
	</div>
	
					<div class="form-group col-md-4">
					<div class="col-md-3 div_label">水分(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Sf"  value="" placeholder="水分">
						</div>
					</div>
				</div>
				
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">杂质(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Zz"  value="" placeholder="杂质">
						</div>
					</div>
				</div>
				
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">出糙(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.CCL"  value="" placeholder="出糙">
						</div>
					</div>
				</div>
						<div class="form-group col-md-4">
					<div class="col-md-3 div_label">不完善度(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Bwsld"  value="" placeholder="不完善粒度">
						</div>
					</div>
				</div>
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">谷外糙米(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Gwcm"  value="" placeholder="谷外糙米">
						</div>
					</div>
				</div>
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">容重(g/l):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Rz"  value="" placeholder="容重">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">黄粒:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Hl"  value="" placeholder="黄粒">
						</div>
					</div>
				</div>
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">整精米粒:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Zjml"  value="" placeholder="整精米粒">
						</div>
					</div>
				</div>
				

				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">备注:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<textarea type="text" class=" form-control "name="InstanceMsgFormMap.comment"  value="" placeholder="备注"></textarea>
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
			event : 'focus',
			format:'YYYY-MM-DD hh:mm:ss'
		});		laydate({
			elem : '#start1',
			event : 'focus',
			format:'YYYY'
		});


		
		

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
								"InstanceMsgFormMap.source" : {required : true}
								
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
