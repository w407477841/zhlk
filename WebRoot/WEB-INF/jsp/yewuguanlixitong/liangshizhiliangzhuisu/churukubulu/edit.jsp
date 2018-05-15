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
		<form id="form1" name="form" method="post" action="${ctx}/rukuzhiliangxinxi/updateInstorage_tween.shtml">
			<input type="hidden" name="token" value="${token}">
			<input type="hidden" name="StorageFormMap.basicid" value="${ StorageFormMap.basicid}" >
			<input type="hidden" name="WeightingFormMap.basicid" value="${ StorageFormMap.wid}" >
			
			<input type="hidden" name="InstorageQualityFormMap.basicid" value="${ StorageFormMap.qid}" >
			
			
			<input type="hidden" class="temp" name="" value="${ StorageFormMap.inorout}">
			<input type="hidden" class="temp" name="" value="${ StorageFormMap.location}">
			<input type="hidden" class="temp" name="" value="${ StorageFormMap.storageid}">
			<input type="hidden" class="temp" name="" value="${ StorageFormMap.breed}">
			<input type="hidden" class="temp" name="" value="${ StorageFormMap.property}">
			
			
			<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
				<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">必填信息</h3>
		</div>
	</div>
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮户姓名:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Owner" value="${ StorageFormMap.OWNER}" placeholder="粮户姓名">
						</div>
					</div>
			</div>
			
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">身份证号:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Identity" value="${StorageFormMap.Identity }" placeholder="身份证号">
						</div>
					</div>
			</div>
			
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">手机号码:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Phone" value="${StorageFormMap.phone }" placeholder="手机号码">
						</div>
					</div>
			</div>	
			
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">地址:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.Address" value="${StorageFormMap.address }" placeholder="地址">
						</div>
					</div>
			</div>
			<div class="form-group col-md-6">
					<div class="col-md-3 div_label">车船号:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" class="form-control"name="StorageFormMap.CarID" value="${StorageFormMap.carid }" placeholder="地址">
						</div>
					</div>
			</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">出入库:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="" data-rel="chosen" class="chosen form-control" data-placeholder="出入库" name="StorageFormMap.inorout">
								<option value=""></option>
								<option value="1" selected="selected">入库</option>
								<option value="0">出库</option>
							</select>
						</div>
					</div>
				</div>
				
								<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属粮库:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectLocation" data-rel="chosen"  name="StorageFormMap.location" data-placeholder="所属粮库">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">所属仓号:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectHouseid" data-rel="chosen" name="StorageFormMap.StorageID" data-placeholder="所属仓号">
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>		
			
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食品种:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectBreed" data-rel="chosen" data-placeholder="粮食品种" name="StorageFormMap.Breed">
								<option value=""></option>
								<option value="1114" selected="selected">混合小麦</option>
								<option value="1132002">晚粳稻谷</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-group col-md-6">
					<div class="col-md-3 div_label">粮食性质:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<select id="selectProperty" data-rel="chosen" data-placeholder="粮食性质" name="StorageFormMap.Property">
								<option value=""></option>
								<option  value="31">最低收购价粮</option>
								<option value="11">国家储备粮</option>
								<option value="121">省级储备粮</option>
								<option value="122">地市级储备粮</option>
								<option value="123">县级储备粮</option>
								<option value="2">商品粮</option>
								<option value="34">地方临时存储粮 </option>
							</select>
						</div>
					</div>
				</div>
				


				</div>	
	<div class="form-group col-md-12" style="border: 1px dashed; padding: 10px;margin: 10px 0">
	<div class=" col-md-12">
		<div class=" col-md-6">
			<h3 class="animated rubberBand">质检信息录入</h3>
		</div>
	</div>
	<div class=" col-md-12" style="margin-bottom: 15px">
	 <table id="magazineGrid"  style="width:99%;height:70px"></table>
	</div>
	
			<div class="form-group col-md-4">
					<div class="col-md-3 div_label">收购价格(元):</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="price" class="form-control"name=""  value="${StorageFormMap.Price}" placeholder="收购价格">
						</div>
					</div>
				</div>
			<div class="form-group col-md-4">
					<div class="col-md-3 div_label">等级:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="level" class="form-control"name="" disabled="disabled" value="3" placeholder="等级">
						</div>
					</div>
				</div>
				
			<div class="form-group col-md-4">
					<div class="col-md-3 div_label">扣量百分比:</div>
					<div class="col-md-9">
						<div class="has-warning">
							<input type="text" id="percentage" class="form-control"name="" disabled="disabled" value="0.00" placeholder="总扣量">
						</div>
					</div>
				</div>
				
				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">毛重:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" id="percentage" class="form-control col-md-4"name="WeightingFormMap.TotalWeight"  value="${StorageFormMap.totalweight }" placeholder="总重量">
						</div>
					</div>
				</div>

				<div class="form-group col-md-4">
					<div class="col-md-3 div_label">皮重:</div>
					<div class="col-md-9">
						<div class="has-warning">
						<input type="text" id="percentage" class="form-control col-md-4"name="WeightingFormMap.CarWeight"  value="${StorageFormMap.carweight }" placeholder="总重量">
						</div>
					</div>
				</div>
				
				
	</div>			
				
								

			<div class="form-group col-md-12" style="text-align: center;">
				<button type="button" class="btn btn-info bt-submit"onclick="_s()">提交</button>
			</div>
		</form>
	</div>
</body>

<script type="text/javascript">

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
			value="${StorageFormMap.location}";
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
							if(rs.result[i].id=="${fn:split(StorageFormMap.storageid,',')[0]}"){
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
		
$("#form1").validate({
	submitHandler : function(form) {

		let
		columnData = $('#magazineGrid').datagrid('getData').rows[0];
		columnData.price = $("#price").val();
		columnData.level = $("#level").val();
		columnData.amountPercent = $("#percentage").val();
		
		var obj = new Object();
		Object.keys(columnData).forEach(function(index) {
			obj["InstorageQualityFormMap." + index] = columnData[index];
		})
		
		
		ly.ajaxSubmit(form, {
			type : "post",
			dataType : "json",
			data : obj,
			success : function(data) {
				if (data) {
					alert('添加成功！', 3);
					setTimeout(function() {
						parent.layer.closeAll()
					}, 1000)
				} else {
					alert('添加失败！', 3);
				}
			}
		});
	},
	rules : {
		"StorageFormMap.Owner" : {
			required : true
		},
		"StorageFormMap.Identity" : {
			required : true
		},
		"StorageFormMap.Phone" : {
			required : true
		},
		"StorageFormMap.Address" : {
			required : true
		},
		"StorageFormMap.CarID" : {
			required : true
		}

	},
	messages : {},
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
				function _s() {
			$("#form1").submit();
		}
		
</script>
<script type="text/javascript" src="${ctx}/js/storage/register_add.js"></script>
</html>
