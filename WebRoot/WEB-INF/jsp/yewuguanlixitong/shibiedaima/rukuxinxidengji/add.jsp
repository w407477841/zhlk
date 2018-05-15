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
		<form id="form" name="form" method="post" action="${ctx}/rukuxinxidengji/add.shtml">
			<input type="hidden" name="token" value="${token}">
			<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
			
				<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">基础信息</h3>
		</div>
	</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">货位代码:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="" type="text" class=" form-control " 
								name="InRegisterFormMap.code" value="" placeholder="货位代码">
						</div>
					</div>
				</div>	

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">货位名称:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="" type="text" class=" form-control " 
								name="InRegisterFormMap.codeName" value="" placeholder="货位名称">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">生成时间:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class=" inline laydate-icon  form-control " 
								name="InRegisterFormMap.bornDate" value="" placeholder="生成时间">
						</div>
					</div>
				</div>	
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">直储/代储:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="" data-rel="chosen" data-placeholder="直储/代储" name="InRegisterFormMap.storageWay">
								<option value=""></option>
								<option value="0">直储</option>
								<option value="1">代储</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食品种" name="InRegisterFormMap.breed">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食性质:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectProperty" data-rel="chosen" data-placeholder="粮食性质" name="InRegisterFormMap.property">
								<option value=""></option>
								
							</select>
						</div>
					</div>
				</div>
				
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">数量:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="amounts" type="text" class=" form-control " 
								name="InRegisterFormMap.amounts" value="" placeholder="数量">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮权归属机构:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="" type="text" class=" form-control " 
								name="InRegisterFormMap.institution" value="" placeholder="粮权归属机构">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">等级:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLevel" data-rel="chosen" data-placeholder="等级" name="InRegisterFormMap.level">
								<option value=""></option>
								<option value="1">1级</option>
								<option value="2">2级</option>
								<option value="3">3级</option>
								<option value="4">4级</option>
								<option value="5">5级</option>
								<option value="0">等级外</option>
								
							</select>
						</div>
					</div>
				</div>

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">产地名称:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="" type="text" class=" form-control " 
								name="InRegisterFormMap.bornPlace" value="" placeholder="产地名称">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">年份:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="" type="text" class=" form-control " 
								name="InRegisterFormMap.bornYear" value="" placeholder="年份">
						</div>
					</div>
				</div>
				
				

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">入库时间:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text" class=" inline laydate-icon  form-control " 
								name="InRegisterFormMap.inDate" value="" placeholder="入库时间">
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
			format:'YYYY-MM-DD hh:mm:ss'
		});



		$.ajax({
			url : rootPath + "/kcxx/breeds.shtml",
			type : "post",
			async:false,
			success : function(rs) {
				var sel = document.getElementById("selectBreed");
				if (rs.success) {
					for ( var i = 0; i < rs.list.length; i++) {
						sel.add(new Option(rs.list[i].text, rs.list[i].id))
					}
				}

			}
		})
		
		$.ajax({
			url : rootPath + "/kcxx/properties.shtml",
			type : "post",
			async:false,
			success : function(rs) {
				var sel = document.getElementById("selectProperty");
				if (rs.success) {
					for ( var i = 0; i < rs.list.length; i++) {
						sel.add(new Option(rs.list[i].text, rs.list[i].id))
					}
				}

			}
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
								"InRegisterFormMap.code" : {required : true},
								"InRegisterFormMap.codeName" : {required : true},
								"InstorageQualityFormMap.bornDate" : {required : true},
								"InstorageQualityFormMap.amounts" : {required : true},
								"InstorageQualityFormMap.institution" : {required : true},
								"InstorageQualityFormMap.level" : {required : true},
								"InstorageQualityFormMap.bornPlace" : {required : true},
								"InstorageQualityFormMap.inDate" : {required : true}
								
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
