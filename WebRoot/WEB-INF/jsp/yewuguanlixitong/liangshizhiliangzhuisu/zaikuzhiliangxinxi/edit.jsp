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
		<form id="form" name="form" method="post" action="${ctx}/zaikuzhiliangxinxi/editInstanceMsg.shtml">
			<input type="hidden" name="token" value="${token}"> 
			<input type="hidden" name="InstanceMsgFormMap.id" value="${InstanceMsgFormMap.id}"> 
			<input type="hidden" name="InstorageQualityFormMap.basicid" value="${InstanceMsgFormMap.wid}"> 
			
			<input type="hidden" class="temp" name="" value="${InstanceMsgFormMap.location}">
			<input type="hidden" class="temp" name="" value="${InstanceMsgFormMap.houseid}">
			<input type="hidden" class="temp" name="" value="${InstanceMsgFormMap.Level}">

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
							<select id="selectLocation" data-rel="chosen"  name="InstanceMsgFormMap.location" data-placeholder="所属粮库">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属仓号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectHouseid" data-rel="chosen" name="InstanceMsgFormMap.houseid" data-placeholder="所属仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
						<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input id="selectBreed" type="text" class=" form-control "  
							name="InstanceMsgFormMap.breed" readonly="readonly"   value="${InstanceMsgFormMap.breed}" placeholder="粮食品种">
						</div>
					</div>
				</div>
				
								
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食性质:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="selectProperty" type="text" class=" form-control "  
							name="InstanceMsgFormMap.property" readonly="readonly"    value="${InstanceMsgFormMap.property}" placeholder="粮食性质">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">代表数量:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="amounts" type="text" class=" form-control "  
							name="InstanceMsgFormMap.amounts" readonly="readonly"   value="${InstanceMsgFormMap.amounts}" placeholder="代表数量">
						</div>
					</div>
				</div>
				
				

				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">检验日期:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start" type="text" class=" inline laydate-icon  form-control " 
								name="InstanceMsgFormMap.dates" value="${InstanceMsgFormMap.dates }" placeholder="检验日期">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">生产年度:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input id="start1" type="text" class=" inline laydate-icon  form-control " 
								name="InstanceMsgFormMap.bornDate" value="${ InstanceMsgFormMap.bornDate}" placeholder="生产年度">
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
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Sf"  value="${InstanceMsgFormMap.sf}" placeholder="水分">
						</div>
					</div>
				</div>
				
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">杂质(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Zz"  value="${InstanceMsgFormMap.Zz }" placeholder="杂质">
						</div>
					</div>
				</div>
				
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">出糙(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.CCL"  value="${InstanceMsgFormMap.CCL }" placeholder="出糙">
						</div>
					</div>
				</div>
						<div class="form-group col-md-4">
					<div class="col-md-3 div_label">不完善度(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Bwsld"  value="${InstanceMsgFormMap.Bwsld }" placeholder="不完善粒度">
						</div>
					</div>
				</div>
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">谷外糙米(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Gwcm"  value="${ InstanceMsgFormMap.Gwcm}" placeholder="谷外糙米">
						</div>
					</div>
				</div>
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">容重(g/l):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Rz"  value="${InstanceMsgFormMap.Rz }" placeholder="容重">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">黄粒(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Hl"  value="${InstanceMsgFormMap.Hl }" placeholder="黄粒">
						</div>
					</div>
				</div>
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">整精米粒(%):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Zjml"  value="${ InstanceMsgFormMap.Zjml}" placeholder="整精米粒">
						</div>
					</div>
				</div>
									<div class="form-group col-md-4">
					<div class="col-md-3 div_label">色泽气温:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Szqw"  value="${InstanceMsgFormMap.Szqw }" placeholder="色泽气温">
						</div>
					</div>
				</div>
				
				
								<div class="form-group col-md-4">
					<div class="col-md-3 div_label">脂肪酸值:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstorageQualityFormMap.Zfsz"  value="${InstanceMsgFormMap.Zfsz}" placeholder="脂肪酸值">
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">检验单位:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" class=" form-control "name="InstanceMsgFormMap.department"  value="${InstanceMsgFormMap.department }" placeholder="检验单位">
						</div>
					</div>
				</div>
				
			<div class="form-group col-md-4">
					<div class="col-md-3 div_label">等级:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<select id="selectLevel" data-rel="chosen" data-placeholder="选择等级" name="InstorageQualityFormMap.Level">
								<option value="1">一级</option>
								<option value="2">二级</option>
								<option value="3">三级</option>
								<option value="4">四级</option>
								<option value="5">五级</option>
								<option value="6">等级外</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">备注:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<textarea type="text" class=" form-control "name="InstanceMsgFormMap.comment"  value="" placeholder="备注">${InstanceMsgFormMap.COMMENT}</textarea>
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
	var  formEnabled=true;
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
			value="${InstanceMsgFormMap.location}";
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
							if(rs.result[i].id=="${fn:split(InstanceMsgFormMap.houseid,',')[0]}"){
							ops.selected=true;
							}
							sel.add(ops);
						}
						   
						    
						    $("#selectHouseid").chosen({no_results_text : "未找到此选项!",width:"100%"});
					}
				}
			})	
		}).trigger("change")	

$("#selectHouseid").on("change",function(e){
	let houseid=this.value;
	let location=$("#selectLocation").val();
	
		$.ajax({
			url : rootPath + "/kcxx/weights.shtml",
			type : "post",
			async:false,
			data : {
				"houseid" : houseid,
				"location" : location
			},
			success : function(rs) {
			formEnabled=true;
			if(!!!rs.reslut) formEnabled=false;
			$("#amounts").val(rs.reslut&&rs.reslut.weight||0);
			$("#start1").val(rs.reslut&&rs.reslut.siYear);
			$("#selectProperty").val(rs.reslut&&rs.reslut.property);
			$("#selectBreed").val(rs.reslut&&rs.reslut.breed)
			}
		})
		
	})


		var autoSettingValue = (function() {
			var ls = []
			return function() {
				for ( var i = 0; i < document.forms[0].elements.length; i++) {
					if (document.forms[0].elements[i].type == "select-one") {
						ls.push(document.forms[0].elements[i]);
					}
				}
				return ls;
			}

		})();
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
						if(!formEnabled){
					layer.msg("该仓库存量为空!") ;return false;
				}
			$("#form").submit();
		}
	</script>
</body>
</html>
